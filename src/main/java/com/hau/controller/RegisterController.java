package com.hau.controller;

import com.hau.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import com.hau.service.UserService;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Controller

public class RegisterController {
    @Autowired
    private UserService userService;

    @PostMapping(value="/login/add" )
    public String addNewUser(@ModelAttribute UserDTO user,
                             @RequestParam("img") MultipartFile multipartFile,
                             RedirectAttributes redirectAttributes) {
        // Kiểm tra nếu file không rỗng
        if (multipartFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please upload an image.");
            return "redirect:/login"; // Trả về trang đăng ký nếu không có file
        }
        try {
            String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
            user.setImgUrl(fileName);
            // Lưu User và file vào hệ thống
            UserDTO userDTO = userService.save(user);
            String uploadDir = "./template/web/img/user-logos";
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            try (InputStream inputStream = multipartFile.getInputStream()) {
                Path filePath = uploadPath.resolve(fileName);
                System.out.println(filePath.toFile().getAbsolutePath());
                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            redirectAttributes.addFlashAttribute("successMessage", "User registered successfully.");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Could not save uploaded file: " + e.getMessage());
        }

        return "redirect:/login"; // Redirect lại sau khi xử lý
    }

    @GetMapping("/login/register")
    public String showRegisterPage(Model model){
        return "login/register";
    }
}
