
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.service.AuthService;
import com.ascerten.backofficeapplication.service.RoleAccessService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.ascerten.backofficeapplication.entity.MasterUserRole;

import java.util.Optional;
import java.util.regex.Pattern;

@Controller
public class UserController {

    private static final long SESSION_TIMEOUT = 60 * 60 * 1000L;

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private final AuthService authService;
    private final RoleAccessService roleAccessService;

    public UserController(
            AuthService authService,
            RoleAccessService roleAccessService) {

        this.authService = authService;
        this.roleAccessService = roleAccessService;
    }

    @GetMapping("/")
    public String home(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (!isValidSession(session)) {
            return "redirect:/login";
        }

        return "redirect:" + homePath(session);
    }

    @GetMapping("/login")
    public String login(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (isValidSession(session)) {
            return "redirect:" + homePath(session);
        }

        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam(required = false) String emailId,
            @RequestParam(required = false) String password,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        boolean hasError = false;

        // Validate email.
        if (emailId == null || emailId.trim().isEmpty()) {

            redirectAttributes.addFlashAttribute(
                    "emailError",
                    "Please enter your email address."
            );

            hasError = true;

        } else if (!EMAIL_PATTERN.matcher(emailId.trim()).matches()) {

            redirectAttributes.addFlashAttribute(
                    "emailError",
                    "Please enter a valid email address."
            );

            hasError = true;
        }

        // Validate password.
        if (password == null || password.trim().isEmpty()) {

            redirectAttributes.addFlashAttribute(
                    "passwordError",
                    "Please enter your password."
            );

            hasError = true;
        }

        // Return to login if validation fails.
        if (hasError) {

            if (emailId != null) {
                redirectAttributes.addFlashAttribute(
                        "enteredEmail",
                        emailId.trim()
                );
            }

            return "redirect:/login";
        }

        String trimmedEmail = emailId.trim();

        return authService.authenticate(trimmedEmail, password)

                .map(user -> {

                    // Verify that the user account and assigned role are active.
                    Optional<MasterUserRole> activeRole =
                            roleAccessService.activeRoleForSessionUser(
                                    user.getId()
                            );

                    if (activeRole.isEmpty()) {

                        redirectAttributes.addFlashAttribute(
                                "loginError",
                                "Your account or assigned role is inactive."
                        );

                        redirectAttributes.addFlashAttribute(
                                "enteredEmail",
                                trimmedEmail
                        );

                        return "redirect:/login";
                    }

                    // Invalidate previous session.
                    HttpSession oldSession = request.getSession(false);

                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    // Create a fresh session.
                    HttpSession session = request.getSession(true);

                    // Set inactivity timeout to 60 minutes.
                    session.setMaxInactiveInterval(60 * 60);

                    // Store login time for existing fixed one-hour expiry.
                    session.setAttribute(
                            "loginTime",
                            System.currentTimeMillis()
                    );

                    // Store logged-in user details.
                    session.setAttribute("loggedInUserId", user.getId());
                    session.setAttribute("loggedInUserName", user.getName());
                    session.setAttribute("loggedInUsername", user.getUsername());

                    // Store role ID and role name.
                    session.setAttribute("loggedInRole", user.getUserRole());

                    roleAccessService.activeRole(user).ifPresent(role ->
                            session.setAttribute(
                                    "loggedInRoleName",
                                    role.getUserRole()
                            )
                    );

                    // Maintain dashboard compatibility.
                    session.setAttribute("loggedInUser", user.getName());

                    return "redirect:" + homePath(session);
                })

                .orElseGet(() -> {

                    redirectAttributes.addFlashAttribute(
                            "loginError",
                            "Invalid email address or password."
                    );

                    redirectAttributes.addFlashAttribute(
                            "enteredEmail",
                            trimmedEmail
                    );

                    return "redirect:/login";
                });
    }

    @PostMapping("/logout")
    public String logout(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        return "redirect:/login";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }

    // Check whether the user's session is valid.
    private boolean isValidSession(HttpSession session) {

        if (session == null) {
            return false;
        }

        Object userId = session.getAttribute("loggedInUserId");
        Object loginTime = session.getAttribute("loginTime");

        if (userId == null || !(loginTime instanceof Long)) {
            session.invalidate();
            return false;
        }

        long elapsedTime =
                System.currentTimeMillis() - (Long) loginTime;

        if (elapsedTime >= SESSION_TIMEOUT) {
            session.invalidate();
            return false;
        }

        return true;
    }

    private String homePath(HttpSession session) {

        Object roleName = session.getAttribute("loggedInRoleName");

        if (roleName instanceof String name && !name.isBlank()) {
            return roleAccessService.homePath(name);
        }

        return "/access-denied";
    }
}
