package com.hau.service.impl;

import com.hau.converter.ProductConverter;
import com.hau.dto.ProductDTO;
import com.hau.entity.ProductEntity;
import com.hau.repository.ProductRepository;
import com.hau.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService implements IProductService {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductConverter productConverter;
    @Override
    public List<ProductDTO> findTop8ByOrderByIdDesc() {
        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = productRepository.findTop8ByOrderByIdDesc();
        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }

    @Override
    public List<ProductDTO> findAll(Pageable pageable,String keyword,String filter) {
        long minPrice =0;
        long maxPrice =0;
        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = null;
        if(filter != null){
            switch (filter) {
                case "duoi-1-trieu" -> {
                    minPrice = 0;
                    maxPrice = 1000000;
                }
                case "tu-1-3-trieu" -> {
                    minPrice = 1000000;
                    maxPrice = 3000000;
                }
                case "tu-3-6-trieu" -> {
                    minPrice = 3000000;
                    maxPrice = 6000000;
                }
                case "tu-6-9-trieu" -> {
                    minPrice = 6000000;
                    maxPrice = 9000000;
                }
                case "tren-9-trieu" -> minPrice = 9000000;
            }
        }
        if(filter != null && keyword != null){// có cả keywword cả lọc
            if(filter.equals("tren-9-trieu")){
                productEntities =  productRepository.findAll(pageable,keyword,minPrice).getContent();
            }
            else{
                productEntities =  productRepository.findAll(pageable,keyword,minPrice,maxPrice).getContent();
            }
        }
        else if(keyword != null){// có keyword không có lọc
           productEntities = productRepository.findAll(pageable,keyword).getContent();
        }
        else if(filter!= null){ // k có keyword có lọc
            if(filter.equals("tren-9-trieu")){
                productEntities =  productRepository.findAll(pageable,minPrice).getContent();
            }
            else{
                productEntities =  productRepository.findAll(pageable,minPrice,maxPrice).getContent();
            }
        } // bình thường
        else{
            productEntities = productRepository.findAll(pageable).getContent();
        }

        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }



    @Override
    public long getTotalItem(String keyword) {
        if(keyword != null){
            return productRepository.count(keyword);
        }
        return  productRepository.count();
    }
}
