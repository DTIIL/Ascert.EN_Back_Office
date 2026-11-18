
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.service.ReportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReportController {

    private final ReportService reportService;

    public ReportController(ReportService reportService) {
        this.reportService = reportService;
    }

    private void addUserDetails(Model model, HttpSession session) {
        model.addAttribute("userName",
                session.getAttribute("loggedInUserName"));
        model.addAttribute("userRole",
                session.getAttribute("loggedInRoleName"));
    }

    private void addReportDetails(
            Model model,
            HttpSession session,
            String title,
            String description,
            String reportType,
            Object reportRows) {

        addUserDetails(model, session);

        model.addAttribute("reportTitle", title);
        model.addAttribute("reportDescription", description);
        model.addAttribute("reportType", reportType);
        model.addAttribute("reportRows", reportRows);
    }

    @GetMapping("/report")
    public String showReports(Model model, HttpSession session) {

        addUserDetails(model, session);

        return "report";
    }

    // Provisioning Report
    @GetMapping("/report/provisioning")
    public String showProvisioningReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "Provisioning Report",
                "Filter the records below, or return to the report catalogue.",
                "provisioning",
                reportService.getQdsdReport()
        );

        return "report-detail";
    }

    // QDSD Usage Report
    @GetMapping("/report/qdsd-usage")
    public String showQdsdUsageReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "QDSD Usage Report",
                "View QDSD usage and activity information.",
                "usage",
                reportService.getQdsdUsageReport()
        );

        return "report-detail";
    }

    // Device Report
    @GetMapping("/report/device")
    public String showDeviceReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "Device Report",
                "View registered device information.",
                "device",
                reportService.getDeviceReport()
        );

        return "report-detail";
    }

    // Failure Report
    @GetMapping("/report/failure")
    public String showFailureReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "Failure Report",
                "View recorded failure events.",
                "failure",
                reportService.getFailureReport()
        );

        return "report-detail";
    }

    // DSC Download Report
    @GetMapping("/report/dsc-download")
    public String showDscDownloadReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "DSC Download Report",
                "View downloaded certificate information.",
                "download",
                reportService.getDscDownloadReport()
        );

        return "report-detail";
    }

    // Signing Report
    @GetMapping("/report/signing")
    public String showSigningReport(Model model, HttpSession session) {

        addReportDetails(
                model,
                session,
                "Signing Report",
                "View document signing information.",
                "signing",
                reportService.getSigningReport()
        );

        return "report-detail";
    }
}
