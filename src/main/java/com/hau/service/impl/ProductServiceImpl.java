package com.hau.service.impl;

import com.hau.converter.ProductConverter;
import com.hau.dto.FilterCriteria;
import com.hau.dto.ProductDTO;
import com.hau.entity.ProductEntity;
import com.hau.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements com.hau.service.ProductService {
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

        List<ProductDTO> products = new ArrayList<>();
        List<ProductEntity> productEntities = null;
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        productEntities = productRepository.findAll(filterCriteria.getGender(),filterCriteria.getKeyword(),
                filterCriteria.getMinPrice(), filterCriteria.getMaxPrice(),
                pageable).getContent();

        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }


    @Override
    public long getTotalItem(String keyword,String filter) {
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        return  productRepository.count(filterCriteria.getGender(),filterCriteria.getKeyword(),filterCriteria.getMinPrice(),filterCriteria.getMaxPrice());
    }

    @Override
    public List<ProductDTO> findAllByIdBrand(Pageable pageable,Long id,String keyword,String filter) {
        List<ProductEntity> productEntities = null;
        List<ProductDTO> products = new ArrayList<>();
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        productEntities = productRepository.findAllByIdBrand(id,filterCriteria.getGender(),filterCriteria.getKeyword(),
                filterCriteria.getMinPrice(), filterCriteria.getMaxPrice(),
                pageable).getContent();
        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }

    @Override
    public long getTotalItemByIdBrand(Long id, String keyword, String filter) {
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        return  productRepository.countByIdBrand(id,filterCriteria.getGender(),filterCriteria.getKeyword(),filterCriteria.getMinPrice(),filterCriteria.getMaxPrice());
    }

    @Override
    public long getTotalItemByIdProductLine(Long id, String keyword, String filter) {
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        return  productRepository.countByIdProductLine(id,filterCriteria.getGender(),filterCriteria.getKeyword(),filterCriteria.getMinPrice(),filterCriteria.getMaxPrice());
    }

    @Override
    public List<ProductDTO> findAllByIdProductLine(Pageable pageable, Long id, String keyword, String filter) {
        List<ProductEntity> productEntities = null;
        List<ProductDTO> products = new ArrayList<>();
        FilterCriteria filterCriteria =  FilterCriteria.Of(filter,keyword);
        productEntities = productRepository.findAllByIdProductLine(id,filterCriteria.getGender(),filterCriteria.getKeyword(),
                filterCriteria.getMinPrice(), filterCriteria.getMaxPrice(),
                pageable).getContent();
        for(ProductEntity productEntity : productEntities){
            ProductDTO product = productConverter.toDTO(productEntity);
            products.add(product);
        }
        return products;
    }

    @Override
    public ProductDTO findOneById(long id) {
        ProductEntity productEntity = productRepository.findOne(id);
        return productConverter.toDTO(productEntity);
    }

    @Override
    public Page<ProductDTO> findByProductLine_Id(Long id, int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductEntity> productEntities = productRepository.findAllByProductLine_Id(id, pageable);
        List<ProductDTO> productDTOs = productEntities.getContent().stream().map(productEntity -> {
            ProductDTO productDTO = productConverter.toDTO(productEntity);
            productDTO.setBrandName(productEntity.getProductLine().getBrand().getName());
            productDTO.setProductLineName(productEntity.getProductLine().getName());
            return productDTO;
        }).collect(Collectors.toList());
        return new PageImpl<>(productDTOs, pageable, productEntities.getTotalElements());
    }

    @Override
    public Page<ProductDTO> findAll(int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductEntity> productEntities = productRepository.findAll(pageable);

        List<ProductDTO> productDTOs = productEntities.getContent().stream().map(productEntity -> {
            ProductDTO productDTO = productConverter.toDTO(productEntity);
            productDTO.setBrandName(productEntity.getProductLine().getBrand().getName());
            productDTO.setProductLineName(productEntity.getProductLine().getName());
            return productDTO;
        }).collect(Collectors.toList());

        return new PageImpl<>(productDTOs, pageable, productEntities.getTotalElements());
    }

}