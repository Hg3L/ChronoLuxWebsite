package com.hau.controller.web;

import com.hau.dto.BrandDTO;
import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductDTO;
import com.hau.service.BrandService;
import com.hau.service.ProductService;
import com.hau.util.PageableUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ShopController {
    @Autowired
    private ProductService productService;
    @Autowired
    private BrandService brandService;
    @RequestMapping(value = "/shop", method = RequestMethod.GET)
        public String shopPage(@RequestParam("page") int page ,
                                     @RequestParam("limit") int limit,
                                     @RequestParam(value = "sortName",required = false) String sortName,
                                     @RequestParam(value = "sortBy",required = false) String sortBy,
                                     @RequestParam(value = "keyword",required = false) String keyword,
                                     @RequestParam(value = "filter",required = false) String filter,
                                     Model model){
        ProductDTO product = new ProductDTO();
        BrandDTO brand = new BrandDTO();

        FilterCriteria.applyFiltersAndSorting(product,page,limit,sortName,sortBy,keyword,filter,model);
        Pageable pageable = PageableUtil.getInstance(page,limit,sortName,sortBy);

        product.setTotalItem((int)productService.getTotalItem(keyword,filter));
        product.setTotalPage((int) Math.ceil((double) product.getTotalItem() / product.getLimit()));

        brand.setListResult(brandService.findAll());

        model.addAttribute("brand",brand);
        model.addAttribute("products",productService.findAll(pageable,keyword,filter));
        model.addAttribute("model",product);

        return "web/shop";
        }



}
