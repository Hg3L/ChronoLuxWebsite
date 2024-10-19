package com.hau.controller.admin;

import com.hau.dto.ProductDTO;
import com.hau.service.FileService;
import com.hau.service.IBrandService;
import com.hau.service.ProductService;
import com.hau.service.ProductLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private IBrandService brandService;
    @Autowired
    private FileService fileService;
    @Autowired
    private ProductLineService productLineService;

    @GetMapping(value = "/product-detail")
    public String productDetailPage(Model model,@RequestParam("id") long id) {
        ProductDTO product = productService.findOneById(id);
        model.addAttribute("model",product);
        return "web/product-detail";
    }

    @GetMapping("/admin/products")
    public String showProducts(@RequestParam(defaultValue = "1") int page,
                               @RequestParam(defaultValue = "6") int limit,
                               @RequestParam(defaultValue = "0") long brandId,
                               @RequestParam(defaultValue = "0") long productLineId,
                               Model model) {
        Page<ProductDTO> productDTOPage;
        if(productLineId == 0) {
            productDTOPage = productService.findAll(page, limit);
        }
        else{
            productDTOPage = productService.findByProductLine_Id(productLineId, page, limit);
        }
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("productLines", productDTOPage);
        model.addAttribute("productLineId", productLineId);
        model.addAttribute("brandId", brandId);
        model.addAttribute("currentPage", page);
        return "admin/product-view";
    }

    @GetMapping("/admin/product/create")
    public String createProduct(Model model) {
        model.addAttribute("product", new ProductDTO());
        model.addAttribute("brands", brandService.findAll());
        return "admin/product-add";
    }
}
