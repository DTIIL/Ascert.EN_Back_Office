package com.ascerten.backofficeapplication.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.boot.EnvironmentPostProcessor;
import org.springframework.boot.SpringApplication;
import org.springframework.core.Ordered;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.MutablePropertySources;

/**
 * Reads the three SSO settings from master_properties once at startup.
 * The table is not updated. Values are never logged.
 */
public class MasterSsoPropertiesEnvironmentPostProcessor implements EnvironmentPostProcessor, Ordered {

    public static final String PROPERTY_SOURCE_NAME = "masterSsoConfig";

    static final List<String> NAMES = List.of(
            "Sso_Client_Id",
            "Sso_Client_Secret",
            "Microsoft_Issuer_Uri"
    );

    private static final Map<String, String> NAME_TO_PROPERTY = Map.of(
            "Sso_Client_Id", "spring.security.oauth2.client.registration.sso.client-id",
            "Sso_Client_Secret", "spring.security.oauth2.client.registration.sso.client-secret",
            "Microsoft_Issuer_Uri", "spring.security.oauth2.client.provider.microsoft.issuer-uri"
    );

    private static final String QUERY = """
            SELECT name, value
            FROM public.master_properties
            WHERE status = 1
              AND name IN (?, ?, ?)
            """;

    @Override
    public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {

        Map<String, String> rows = readRows(
                requiredSetting(environment, "spring.datasource.url"),
                requiredSetting(environment, "spring.datasource.username"),
                requiredSetting(environment, "spring.datasource.password")
        );

        Map<String, Object> values = toSpringProperties(rows);

        MutablePropertySources sources = environment.getPropertySources();
        sources.remove(PROPERTY_SOURCE_NAME);
        sources.addFirst(new MapPropertySource(PROPERTY_SOURCE_NAME, values));
    }

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE + 1;
    }

    static Map<String, Object> toSpringProperties(Map<String, String> rows) {

        Map<String, Object> values = new LinkedHashMap<>();

        for (String name : NAMES) {
            String value = rows.get(name);

            if (value == null || value.isBlank()) {
                throw new IllegalStateException(
                        "Missing required master_properties name: " + name
                );
            }

            values.put(NAME_TO_PROPERTY.get(name), value);
        }

        return values;
    }

    private static Map<String, String> readRows(String url, String username, String password) {

        Map<String, String> rows = new LinkedHashMap<>();

        try {
            // Explicitly load PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");

            try (Connection connection = DriverManager.getConnection(url, username, password);
                 PreparedStatement statement = connection.prepareStatement(QUERY)) {

                statement.setString(1, NAMES.get(0));
                statement.setString(2, NAMES.get(1));
                statement.setString(3, NAMES.get(2));

                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        rows.putIfAbsent(
                                resultSet.getString("name"),
                                resultSet.getString("value")
                        );
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException ex) {
            throw new IllegalStateException(
                    "Could not read SSO settings from master_properties. "
                            + "Check that the database is reachable and the database user can select from public.master_properties. "
                            + "Cause: " + ex.getMessage(),
                    ex
            );
        }

        return rows;
    }

    private static String requiredSetting(ConfigurableEnvironment environment, String key) {

        String value = environment.getProperty(key);

        if (value == null || value.isBlank()) {
            throw new IllegalStateException(
                    "Database settings must be loaded before SSO settings can be read from master_properties."
            );
        }

        return value;
    }
}