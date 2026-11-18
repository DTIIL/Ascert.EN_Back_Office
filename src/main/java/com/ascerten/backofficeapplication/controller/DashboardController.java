
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.dto.DashboardResponse;
import com.ascerten.backofficeapplication.service.DashboardService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        // Get user details from the validated session
        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        // Fetch dashboard data
        DashboardResponse dashboardData =
                dashboardService.getDashboardData();

        model.addAttribute("dashboardData", dashboardData);

        return "dashboard";
    }
}
