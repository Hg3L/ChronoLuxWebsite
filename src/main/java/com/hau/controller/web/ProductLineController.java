package com.hau.controller.web;

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

@Controller(value = "ControllerOfProductLineWeb")
public class ProductLineController {
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private IProductService productService;
    @Autowired
    private IBrandService brandService;
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

}
