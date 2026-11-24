
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.dto.DashboardResponse;
import com.ascerten.backofficeapplication.service.DashboardService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/dashboard")
    public String dashboard(
            @RequestParam(required = false) String range,
            HttpSession session,
            Model model) {

        // Get user details from the validated session
        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        // Chart range in days (7, 14 or 30); anything else uses the default.
        int rangeDays = DashboardService.resolveRange(range);

        // Fetch dashboard data
        DashboardResponse dashboardData =
                dashboardService.getDashboardData(rangeDays);

        model.addAttribute("dashboardData", dashboardData);
        model.addAttribute("rangeDays", rangeDays);
        model.addAttribute("rangeOptions", DashboardService.RANGE_OPTIONS);

        return "dashboard";
    }
}
