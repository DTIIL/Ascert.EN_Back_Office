
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.entity.User;
import com.ascerten.backofficeapplication.service.UserManagementService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

        model.addAttribute(
                "roles",
                userManagementService.getActiveRoles()
        );

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
