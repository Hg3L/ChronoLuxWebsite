package com.hau.controller.admin;

import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductDTO;
import com.hau.dto.ProductLineDTO;
import com.hau.service.IBrandService;
import com.hau.service.ProductService;
import com.hau.service.ProductLineService;
import com.hau.util.PageableUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.hau.service.FileService;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller(value = "ControllerOfProductLineWeb")
public class ProductLineController {
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private ProductService productService;
    @Autowired
    private IBrandService brandService;
    @Autowired
    private FileService fileService;
    private static final String UPLOAD_DIR = "product-lines";

    @GetMapping("/shop/brand/product-line")
    public String ProductLinePage(Model model,
                                  @RequestParam("idBrand") long idBrand,
                                  @RequestParam("id") long id,
                                  @RequestParam("page") int page ,
                                  @RequestParam("limit") int limit,
                                  @RequestParam(value = "sortName",required = false) String sortName,
                                  @RequestParam(value = "sortBy",required = false) String sortBy,
                                  @RequestParam(value = "keyword",required = false) String keyword,
                                  @RequestParam(value = "filter",required = false) String filter){
        ProductDTO product = new ProductDTO();
        ProductLineDTO productLine = productLineService.findOneById(id);
        FilterCriteria.applyFiltersAndSorting(product,page,limit,sortName,sortBy,keyword,filter,model);
        product.setTotalItem((int)productService.getTotalItemByIdProductLine(id,keyword,filter));
        product.setTotalPage((int) Math.ceil((double) product.getTotalItem() / product.getLimit()));
        product.setId(id);
        Pageable pageable = PageableUtil.getInstance(page,limit,sortName,sortBy);
        productLine.setListResult(productLineService.findAllByBrandId(idBrand));

        model.addAttribute("brand",brandService.getBrandById(idBrand));
        model.addAttribute("products",productService.findAllByIdProductLine(pageable,id,keyword,filter));
        model.addAttribute("model",product);
        model.addAttribute("productLine",productLine);
        model.addAttribute("idBrand",idBrand);
        return "web/product-line";
    }

    @GetMapping("/admin/product-lines")
    public String getProductLinesPage(@RequestParam(defaultValue = "1") int page,
                                      @RequestParam(defaultValue = "6") int limit,
                                      @RequestParam(defaultValue = "0") long brandId,
                                      Model model) {
        Page<ProductLineDTO> productLines;
        if(brandId == 0){
            productLines = productLineService.findAll(page, limit);
        }
        else{
            productLines = productLineService.findAllByBrandId(brandId, page, limit);
        }
        model.addAttribute("productLines", productLines);
        model.addAttribute("currentPage", page);
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("brandId", brandId);
        return "admin/product-line-view";
    }

    @GetMapping("/admin/product-line/create")
    public String showCreateForm(Model model) {
        model.addAttribute("productLine", new ProductLineDTO());
        model.addAttribute("brands", brandService.findAll());
        return "admin/product-line-add";
    }

    @PostMapping("/admin/product-line/save")
    public String saveProductLine(@ModelAttribute("productLine") ProductLineDTO productLine,
                                  @RequestParam MultipartFile logo,
                                  @RequestParam MultipartFile banner,
                                  HttpServletRequest request) throws Exception{
        request.setCharacterEncoding("UTF-8");
        if(!logo.isEmpty() && !banner.isEmpty()) {
            String logoName = fileService.saveFile(logo, UPLOAD_DIR);
            String bannerName = fileService.saveFile(banner, UPLOAD_DIR);
            productLine.setIconUrl(logoName);
            productLine.setBannerUrl(bannerName);
        }
        else if(!logo.isEmpty() && banner.isEmpty()) {
            String logoName = fileService.saveFile(logo, UPLOAD_DIR);
            productLine.setIconUrl(logoName);
            productLine.setBannerUrl(brandService.getBrandById(productLine.getId()).getBannerUrl());
        }
        else if(logo.isEmpty() && !banner.isEmpty()) {
            String bannerName = fileService.saveFile(banner, UPLOAD_DIR);
            productLine.setBannerUrl(bannerName);
            productLine.setIconUrl(brandService.getBrandById(productLine.getId()).getIconUrl());
        }
        else{
            ProductLineDTO productLineDTO = productLineService.findOneById(productLine.getId());
            productLine.setIconUrl(productLineDTO.getIconUrl());
            productLine.setBannerUrl(productLineDTO.getBannerUrl());
        }
        productLineService.save(productLine);
        return "redirect:/admin/product-lines";
    }

    @GetMapping("/admin/product-line/update")
    public String showUpdateForm(@RequestParam("id") long id, Model model) {
        ProductLineDTO productLine = productLineService.findOneById(id);
        model.addAttribute("productLine", productLine);
        model.addAttribute("brands", brandService.findAll());
        return "admin/product-line-update";
    }

    @GetMapping("/admin/product-line/delete")
    public String deleteProductLine(@RequestParam("id") long id) {
        productLineService.deleteById(id);
        return "redirect:/admin/product-lines";
    }

    // for selection tag with ajax
    @GetMapping("/admin/product-line/getProductLines")
    @ResponseBody
    public List<ProductLineDTO> getProductLines(@RequestParam("brandId") long brandId) {
        return productLineService.findAllByBrandId(brandId);
    }
}
