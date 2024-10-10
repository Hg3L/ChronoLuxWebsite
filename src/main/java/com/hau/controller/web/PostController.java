package com.hau.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.hau.service.PostService;

@Controller
public class PostController {
    @Autowired
    private PostService postService;

    // For client (tu sua)
    @GetMapping("/home/posts")
    public String getPostsHomePage(Model model) {
        model.addAttribute("posts", postService.getAllPosts());
        return "admin/post-view";
    }

    // For admin
    @GetMapping("/admin/posts")
    public String getPostsAdminPage(Model model) {
        model.addAttribute("posts", postService.getAllPosts());
        return "admin/post-view";
    }


}
