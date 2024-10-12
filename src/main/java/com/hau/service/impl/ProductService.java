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
        Long minPrice =null;
        Long maxPrice =null;
        String gender = null;
        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = null;
        if(filter != null){
            if (filter.contains("duoi-1-trieu")) {
                minPrice = 0L;
                maxPrice = 1000000L;
            } else if (filter.contains("tu-1-3-trieu")) {
                minPrice = 1000000L;
                maxPrice = 3000000L;
            } else if (filter.contains("tu-3-6-trieu")) {
                minPrice = 3000000L;
                maxPrice = 6000000L;
            } else if (filter.contains("tu-6-9-trieu")) {
                minPrice = 6000000L;
                maxPrice = 9000000L;
            } else if (filter.contains("tren-9-trieu")) {
                minPrice = 9000000L;
                maxPrice = null; // Không giới hạn trên
            }

            if(filter.contains("nam")){
                gender = "nam";
            }
            else if(filter.contains("nu")){
                gender = "nu";
            }
        }

        String searchKeyword = (keyword == null) ? null : "%" + keyword + "%";
        productEntities = productRepository.findAll(gender, searchKeyword, minPrice, maxPrice, pageable).getContent();

        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }




    @Override
    public long getTotalItem(String keyword,String filter) {
        Long minPrice =null;
        Long maxPrice =null;
        String gender = null;
        if(filter != null){
            if (filter.contains("duoi-1-trieu")) {
                minPrice = 0L;
                maxPrice = 1000000L;
            } else if (filter.contains("tu-1-3-trieu")) {
                minPrice = 1000000L;
                maxPrice = 3000000L;
            } else if (filter.contains("tu-3-6-trieu")) {
                minPrice = 3000000L;
                maxPrice = 6000000L;
            } else if (filter.contains("tu-6-9-trieu")) {
                minPrice = 6000000L;
                maxPrice = 9000000L;
            } else if (filter.contains("tren-9-trieu")) {
                minPrice = 9000000L;
                maxPrice = null; // Không giới hạn trên
            }

            if(filter.contains("nam")){
                gender = "nam";
            }
            else if(filter.contains("nu")){
                gender = "nu";
            }
        }
        String searchKeyword = (keyword == null) ? null : "%" + keyword + "%";
        return  productRepository.count(gender,searchKeyword,minPrice,maxPrice);
    }
}
