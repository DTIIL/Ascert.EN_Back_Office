
package com.ascerten.backofficeapplication.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ascerten.backofficeapplication.service.FactoryProvisioningService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/factoryprovising")
public class FactoryProvisioningController {

    private final FactoryProvisioningService factoryProvisioningService;

    public FactoryProvisioningController(
            FactoryProvisioningService factoryProvisioningService) {
        this.factoryProvisioningService = factoryProvisioningService;
    }

    @GetMapping
    public String factoryProvisioning(
            Model model,
            HttpSession session) {

        model.addAttribute("userName",
                session.getAttribute("loggedInUserName"));

        model.addAttribute("userRole",
                session.getAttribute("loggedInRoleName"));

        model.addAttribute("devices",
                factoryProvisioningService.getAllDevices());

        return "factory-provisioning";
    }

    @GetMapping("/{deviceId}")
    public String deviceDetails(
            @PathVariable String deviceId,
            Model model,
            HttpSession session) {

        model.addAttribute("userName",
                session.getAttribute("loggedInUserName"));

        model.addAttribute("userRole",
                session.getAttribute("loggedInRoleName"));

        model.addAttribute("device",
                factoryProvisioningService.getDevice(deviceId));

        return "factory-provisioning-details";
    }
}
