package com.hau.controller.admin;

import com.hau.dto.UserDTO;
import com.hau.service.FileService;
import com.hau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AccountController {
    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;

    private static final String UPLOAD_DIR = "user-logos";
    private static final String DEFAULT_ADMIN_AVATAR_DIR = "account-representation";

    @GetMapping("/admin/admin-profile")
    public String  adminProfile(Model model, @AuthenticationPrincipal Authentication authentication){
        model.addAttribute("account",userService.getCurrentLoggedInCustomer(authentication));
        return "admin/admin-account-update";
    }

    @GetMapping("/admin/accounts")
    public String showAccounts(Model model,
                                    @RequestParam(defaultValue = "1") int adminPage,
                                    @RequestParam(defaultValue = "1") int userPage,
                                    @RequestParam(defaultValue = "6") int limit) {
        model.addAttribute("currentAdminPage", adminPage);
        model.addAttribute("adminAccountPage", userService.findAllAdminAccounts(adminPage, limit));
        model.addAttribute("currentUserPage", userPage);
        model.addAttribute("userAccountPage", userService.findAllUserAccounts(userPage, limit));
        return "admin/accounts-tab-view";
    }

    @GetMapping("/admin/account/create")
    public String showAdminCreateForm(Model model) {
        model.addAttribute("account", new UserDTO());
        return "admin/admin-account-add";
    }

    @PostMapping("/admin/account/save")
    public String saveAdminAccounts(@ModelAttribute("account") UserDTO account,
                                    @RequestParam("img")MultipartFile img,
                                    @RequestParam("page") int currentPage,
                                    HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(!img.isEmpty() && account.getId() == null){ // create new account, avatar != null
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        else if(img.isEmpty() && account.getId() == null){ // create new account, avatar == null
            img = fileService.handleDefaultFile("admin.png", DEFAULT_ADMIN_AVATAR_DIR);
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        else if(img.isEmpty() && account.getId() != null){ // update account, avatar == null
            UserDTO userDTO = userService.findOneByUserNameAndStatus(account.getUserName(), 1);
            account.setImgUrl(userDTO.getImgUrl());
        }
        else{ // update account, avatar != null
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        userService.save(account, "admin");
        return "redirect:/admin/accounts?adminPage=" + currentPage;
    }

    @PostMapping("/admin/account/update")
    public String updateAdminAccounts(@ModelAttribute("account") UserDTO account,
                                    @RequestParam("img")MultipartFile img,
                                    @RequestParam Long id,
                                    HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(!img.isEmpty() && account.getId() == null){ // create new account, avatar != null
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        else if(img.isEmpty() && account.getId() == null){ // create new account, avatar == null
            img = fileService.handleDefaultFile("admin.png", DEFAULT_ADMIN_AVATAR_DIR);
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        else if(img.isEmpty() && account.getId() != null){ // update account, avatar == null
            UserDTO userDTO = userService.findOneById(id);
            account.setImgUrl(userDTO.getImgUrl());
        }
        else if(!img.isEmpty() && account.getId() != null){ // update account, avatar != null
            String avatar = fileService.saveFile(img, UPLOAD_DIR);
            account.setImgUrl(avatar);
        }
        userService.update(account);
        return "redirect:/admin/accounts";
    }

    @GetMapping("/admin/account/ban-account")
    public String banAccount(@RequestParam Long id,
                             @RequestParam int currentPage){
        userService.lockUserAccounts(id);
        return "redirect:/admin/accounts?userPage=" + currentPage;
    }

    @GetMapping("/admin/account/unban-account")
    public String unbanAccount(@RequestParam Long id,
                               @RequestParam int currentPage){
        userService.unlockUserAccounts(id);
        return "redirect:/admin/accounts?userPage=" + currentPage;
    }
}