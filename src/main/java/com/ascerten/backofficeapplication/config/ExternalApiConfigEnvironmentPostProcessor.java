package com.ascerten.backofficeapplication.config;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.springframework.boot.EnvironmentPostProcessor;
import org.springframework.boot.SpringApplication;
import org.springframework.core.Ordered;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.MutablePropertySources;

/**
 * Loads the three datasource keys from the external API config file.
 * Other keys are ignored. The password and file contents are never logged.
 */
public class ExternalApiConfigEnvironmentPostProcessor implements EnvironmentPostProcessor, Ordered {

    public static final String PROPERTY_SOURCE_NAME = "externalApiConfig";

    static final List<String> REQUIRED_KEYS = List.of(
            "spring.datasource.url",
            "spring.datasource.username",
            "spring.datasource.password");

    @Override
    public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {
        Path path = Path.of(ApiConfigPaths.resolve());
        if (!Files.isRegularFile(path) || !Files.isReadable(path)) {
            throw unreadable(path);
        }

        Properties loaded = new Properties();
        try (Reader reader = Files.newBufferedReader(path, StandardCharsets.UTF_8)) {
            loaded.load(reader);
        }
        catch (IOException ex) {
            throw unreadable(path);
        }

        Map<String, Object> values = new LinkedHashMap<>();
        for (String key : REQUIRED_KEYS) {
            String value = loaded.getProperty(key);
            if (value == null || value.isBlank()) {
                throw new IllegalStateException("Missing required external API config key: " + key);
            }
            values.put(key, value);
        }

        MutablePropertySources sources = environment.getPropertySources();
        sources.remove(PROPERTY_SOURCE_NAME);
        sources.addFirst(new MapPropertySource(PROPERTY_SOURCE_NAME, values));
    }

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE;
    }

    private static IllegalStateException unreadable(Path path) {
        return new IllegalStateException(
                "External API config file is missing or not readable: " + path
                        + ". Create the file and grant the Tomcat user read access (chown and chmod 600).");
    }
}
