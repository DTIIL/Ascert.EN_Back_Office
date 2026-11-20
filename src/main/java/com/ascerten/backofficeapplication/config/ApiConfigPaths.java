package com.ascerten.backofficeapplication.config;

/**
 * Resolves the external API config file. Environment variables are never read.
 * A non-blank {@code API_CONFIG_PATH} system property wins; otherwise the
 * default server path is used. Tomcat's context parameter is copied into that
 * system property by {@code BackofficeApplication} before the context starts.
 */
public final class ApiConfigPaths {

    public static final String SYSTEM_PROPERTY = "API_CONFIG_PATH";

    public static final String CONTEXT_PARAM = "CONFIG_PATH_API";

    public static final String DEFAULT_PATH = "/etc/backoffice-application/api.properties";

    private ApiConfigPaths() {
    }

    public static String resolve() {
        String configured = System.getProperty(SYSTEM_PROPERTY);
        if (configured == null || configured.isBlank()) {
            return DEFAULT_PATH;
        }
        return configured.trim();
    }
}
