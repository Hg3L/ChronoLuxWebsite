package com.hau.controller.web;

import com.google.gson.internal.LinkedTreeMap;
import com.hau.dto.BrandDTO;
import com.hau.dto.ProductDTO;
import com.hau.service.IBrandService;
import com.hau.service.IProductService;
import com.hau.util.PageableUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

@Controller
public class ShopController {
    @Autowired
    private IProductService productService;
    @Autowired
    private IBrandService brandService;
    @RequestMapping(value = "/shop", method = RequestMethod.GET)
        public ModelAndView shopPage(@RequestParam("page") int page ,
                                     @RequestParam("limit") int limit,
                                     @RequestParam(value = "sortName",required = false) String sortName,
                                     @RequestParam(value = "sortBy",required = false) String sortBy,
                                     @RequestParam(value = "keyword",required = false) String keyword,
                                     @RequestParam(value = "filter",required = false) String filter){
        ModelAndView mav = new ModelAndView("web/shop");
        ProductDTO product = new ProductDTO();
        BrandDTO brand = new BrandDTO();
        product.setPage(page);
        product.setLimit(limit);
        if(sortName != null && sortBy != null ){
            product.setSortName(sortName);
            product.setSortBy(sortBy);
        }
        if(keyword != null){
            product.setKeyword(keyword);
        }
        if(filter != null){
            Map<String, String> priceFilters = new LinkedTreeMap<>();
            priceFilters.put("nam","Nam");
            priceFilters.put("nu","Nữ");
            priceFilters.put("duoi-1-trieu", "Dưới 1 triệu");
            priceFilters.put("tu-1-3-trieu", "Từ 1 - 3 triệu");
            priceFilters.put("tu-3-6-trieu", "Từ 3 - 6 triệu");
            priceFilters.put("tu-6-9-trieu", "Từ 6 - 9 triệu");
            priceFilters.put("tren-9-trieu", "Trên 9 triệu");

            mav.addObject("filter", filter);
            product.setFilter(filter);
            mav.addObject("priceFilters", priceFilters);
        }

        Pageable pageable = PageableUtil.getInstance(page,limit,sortName,sortBy);
        product.setTotalItem((int)productService.getTotalItem(keyword));
        product.setTotalPage((int) Math.ceil((double) product.getTotalItem() / product.getLimit()));

        brand.setListResult(brandService.findAll());

        mav.addObject("brand",brand);
        mav.addObject("products",productService.findAll(pageable,keyword,filter));
        mav.addObject("model",product);

        return mav;
        }



}
