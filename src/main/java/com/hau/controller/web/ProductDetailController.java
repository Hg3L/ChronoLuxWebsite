package com.hau.controller.web;

import com.hau.dto.ProductDTO;
import com.hau.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductDetailController {
    @Autowired
    private IProductService productService;
    @GetMapping(value = "/product-detail")
    public String productDetailPage(Model model,@RequestParam("id") long id) {
        ProductDTO product = productService.findOneById(id);
        model.addAttribute("model",product);
        return "web/product-detail";
    }
}
