package com.hau.service.impl;

import com.hau.converter.ProductConverter;
import com.hau.dto.ProductDTO;
import com.hau.entity.ProductEntity;
import com.hau.repository.ProductRepository;
import com.hau.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
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
    public List<ProductDTO> findAll() {
        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = productRepository.findAll();
        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }
}
