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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

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

    private static final String UPLOAD_DIR = "products";

    @GetMapping(value = "/product-detail")
    public String productDetailPage(Model model,@RequestParam("id") long id) {
        ProductDTO product = productService.findOneById(id);
        model.addAttribute("model",product);
        return "web/product-detail";
    }

    @GetMapping("/admin/products")
    public String showProducts(@RequestParam(defaultValue = "1") int page,
                               @RequestParam(defaultValue = "6") int limit,
                               @RequestParam(defaultValue = "0") Long brandId,
                               @RequestParam(defaultValue = "0") Long productLineId,
                               Model model) {
        Page<ProductDTO> productDTOPage;
        if((brandId == 0 && productLineId == 0) || (brandId == 0 && productLineId == -1)){
            productDTOPage = productService.findAll(page, limit);
        }
        else if(brandId != 0 && productLineId == null){
            productDTOPage = null;
        }
        else if(brandId != 0 && productLineId == 0){
            productDTOPage = productService.findByBrand_Id(brandId, page, limit);
        }
        else{
            productDTOPage = productService.findByProductLine_Id(productLineId, page, limit);
        }
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("productPage", productDTOPage);
        model.addAttribute("productLineId", productLineId);
        model.addAttribute("brandId", brandId);
        model.addAttribute("currentPage", page);
        return "admin/product-view";
    }

    @GetMapping("/admin/product/create")
    public String createProduct(Model model,
                                @RequestParam int page) {
        model.addAttribute("product", new ProductDTO());
        model.addAttribute("currentPage", page);
        model.addAttribute("brands", brandService.findAll());
        return "admin/product-add";
    }

    @PostMapping("/admin/product/save")
    public String saveProduct(@ModelAttribute("product") ProductDTO productDTO,
                              @RequestParam("img") MultipartFile img,
                              HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(!img.isEmpty()) {
            String imgName = fileService.saveFile(img, UPLOAD_DIR);
            productDTO.setImgUrl(imgName);
        }
        else{
            ProductDTO product = productService.findOneById(productDTO.getId());
            productDTO.setImgUrl(product.getImgUrl());
        }
        productService.save(productDTO);
        return "redirect:/admin/products";
    }
}