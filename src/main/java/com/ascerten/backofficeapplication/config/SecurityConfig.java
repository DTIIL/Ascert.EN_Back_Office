package com.ascerten.backofficeapplication.config;

import com.ascerten.backofficeapplication.controller.MicrosoftSSOAuthenticationSuccessHandler;

import jakarta.servlet.DispatcherType;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;

@Configuration
public class SecurityConfig {

    private final MicrosoftSSOAuthenticationSuccessHandler
            microsoftSSOAuthenticationSuccessHandler;

    public SecurityConfig(
            MicrosoftSSOAuthenticationSuccessHandler
                    microsoftSSOAuthenticationSuccessHandler) {

        this.microsoftSSOAuthenticationSuccessHandler =
                microsoftSSOAuthenticationSuccessHandler;
    }

    // SecurityContext storage using HTTP session
    @Bean
    public SecurityContextRepository securityContextRepository() {

        return new HttpSessionSecurityContextRepository();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http)
            throws Exception {

        http

                // Configure SecurityContext persistence
                .securityContext(context ->
                        context.securityContextRepository(
                                securityContextRepository()
                        )
                )

                // Authorization rules
                .authorizeHttpRequests(auth -> auth

                        // Allow internal JSP forwards and error dispatches
                        .dispatcherTypeMatchers(
                                DispatcherType.FORWARD,
                                DispatcherType.ERROR
                        ).permitAll()

                        // Public pages and static resources
                        .requestMatchers(
                                "/",
                                "/login",
                                "/access-denied",
                                "/css/**",
                                "/js/**",
                                "/assets/**",
                                "/images/**",
                                "/favicon.ico",
                                "/error"
                        ).permitAll()

                        // OAuth2 endpoints
                        .requestMatchers(
                                "/oauth2/**",
                                "/login/oauth2/**"
                        ).permitAll()

                        // Protect all remaining requests
                        .anyRequest().authenticated()
                )

                // Disable default Spring login form
                .formLogin(form -> form.disable())

                // Microsoft OAuth2 login
                .oauth2Login(oauth2 -> oauth2
                        .loginPage("/login")
                        .successHandler(
                                microsoftSSOAuthenticationSuccessHandler
                        )
                )

                // Disable HTTP Basic
                .httpBasic(basic -> basic.disable())

                // Use our custom logout controller
                .logout(logout -> logout.disable());

        return http.build();
    }
}