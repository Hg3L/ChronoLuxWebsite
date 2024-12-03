package com.hau.controller.admin;

import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductLineDTO;
import com.hau.dto.BrandDTO;
import com.hau.dto.ProductDTO;
import com.hau.service.FileService;
import com.hau.service.BrandService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;


@Controller(value = "ControllerOfBrandWeb")
public class BrandController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private BrandService brandService;
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
        productLine.setListResult(productLineService.findAllByBrandIdAndActive(id,true));
        model.addAttribute("brand",brandService.getBrandById(id,true));
        model.addAttribute("products",productService.findAllByIdBrand(pageable,id,keyword,filter));
        model.addAttribute("model",product);
        model.addAttribute("productLine",productLine);
        List<Integer> nums = Arrays.asList(4,5,6);
        nums.forEach(n -> {
            System.out.println(n);
            return ;
        } );
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
    public String showCreateForm(Model model,
                                 @RequestParam("currentPage") int page) {
        model.addAttribute("brand", new BrandDTO());
        model.addAttribute("currentPage", page);
        return "admin/brand-add";
    }

    @PostMapping("/admin/brand/save")
    public String saveBrand(@ModelAttribute("brand") BrandDTO brand,
                            @RequestParam("logo") MultipartFile logo,
                            @RequestParam("banner") MultipartFile banner,
                            @RequestParam("page") int currentPage,
                            HttpServletRequest request,
                            RedirectAttributes redirectAttributes) throws Exception {
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
            brand.setBannerUrl(brandService.getBrandById(brand.getId(),true).getBannerUrl());
        }
        else if(logo.isEmpty() && !banner.isEmpty()) {
            String bannerName = fileService.saveFile(banner, "brands");
            brand.setBannerUrl(bannerName);
            brand.setIconUrl(brandService.getBrandById(brand.getId(),true).getIconUrl());
        }
        else{
            BrandDTO brandDTO = brandService.getBrandById(brand.getId(),true);
            brand.setIconUrl(brandDTO.getIconUrl());
            brand.setBannerUrl(brandDTO.getBannerUrl());
        }
        brandService.saveBrand(brand);
        String message = (brand.getId() == null || brand.getId() == 0) ? "Thêm thương hiệu thành công" : "Cập nhật thương hiệu thành công";
        redirectAttributes.addFlashAttribute("successMessage", message);
        return "redirect:/admin/brands?page=" + currentPage;
    }

    @GetMapping("/admin/brand/update")
    public String showUpdateForm(@RequestParam("id") Long id,
                                 Model model,
                                 @RequestParam("currentPage") int page) {
        model.addAttribute("brand", brandService.getBrandById(id,true));
        model.addAttribute("currentPage", page);
        return "admin/brand-update";
    }

    @GetMapping("/admin/brand/delete")
    public String deleteBrand(@RequestParam("id") Long id) throws Exception {
        brandService.deleteBrandById(id);
        return "redirect:/admin/brands";
    }
}
