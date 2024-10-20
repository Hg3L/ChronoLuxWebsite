package com.hau.controller.admin;

import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductLineDTO;
import com.hau.dto.BrandDTO;
import com.hau.dto.ProductDTO;
import com.hau.service.FileService;
import com.hau.service.IBrandService;
import com.hau.service.ProductService;
import com.hau.service.ProductLineService;
import com.hau.util.PageableUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;


@Controller(value = "ControllerOfBrandWeb")
public class BrandController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private IBrandService brandService;
    @Autowired
    private FileService fileService;

    @GetMapping("/shop/brand")
    public String BrandPage(Model model,
                            @RequestParam("id") long id,
                            @RequestParam("page") int page ,
                            @RequestParam("limit") int limit,
                            @RequestParam(value = "sortName",required = false) String sortName,
                            @RequestParam(value = "sortBy",required = false) String sortBy,
                            @RequestParam(value = "keyword",required = false) String keyword,
                            @RequestParam(value = "filter",required = false) String filter){
        ProductDTO product = new ProductDTO();
        ProductLineDTO productLine = new ProductLineDTO();
        FilterCriteria.applyFiltersAndSorting(product,page,limit,sortName,sortBy,keyword,filter,model);
        product.setTotalItem((int)productService.getTotalItemByIdBrand(id,keyword,filter));
        product.setTotalPage((int) Math.ceil((double) product.getTotalItem() / product.getLimit()));
        product.setId(id);

        Pageable pageable = PageableUtil.getInstance(page,limit,sortName,sortBy);
        productLine.setListResult(productLineService.findAllByBrandId(id));
        model.addAttribute("brand",brandService.getBrandById(id));
        model.addAttribute("products",productService.findAllByIdBrand(pageable,id,keyword,filter));
        model.addAttribute("model",product);
        model.addAttribute("productLine",productLine);
        return "web/brand";
    }

    @GetMapping("/admin/brands")
    public String getBrandsPage(@RequestParam(defaultValue = "1") int page,
                                @RequestParam(defaultValue = "6") int size,
                                Model model) {
        Page<BrandDTO> brandPage = brandService.findAll(page, size);
        model.addAttribute("brandPage", brandPage);
        model.addAttribute("currentPage", page);
        return "admin/brand-view";
    }

    @GetMapping("/admin/brand/create")
    public String showCreateForm(Model model) {
        model.addAttribute("brand", new BrandDTO());
        return "admin/brand-add";
    }

    @PostMapping("/admin/brand/save")
    public String saveBrand(@ModelAttribute("brand") BrandDTO brand,
                            @RequestParam("logo") MultipartFile logo,
                            @RequestParam("banner") MultipartFile banner,
                            HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(!logo.isEmpty() && !banner.isEmpty()) {
            String logoName = fileService.saveFile(logo, "brands");
            String bannerName = fileService.saveFile(banner, "brands");
            brand.setIconUrl(logoName);
            brand.setBannerUrl(bannerName);
        }
        else if(!logo.isEmpty() && banner.isEmpty()) {
            String logoName = fileService.saveFile(logo, "brands");
            brand.setIconUrl(logoName);
            brand.setBannerUrl(brandService.getBrandById(brand.getId()).getBannerUrl());
        }
        else if(logo.isEmpty() && !banner.isEmpty()) {
            String bannerName = fileService.saveFile(banner, "brands");
            brand.setBannerUrl(bannerName);
            brand.setIconUrl(brandService.getBrandById(brand.getId()).getIconUrl());
        }
        else{
            BrandDTO brandDTO = brandService.getBrandById(brand.getId());
            brand.setIconUrl(brandDTO.getIconUrl());
            brand.setBannerUrl(brandDTO.getBannerUrl());
        }
        brandService.saveBrand(brand);
        return "redirect:/admin/brands";
    }

    @GetMapping("/admin/brand/update")
    public String showUpdateForm(@RequestParam("id") Long id,
                                 Model model) {
        model.addAttribute("brand", brandService.getBrandById(id));
        return "admin/brand-update";
    }

    @GetMapping("/admin/brand/delete")
    public String deleteBrand(@RequestParam("id") Long id) throws Exception {
        fileService.deleteFile(brandService.getBrandById(id).getIconUrl(), "brands");
        fileService.deleteFile(brandService.getBrandById(id).getBannerUrl(), "brands");
        brandService.deleteBrandById(id);
        return "redirect:/admin/brands";
    }
}
