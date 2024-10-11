package com.hau.controller.web;

import com.hau.dto.ProductDTO;
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

@Controller
public class ShopController {
    @Autowired
    private IProductService productService;
    @RequestMapping(value = "/shop", method = RequestMethod.GET)
        public ModelAndView shopPage(@RequestParam("page") int page ,
                                     @RequestParam("limit") int limit,
                                     @RequestParam(value = "sortName",required = false) String sortName,
                                     @RequestParam(value = "sortBy",required = false) String sortBy,
                                     @RequestParam(value = "keyword",required = false) String keyword,
                                     @RequestParam(value = "filter",required = false) String filter){
        ProductDTO product = new ProductDTO();
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
            product.setFilter(filter);
        }
        Pageable pageable = PageableUtil.getInstance(page,limit,sortName,sortBy);
        product.setTotalItem((int)productService.getTotalItem(keyword));
        product.setTotalPage((int) Math.ceil((double) product.getTotalItem() / product.getLimit()));
        ModelAndView mav = new ModelAndView("web/shop");
        mav.addObject("products",productService.findAll(pageable,keyword,filter));
        mav.addObject("model",product);
        return mav;
        }
}
