package com.hau.controller.web;

import com.google.gson.internal.LinkedTreeMap;
import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductDTO;
import com.hau.dto.ProductLineDTO;
import com.hau.service.IBrandService;
import com.hau.service.IProductService;
import com.hau.service.ProductLineService;
import com.hau.util.PageableUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;


@Controller(value = "ControllerOfBrandWeb")
public class BrandController {
    @Autowired
    private IProductService productService;
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private IBrandService brandService;

    @GetMapping("shop/brand")
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
        model.addAttribute("brand",brandService.findOneById(id));
        model.addAttribute("products",productService.findAllByIdBrand(pageable,id,keyword,filter));
        model.addAttribute("model",product);
        model.addAttribute("productLine",productLine);
        return "web/brand";
    }
}
