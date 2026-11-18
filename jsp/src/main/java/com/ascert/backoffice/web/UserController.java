package com.ascert.backoffice.web;

import com.ascert.backoffice.model.UserAccount;
import com.ascert.backoffice.service.UserStore;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Pattern;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    private final UserStore userStore;

    public UserController(UserStore userStore) {
        this.userStore = userStore;
    }

    @GetMapping("/user")
    public String users(
            @RequestParam(value = "form", required = false) String form,
            @RequestParam(value = "edit", required = false) String edit,
            Model model) {
        UserAccount editing = find(edit);
        model.addAttribute("users", userStore.all());
        model.addAttribute("editing", editing);
        model.addAttribute("showForm", "new".equals(form) || editing != null);
        model.addAttribute("stylesheets", Collections.singletonList("user.css"));
        return "users";
    }

    @PostMapping("/user")
    public String create(
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("role") String role,
            @RequestParam("status") String status,
            Model model) {
        UserAccount user = account(0L, fullName, email, mobile, role, status);
        Map<String, String> errors = validate(user);
        if (!errors.isEmpty()) {
            return userForm(user, errors, model);
        }
        userStore.add(user);
        return "redirect:/user";
    }

    @PostMapping("/user/update")
    public String update(
            @RequestParam("id") long id,
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("role") String role,
            @RequestParam("status") String status,
            Model model) {
        UserAccount user = account(id, fullName, email, mobile, role, status);
        Map<String, String> errors = validate(user);
        if (!errors.isEmpty()) {
            return userForm(user, errors, model);
        }
        userStore.update(user);
        return "redirect:/user";
    }

    private String userForm(UserAccount user, Map<String, String> errors, Model model) {
        model.addAttribute("users", userStore.all());
        model.addAttribute("editing", user);
        model.addAttribute("showForm", Boolean.TRUE);
        model.addAttribute("fieldErrors", errors);
        model.addAttribute("stylesheets", Collections.singletonList("user.css"));
        return "users";
    }

    private static Map<String, String> validate(UserAccount user) {
        Map<String, String> errors = new LinkedHashMap<String, String>();
        if (user.getFullName().isEmpty()) {
            errors.put("fullName", "Please enter the full name");
        }
        if (user.getEmail().isEmpty()) {
            errors.put("email", "Please enter an email address");
        } else if (!EMAIL.matcher(user.getEmail()).matches()) {
            errors.put("email", "Please enter a valid email address");
        }
        String digits = user.getMobile().replaceAll("\\D", "");
        if (user.getMobile().isEmpty()) {
            errors.put("mobile", "Please enter a mobile number");
        } else if (!digits.matches("\\d{10}")) {
            errors.put("mobile", "Please enter a valid mobile number");
        }
        if (user.getRole().isEmpty()) {
            errors.put("role", "Please select a role");
        }
        if (user.getStatus().isEmpty()) {
            errors.put("status", "Please select a status");
        }
        return errors;
    }

    private UserAccount find(String edit) {
        if (edit == null || edit.isEmpty()) {
            return null;
        }
        try {
            return userStore.find(Long.parseLong(edit));
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private static UserAccount account(long id, String fullName, String email, String mobile, String role, String status) {
        UserAccount user = new UserAccount();
        user.setId(id);
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setMobile(mobile.trim());
        user.setRole(role);
        user.setStatus(status);
        return user;
    }
}
