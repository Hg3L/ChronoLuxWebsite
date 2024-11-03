package com.hau.controller.web;

import com.hau.dto.BrandDTO;
import com.hau.dto.ProductDTO;
import com.hau.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.TreeSet;
import java.util.stream.Collectors;

@Controller
public class HomeController {
    @Autowired
    private IBrandService brandService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private PostService postService;
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String homePage(Model model) {
        BrandDTO brand = new BrandDTO();
        brand.setListResult(brandService.findAll());
        ProductDTO product = new ProductDTO();
        product.setListResult(productService.findTop8ByOrderByIdDesc());
        LinkedHashSet<ProductDTO> productTrendy = productService.findTop8BestSelling();
        model.addAttribute("brand",brand);
        model.addAttribute("product",product);
        model.addAttribute("productTrendy",productTrendy.stream().collect(Collectors.toList()));
        model.addAttribute("posts",postService.getAllPosts());
        return "web/home";
    }
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView Logout(HttpServletRequest request, HttpServletResponse respone) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if(auth != null){
            new SecurityContextLogoutHandler().logout(request,respone,auth);
        }
        return new ModelAndView("redirect:/home");
    }

    @GetMapping("/api/images")
    public ResponseEntity<List<List<String>>> getImages() {

        List<List<String>> images = Arrays.asList(
                Arrays.asList(
                        "https://www.watchstore.vn/images/banners/compress/fc-luxury-banner_1711707751.webp",
                        "https://www.watchstore.vn/images/banners/compress/omega-luxury-banner_1711707171.webp"
                ),
                Arrays.asList(
                        "https://www.watchstore.vn/images/banners/compress/omega-luxury-banner_1711707171.webp",
                        "https://www.watchstore.vn/images/banners/compress/lg-giam-34-banner_1711707950.webp"
                )
        );

        // Trả về danh sách URL hình ảnh dưới dạng JSON
        return ResponseEntity.ok(images);
    }
}