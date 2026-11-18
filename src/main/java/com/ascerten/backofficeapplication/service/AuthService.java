
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.repository.UserRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final RoleAccessService roleAccessService;

    public AuthService(
            UserRepository userRepository,
            RoleAccessService roleAccessService) {

        this.userRepository = userRepository;
        this.roleAccessService = roleAccessService;
    }

    public Optional<User> authenticate(String emailId, String password) {

        // Backend input validation
        if (emailId == null || emailId.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            return Optional.empty();
        }

        // Find user by email address
        Optional<User> userOptional =
                userRepository.findByEmailIdIgnoreCase(emailId.trim());

        if (userOptional.isEmpty()) {
            return Optional.empty();
        }

        User user = userOptional.get();

        // Validate password
        if (!password.equals(user.getPassword())) {
            return Optional.empty();
        }

        // Validate active user
        if (!roleAccessService.isActiveUser(user)) {
            return Optional.empty();
        }

        // Validate active role
        Optional<MasterUserRole> roleOptional =
                roleAccessService.activeRole(user);

        if (roleOptional.isEmpty()) {
            return Optional.empty();
        }

        // Reject unsupported roles
        String roleName = roleOptional.get().getUserRole();

        if (!roleAccessService.isSupportedRole(roleName)) {
            return Optional.empty();
        }

        return Optional.of(user);
    }
}
