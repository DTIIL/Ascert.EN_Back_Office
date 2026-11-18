
package com.ascerten.backofficeapplication.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final AuthSessionInterceptor authSessionInterceptor;

    public WebMvcConfig(AuthSessionInterceptor authSessionInterceptor) {
        this.authSessionInterceptor = authSessionInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(authSessionInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/",
                        "/login",
                        "/access-denied",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/assets/**",
                        "/favicon.ico",
                        "/error"
                );
    }
}
