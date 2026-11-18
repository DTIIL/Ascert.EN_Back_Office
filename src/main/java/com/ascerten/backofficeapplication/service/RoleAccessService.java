
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.config.AppModule;
import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.repository.MasterUserRoleRepository;
import com.ascerten.backofficeapplication.repository.UserRepository;
import com.ascerten.backofficeapplication.enums.SubscriberStatus;

import org.springframework.stereotype.Service;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

@Service
public class RoleAccessService {

    private static final Map<String, Set<AppModule>> GRANTS = Map.of(

            // Admin has access to all modules.
            "admin", EnumSet.allOf(AppModule.class),

            // User has access to all modules except User Management.
            "user", EnumSet.complementOf(
                    EnumSet.of(AppModule.USERS)
            )
    );

    private final UserRepository userRepository;
    private final MasterUserRoleRepository roleRepository;

    public RoleAccessService(
            UserRepository userRepository,
            MasterUserRoleRepository roleRepository) {

        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public boolean isActiveUser(User user) {
        return user != null
                && user.getStatus() != null
                && user.getStatus() == SubscriberStatus.ACTIVE.getCode();
    }

    public Optional<MasterUserRole> activeRole(User user) {

        if (user == null || user.getUserRole() == null) {
            return Optional.empty();
        }

        return roleRepository.findById(user.getUserRole())
                .filter(role -> role.getActive() != null
                        && role.getActive() == 1
                        && role.getUserRole() != null
                        && !role.getUserRole().isBlank());
    }

    public Optional<MasterUserRole> activeRoleForSessionUser(Long userId) {

        if (userId == null) {
            return Optional.empty();
        }

        return userRepository.findById(userId)
                .filter(this::isActiveUser)
                .flatMap(this::activeRole);
    }

    // Check whether the role is supported by the application.
    public boolean isSupportedRole(String roleName) {

        if (roleName == null || roleName.isBlank()) {
            return false;
        }

        return GRANTS.containsKey(
                roleName.trim().toLowerCase(Locale.ROOT)
        );
    }

    public boolean allows(String roleName, AppModule module) {

        if (roleName == null || module == null) {
            return false;
        }

        Set<AppModule> permissions = GRANTS.get(
                roleName.trim().toLowerCase(Locale.ROOT)
        );

        return permissions != null && permissions.contains(module);
    }

    public Optional<AppModule> moduleForPath(String path) {

        if (path == null || path.isBlank()) {
            return Optional.empty();
        }

        if (path.equals("/dashboard") || path.startsWith("/dashboard/")) {
            return Optional.of(AppModule.DASHBOARD);
        }

        if (path.equals("/qdsdmanager") || path.startsWith("/qdsdmanager/")) {
            return Optional.of(AppModule.QDSD_MANAGER);
        }

        if (path.equals("/factoryprovising")
                || path.startsWith("/factoryprovising/")) {
            return Optional.of(AppModule.FACTORY_PROVISIONING);
        }

        if (path.equals("/user") || path.startsWith("/user/")) {
            return Optional.of(AppModule.USERS);
        }

        if (path.equals("/report") || path.startsWith("/report/")) {
            return Optional.of(AppModule.REPORTS);
        }

        if (path.equals("/settings") || path.startsWith("/settings/")) {
            return Optional.of(AppModule.SETTINGS);
        }

        return Optional.empty();
    }

    public String homePath(String roleName) {

        if (allows(roleName, AppModule.DASHBOARD)) {
            return "/dashboard";
        }

        return "/access-denied";
    }
}
