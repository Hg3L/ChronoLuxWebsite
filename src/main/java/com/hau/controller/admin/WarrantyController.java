package com.hau.controller.admin;

import com.hau.dto.ProductLineDTO;
import com.hau.service.IBrandService;
import com.hau.service.IProductService;
import com.hau.service.ProductLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WarrantyController {
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private IBrandService brandService;

    @GetMapping("/admin/warranty")
    public String getWarrantyPage(@RequestParam(defaultValue = "1") int page,
                                      @RequestParam(defaultValue = "6") int limit,
                                      @RequestParam(defaultValue = "0") long brandId,
                                      @RequestParam(defaultValue = "2") int isHasWarranty,
                                      Model model) {
        Page<ProductLineDTO> productLines;
        if(brandId == 0 && isHasWarranty == 2){ // brand: all - warranty: all
            productLines = productLineService.findAll(page, limit);
        }
        else if(brandId == 0 && isHasWarranty == 1){ // brand: all - warranty: true
            productLines = productLineService.findAllWithWarranty(page, limit, true);
        }
        else if(brandId == 0 && isHasWarranty == 0){ // brand: all - warranty: false
            productLines = productLineService.findAllWithWarranty(page, limit, false);
        }
        else if(brandId != 0 && isHasWarranty == 1){ // brand: your choice - warranty: true
            productLines = productLineService.findAllWithWarrantyByBrandId(page, limit, true, brandId);
        }
        else if (brandId != 0 && isHasWarranty == 0) { // brand: your choice - warranty: false
            productLines = productLineService.findAllWithWarrantyByBrandId(page, limit, false, brandId);
        }
        else { // brand: your choice - warranty: all
            productLines = productLineService.findAllByBrandId(brandId, page, limit);
        }
        model.addAttribute("productLines", productLines);
        model.addAttribute("currentPage", page);
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("brandId", brandId);
        model.addAttribute("isHasWarranty", isHasWarranty);
        return "admin/warranty-view";
    }
}
