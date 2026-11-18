
package com.ascerten.backofficeapplication.config;

import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.service.RoleAccessService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Optional;

@Component
public class AuthSessionInterceptor implements HandlerInterceptor {

    private final RoleAccessService roleAccessService;

    public AuthSessionInterceptor(RoleAccessService roleAccessService) {
        this.roleAccessService = roleAccessService;
    }

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler) throws Exception {

        String path = request.getRequestURI()
                .substring(request.getContextPath().length());

        // Allow public pages.
        if ("/login".equals(path)
                || "/".equals(path)
                || "/access-denied".equals(path)) {
            return true;
        }

        // Get existing session without creating a new one.
        HttpSession session = request.getSession(false);

        // Check whether session exists.
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Check logged-in user ID.
        Long userId = readUserId(
                session.getAttribute("loggedInUserId")
        );

        if (userId == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Fixed one-hour expiry from login time.
        Object loginTime = session.getAttribute("loginTime");

        if (!(loginTime instanceof Long)
                || System.currentTimeMillis() - (Long) loginTime
                >= 60 * 60 * 1000L) {

            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Check whether the user and assigned role are active.
        Optional<MasterUserRole> role =
                roleAccessService.activeRoleForSessionUser(userId);

        if (role.isEmpty()) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        String roleName = role.get().getUserRole();

        // Set sidebar permissions based on the logged-in user's role.
        request.setAttribute(
                "canDashboard",
                roleAccessService.allows(roleName, AppModule.DASHBOARD)
        );

        request.setAttribute(
                "canQdsd",
                roleAccessService.allows(roleName, AppModule.QDSD_MANAGER)
        );

        request.setAttribute(
                "canFactory",
                roleAccessService.allows(roleName, AppModule.FACTORY_PROVISIONING)
        );

        request.setAttribute(
                "canUsers",
                roleAccessService.allows(roleName, AppModule.USERS)
        );

        request.setAttribute(
                "canReports",
                roleAccessService.allows(roleName, AppModule.REPORTS)
        );

        request.setAttribute(
                "canSettings",
                roleAccessService.allows(roleName, AppModule.SETTINGS)
        );

        // Set the active sidebar module.
        String activeModule = roleAccessService.moduleForPath(path)
                .map(Enum::name)
                .orElse("");

        request.setAttribute("activeModule", activeModule);

        // Update role details in session from the database.
        session.setAttribute("loggedInRole", role.get().getId());
        session.setAttribute("loggedInRoleName", roleName);

        // Check whether the requested URL belongs to a known module.
        Optional<AppModule> module =
                roleAccessService.moduleForPath(path);

        // Allow only explicitly recognized module URLs.
        // Unknown URLs are denied by default.
        if (module.isEmpty() && !"/logout".equals(path)) {

            response.sendRedirect(
                    request.getContextPath() + "/access-denied"
            );

            return false;
        }

        // Check whether the user has permission for the requested module.
        if (module.isPresent()
                && !roleAccessService.allows(roleName, module.get())) {

            response.sendRedirect(
                    request.getContextPath() + "/access-denied"
            );

            return false;
        }

        return true;
    }

    private Long readUserId(Object value) {

        if (value instanceof Long id) {
            return id;
        }

        if (value instanceof Number id) {
            return id.longValue();
        }

        return null;
    }
}
