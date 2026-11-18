package com.ascerten.backofficeapplication.config;

import com.ascerten.backofficeapplication.service.RoleAccessService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class CurrentUserModelAdvice {

    private final RoleAccessService roleAccessService;

    public CurrentUserModelAdvice(RoleAccessService roleAccessService) {
        this.roleAccessService = roleAccessService;
    }

    @ModelAttribute
    public void addCurrentUser(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);

        if (session == null) {
            return;
        }

        Object roleNameValue = session.getAttribute("loggedInRoleName");

        if (!(roleNameValue instanceof String roleName)
                || roleName.isBlank()) {
            return;
        }

        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );
        model.addAttribute("userRole", roleName);

        model.addAttribute(
                "canDashboard",
                roleAccessService.allows(roleName, AppModule.DASHBOARD)
        );
        model.addAttribute(
                "canQdsd",
                roleAccessService.allows(roleName, AppModule.QDSD_MANAGER)
        );
        model.addAttribute(
                "canFactory",
                roleAccessService.allows(roleName, AppModule.FACTORY_PROVISIONING)
        );
        model.addAttribute(
                "canUsers",
                roleAccessService.allows(roleName, AppModule.USERS)
        );
        model.addAttribute(
                "canReports",
                roleAccessService.allows(roleName, AppModule.REPORTS)
        );
        model.addAttribute(
                "canSettings",
                roleAccessService.allows(roleName, AppModule.SETTINGS)
        );

        String path = request.getRequestURI()
                .substring(request.getContextPath().length());

        roleAccessService.moduleForPath(path).ifPresent(module ->
                model.addAttribute("activeModule", module.name())
        );
    }
}
