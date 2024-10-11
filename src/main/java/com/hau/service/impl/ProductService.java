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
    public List<ProductDTO> findAll(Pageable pageable,String keyword,String filter,String gender) {
        Long minPrice =null;
        Long maxPrice =null;
        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = null;
        if(filter != null){
            switch (filter) {
                case "duoi-1-trieu" -> {
                    minPrice = 0L;
                    maxPrice = 1000000L;
                }
                case "tu-1-3-trieu" -> {
                    minPrice = 1000000L;
                    maxPrice = 3000000L;
                }
                case "tu-3-6-trieu" -> {
                    minPrice = 3000000L;
                    maxPrice = 6000000L;
                }
                case "tu-6-9-trieu" -> {
                    minPrice = 6000000L;
                    maxPrice = 9000000L;
                }
                case "tren-9-trieu" -> minPrice = 9000000L;
            }
        }
        String searchKeyword = (keyword == null) ? null : "%" + keyword + "%";
        productEntities = productRepository.findAll(gender, searchKeyword, minPrice, maxPrice, pageable).getContent();
        System.out.println(productEntities.size());
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
