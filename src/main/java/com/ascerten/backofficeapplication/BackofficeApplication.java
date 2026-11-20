package com.ascerten.backofficeapplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import com.ascerten.backofficeapplication.config.ApiConfigPaths;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

@SpringBootApplication
public class BackofficeApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(BackofficeApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(BackofficeApplication.class);
    }

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        applyContextConfigPath(servletContext);
        super.onStartup(servletContext);
    }

    /**
     * Copies Tomcat's {@code CONFIG_PATH_API} context parameter into
     * {@code API_CONFIG_PATH} only when that system property is still blank.
     * The context parameter is optional. The system property always wins.
     */
    public static void applyContextConfigPath(ServletContext servletContext) {
        String configured = System.getProperty(ApiConfigPaths.SYSTEM_PROPERTY);
        if (configured != null && !configured.isBlank()) {
            return;
        }
        String fromContext = servletContext.getInitParameter(ApiConfigPaths.CONTEXT_PARAM);
        if (fromContext != null && !fromContext.isBlank()) {
            System.setProperty(ApiConfigPaths.SYSTEM_PROPERTY, fromContext.trim());
        }
    }
}
