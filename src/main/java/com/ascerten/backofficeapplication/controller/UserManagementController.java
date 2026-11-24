
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.entity.MasterUserRole;
import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.service.UserManagementService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class UserManagementController {

    private final UserManagementService userManagementService;

    public UserManagementController(
            UserManagementService userManagementService) {

        this.userManagementService = userManagementService;
    }

    @GetMapping("/user")
    public String users(
            @RequestParam(required = false) Long editId,
            @RequestParam(required = false) Boolean showForm,
            HttpSession session,
            Model model) {

        model.addAttribute(
                "users",
                userManagementService.getAllUsers()
        );

        Map<Integer, MasterUserRole> rolesById =
                userManagementService.getRolesById();

        List<MasterUserRole> roles =
                new ArrayList<>(userManagementService.getActiveRoles());

        model.addAttribute("rolesById", rolesById);
        model.addAttribute("roles", roles);

        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        boolean editMode = editId != null;

        model.addAttribute("editMode", editMode);

        model.addAttribute(
                "showForm",
                editMode || Boolean.TRUE.equals(showForm)
        );

        if (editMode) {
            try {
                User editingUser =
                        userManagementService.getUserById(editId);

                model.addAttribute("editingUser", editingUser);

                // Keep a deactivated current role visible and selected.
                MasterUserRole currentRole =
                        rolesById.get(editingUser.getUserRole());

                if (currentRole != null
                        && roles.stream().noneMatch(role ->
                                role.getId().equals(currentRole.getId()))) {
                    roles.add(currentRole);
                }

            } catch (IllegalArgumentException exception) {

                model.addAttribute("error", exception.getMessage());
                model.addAttribute("showForm", false);
                model.addAttribute("editMode", false);
            }
        }

        return "users";
    }

    @PostMapping("/user/add")
    public String addUser(
            @RequestParam String name,
            @RequestParam String username,
            @RequestParam String emailId,
            @RequestParam String mobileNumber,
            @RequestParam Integer userRole,
            @RequestParam Short status,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        try {

            // Generate password and save the new user.
            String generatedPassword =
                    userManagementService.addUser(
                            name,
                            username,
                            emailId,
                            mobileNumber,
                            userRole,
                            status,
                            request.getRemoteAddr()
                    );

            redirectAttributes.addFlashAttribute(
                    "success",
                    "User added successfully."
            );

            // Display generated password to Admin.
            redirectAttributes.addFlashAttribute(
                    "generatedPassword",
                    generatedPassword
            );

            return "redirect:/user";

        } catch (IllegalArgumentException exception) {

            redirectAttributes.addFlashAttribute(
                    "error",
                    exception.getMessage()
            );

            return "redirect:/user?showForm=true";
        }
    }

    @PostMapping("/user/update")
    public String updateUser(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String username,
            @RequestParam String emailId,
            @RequestParam String mobileNumber,
            @RequestParam Integer userRole,
            @RequestParam Short status,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        try {

            userManagementService.updateUser(
                    id,
                    name,
                    username,
                    emailId,
                    mobileNumber,
                    userRole,
                    status,
                    request.getRemoteAddr()
            );

            redirectAttributes.addFlashAttribute(
                    "success",
                    "User updated successfully."
            );

            return "redirect:/user";

        } catch (IllegalArgumentException exception) {

            redirectAttributes.addFlashAttribute(
                    "error",
                    exception.getMessage()
            );

            return "redirect:/user?editId=" + id;
        }
    }
}
