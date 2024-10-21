package com.hau.controller.admin;

import com.hau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AccountController {
    @Autowired
    private UserService userService;

    @GetMapping("/admin/accounts")
    public String showAccounts(Model model,
                                    @RequestParam(defaultValue = "1") int adminPage,
                                    @RequestParam(defaultValue = "1") int userPage,
                                    @RequestParam(defaultValue = "6") int limit) {
        model.addAttribute("currentAdminPage", adminPage);
        model.addAttribute("adminAccountPage", userService.findAllAdminAccounts(adminPage, limit));
        model.addAttribute("currentUserPage", userPage);
        model.addAttribute("userAccountPage", userService.findAllUserAccounts(userPage, limit));
        return "admin/admin-tab-view";
    }
}
