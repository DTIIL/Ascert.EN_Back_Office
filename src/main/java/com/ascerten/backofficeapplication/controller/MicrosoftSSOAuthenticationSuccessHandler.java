package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.service.AuthService;
import com.ascerten.backofficeapplication.service.RoleAccessService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class MicrosoftSSOAuthenticationSuccessHandler
        implements AuthenticationSuccessHandler {

    private static final int SESSION_TIMEOUT_SECONDS = 60 * 60;

    private static final Logger log =
            LoggerFactory.getLogger(MicrosoftSSOAuthenticationSuccessHandler.class);

    private final AuthService authService;
    private final RoleAccessService roleAccessService;

    public MicrosoftSSOAuthenticationSuccessHandler(
            AuthService authService,
            RoleAccessService roleAccessService) {

        this.authService = authService;
        this.roleAccessService = roleAccessService;
    }

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) throws IOException {

        // Get authenticated Microsoft user
        Object principal = authentication.getPrincipal();

        if (!(principal instanceof OidcUser oidcUser)) {
            denyAccess(request, response);
            return;
        }

        // Extract Microsoft identity claims
        String emailId = oidcUser.getEmail();

        if (emailId == null || emailId.isBlank()) {
            emailId = oidcUser.getPreferredUsername();
        }

        if (emailId == null || emailId.isBlank()) {
            denyAccess(request, response);
            return;
        }

        emailId = emailId.trim();

        // Validate Microsoft user against back-office database
        Optional<User> userOptional =
                authService.authenticateMicrosoft(emailId);

        if (userOptional.isEmpty()) {
            log.warn("Microsoft SSO rejected: database user validation failed");
            denyAccess(request, response);
            return;
        }

        User user = userOptional.get();

        // Verify that the user has an active role
        Optional<MasterUserRole> activeRole =
                roleAccessService.activeRoleForSessionUser(user.getId());

        if (activeRole.isEmpty()) {
            log.warn("Microsoft SSO rejected: active role validation failed");
            denyAccess(request, response);
            return;
        }

        String roleName = activeRole.get().getUserRole();

        // Do not invalidate the current session here.
        // Spring Security has already authenticated the Microsoft user.

        HttpSession session = request.getSession(true);

        // Session inactivity timeout
        session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);

        // Fixed one-hour expiration from login time
        session.setAttribute(
                "loginTime",
                System.currentTimeMillis()
        );

        // Store logged-in user details
        session.setAttribute("loggedInUserId", user.getId());
        session.setAttribute("loggedInUserName", user.getName());
        session.setAttribute("loggedInUsername", user.getUsername());

        // Store role information
        session.setAttribute("loggedInRole", user.getUserRole());
        session.setAttribute("loggedInRoleName", roleName);

        // Maintain dashboard compatibility
        session.setAttribute("loggedInUser", user.getName());

        // Redirect to role-based home page
        String homePath = roleAccessService.homePath(roleName);

        response.sendRedirect(request.getContextPath() + homePath);
    }

    // Reject Microsoft users who are not authorized for this back-office
    private void denyAccess(
            HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        // Clear Spring Security authentication
        SecurityContextHolder.clearContext();

        // Invalidate any existing session
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        // Redirect to login with an error indicator
        response.sendRedirect(
                request.getContextPath() + "/login?error=sso_rejected"
        );
    }
}