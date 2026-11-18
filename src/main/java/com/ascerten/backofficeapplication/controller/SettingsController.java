
package com.ascerten.backofficeapplication.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SettingsController {

    @GetMapping("/settings")
    public String settings(HttpSession session, Model model) {

        // Get logged-in user details from the session
        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        // Preference defaults for initial display.
        // These will later be loaded from the database.
        model.addAttribute("emailAlerts", true);
        model.addAttribute("dailyDigest", false);
        model.addAttribute("sessionLockEnabled", true);

        return "settings";
    }
}
