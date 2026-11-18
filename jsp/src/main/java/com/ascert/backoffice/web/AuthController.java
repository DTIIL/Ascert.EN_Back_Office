package com.ascert.backoffice.web;

import com.ascert.backoffice.config.LoginInterceptor;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    @GetMapping("/")
    public String home(HttpSession session) {
        if (session.getAttribute(LoginInterceptor.SIGNED_IN) != null) {
            return "redirect:/dashboard";
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginForm(HttpSession session) {
        if (session.getAttribute(LoginInterceptor.SIGNED_IN) != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "password", required = false) String password,
            HttpSession session,
            Model model) {
        if (email == null && password == null) {
            session.setAttribute(LoginInterceptor.SIGNED_IN, Boolean.TRUE);
            return "redirect:/dashboard";
        }

        String emailError = emailError(email);
        String passwordError = password == null || password.trim().isEmpty() ? "Please enter your password" : null;
        if (emailError != null || passwordError != null) {
            model.addAttribute("emailError", emailError);
            model.addAttribute("passwordError", passwordError);
            model.addAttribute("loginEmail", email == null ? "" : email);
            return "login";
        }

        session.setAttribute(LoginInterceptor.SIGNED_IN, Boolean.TRUE);
        return "redirect:/dashboard";
    }

    private static String emailError(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "Please enter your email address";
        }
        if (!EMAIL.matcher(email.trim()).matches()) {
            return "Please enter a valid email address";
        }
        return null;
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "forgot-password";
    }
}
