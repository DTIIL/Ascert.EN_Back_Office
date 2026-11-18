
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.repository.UserRepository;
import com.ascerten.backofficeapplication.repository.MasterUserRoleRepository;
import com.ascerten.backofficeapplication.enums.SubscriberStatus;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class UserManagementService {

    private static final String UPPERCASE =
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private static final String LOWERCASE =
            "abcdefghijklmnopqrstuvwxyz";

    private static final String NUMBERS =
            "0123456789";

    private static final String SPECIAL =
            "!@#$%&*";

    private static final String ALL_CHARACTERS =
            UPPERCASE + LOWERCASE + NUMBERS + SPECIAL;

    private static final SecureRandom SECURE_RANDOM =
            new SecureRandom();

    private final UserRepository userRepository;
    private final MasterUserRoleRepository roleRepository;

    public UserManagementService(
            UserRepository userRepository,
            MasterUserRoleRepository roleRepository) {

        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found."));
    }

    public List<MasterUserRole> getActiveRoles() {
        return roleRepository.findByActiveOrderById((short) 1);
    }

    // Generate a random 8-character password.
    private String generatePassword() {

        List<Character> characters = new ArrayList<>();

        // Ensure at least one character from each category.
        characters.add(randomCharacter(UPPERCASE));
        characters.add(randomCharacter(LOWERCASE));
        characters.add(randomCharacter(NUMBERS));
        characters.add(randomCharacter(SPECIAL));

        // Fill the remaining four characters.
        while (characters.size() < 8) {
            characters.add(randomCharacter(ALL_CHARACTERS));
        }

        // Shuffle characters to avoid predictable positions.
        Collections.shuffle(characters, SECURE_RANDOM);

        StringBuilder password = new StringBuilder();

        for (Character character : characters) {
            password.append(character);
        }

        return password.toString();
    }

    private char randomCharacter(String characters) {
        return characters.charAt(
                SECURE_RANDOM.nextInt(characters.length())
        );
    }

    private void validateUser(
            String name,
            String email,
            String mobileNumber,
            Integer roleId,
            Short status) {

        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Please enter full name."
            );
        }

        if (name.trim().length() > 100) {
            throw new IllegalArgumentException(
                    "Name cannot exceed 100 characters."
            );
        }

        if (email == null ||
                !email.trim().matches(
                        "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

            throw new IllegalArgumentException(
                    "Please enter a valid email address."
            );
        }

        if (email.trim().length() > 150) {
            throw new IllegalArgumentException(
                    "Email ID cannot exceed 150 characters."
            );
        }

        if (mobileNumber == null ||
                !mobileNumber.matches("[0-9]{10}")) {

            throw new IllegalArgumentException(
                    "Please enter a valid 10-digit mobile number."
            );
        }

        if (roleId == null ||
                roleRepository.findById(roleId)
                        .filter(role -> role.getActive() != null
                                && role.getActive() == 1)
                        .isEmpty()) {

            throw new IllegalArgumentException(
                    "Please select a valid role."
            );
        }

        // Validate subscriber status using the enum.
        if (status == null ||
                !isValidSubscriberStatus(status)) {

            throw new IllegalArgumentException(
                    "Please select a valid status."
            );
        }
    }

    // Check whether the supplied status code exists in SubscriberStatus.
    private boolean isValidSubscriberStatus(Short status) {

        for (SubscriberStatus subscriberStatus : SubscriberStatus.values()) {
            if (subscriberStatus.getCode() == status) {
                return true;
            }
        }

        return false;
    }

    @Transactional
    public String addUser(
            String name,
            String email,
            String mobileNumber,
            Integer roleId,
            Short status,
            String createdIp) {

        validateUser(
                name,
                email,
                mobileNumber,
                roleId,
                status
        );

        String normalizedEmail = email.trim();

        // Prevent another active user from using the same email.
        if (userRepository.existsByEmailIdIgnoreCaseAndStatus(
                normalizedEmail,
                (short) SubscriberStatus.ACTIVE.getCode())) {

            throw new IllegalArgumentException(
                    "An active user with this email address already exists."
            );
        }

        if (createdIp == null || createdIp.isBlank()) {
            throw new IllegalArgumentException(
                    "Unable to determine the creator IP address."
            );
        }

        // Generate the password automatically.
        String generatedPassword = generatePassword();

        User user = new User();

        user.setName(name.trim());
        user.setEmailId(normalizedEmail);
        user.setMobileNumber(Long.valueOf(mobileNumber));
        user.setUserRole(roleId);
        user.setStatus(status);

        // Store generated password as plain text for the current phase.
        user.setUsername(null);
        user.setPassword(generatedPassword);

        user.setCreatedDate(OffsetDateTime.now());
        user.setCreatedIp(createdIp);

        userRepository.save(user);

        // Return the generated password to the controller.
        return generatedPassword;
    }

    @Transactional
    public void updateUser(
            Long id,
            String name,
            String email,
            String mobileNumber,
            Integer roleId,
            Short status,
            String updatedIp) {

        User user = getUserById(id);

        validateUser(
                name,
                email,
                mobileNumber,
                roleId,
                status
        );

        String normalizedEmail = email.trim();

        // Prevent another active user from using the same email.
        // Exclude the current record from the duplicate check.
        if (userRepository.existsByEmailIdIgnoreCaseAndStatusAndIdNot(
                normalizedEmail,
                (short) SubscriberStatus.ACTIVE.getCode(),
                id)) {

            throw new IllegalArgumentException(
                    "An active user with this email address already exists."
            );
        }

        if (updatedIp == null || updatedIp.isBlank()) {
            throw new IllegalArgumentException(
                    "Unable to determine the updater IP address."
            );
        }

        user.setName(name.trim());
        user.setEmailId(normalizedEmail);
        user.setMobileNumber(Long.valueOf(mobileNumber));
        user.setUserRole(roleId);
        user.setStatus(status);

        // Preserve existing username and password.
        user.setUpdatedDate(OffsetDateTime.now());
        user.setUpdatedIp(updatedIp);

        userRepository.save(user);
    }
}
