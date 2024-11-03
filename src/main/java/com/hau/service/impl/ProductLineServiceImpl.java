package com.hau.service.impl;

import com.hau.converter.Converter;
import com.hau.converter.ProductLineConverter;
import com.hau.dto.ProductLineDTO;
import com.hau.entity.BrandEntity;
import com.hau.entity.ProductLineEntity;
import com.hau.entity.WarrantyEntity;
import com.hau.repository.BrandRepository;
import com.hau.repository.ProductLineRepository;
import com.hau.repository.ProductRepository;
import com.hau.repository.WarrantyRepository;
import com.hau.service.ProductLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductLineServiceImpl implements ProductLineService {
    @Autowired
    private ProductLineRepository productLineRepository;
    @Autowired
    private Converter<ProductLineDTO,ProductLineEntity> productLineConverter;
    @Autowired
    private BrandRepository brandRepository;
    @Autowired
    private WarrantyRepository warrantyRepository;

    @Override
    public List<ProductLineDTO> findAllByBrandId(Long brandId) {
        List<ProductLineDTO> productLines = new ArrayList<>();
        List<ProductLineEntity> productLineEntities;
        if (brandId == 0){
            productLineEntities = productLineRepository.findAll();
        }
        else{
            productLineEntities = productLineRepository.findAllByBrand_Id(brandId);
        }
        for(ProductLineEntity productLineEntity : productLineEntities){
            ProductLineDTO productLine = productLineConverter.convertToDTO(productLineEntity);
            productLines.add(productLine);
        }
        return productLines;
    }

    @Override
    public ProductLineDTO findOneById(long id) {
        ProductLineEntity productLineEntity = productLineRepository.findOneById(id);
        return productLineConverter.convertToDTO(productLineEntity);
    }

    @Override
    public Page<ProductLineDTO> findAllByBrandId(Long brandId, int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductLineEntity> productLineEntities = productLineRepository.findAllByBrand_Id(brandId, pageable);
        List<ProductLineDTO> productLineDTOs = productLineEntities.getContent().stream().map(productLineEntity -> {
            ProductLineDTO productLineDTO = productLineConverter.convertToDTO(productLineEntity);
            productLineDTO.setBrandName(productLineEntity.getBrand().getName());
            return productLineDTO;
        }).collect(Collectors.toList());
        return new PageImpl<>(productLineDTOs, pageable, productLineEntities.getTotalElements());
    }

    @Override
    public Page<ProductLineDTO> findAll(int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductLineEntity> productLineEntities = productLineRepository.findAll(pageable);

        List<ProductLineDTO> productLineDTOs = productLineEntities.getContent().stream().map(productLineEntity -> {
            ProductLineDTO productLineDTO = productLineConverter.convertToDTO(productLineEntity);
            productLineDTO.setBrandName(productLineEntity.getBrand().getName());
            return productLineDTO;
        }).collect(Collectors.toList());

        return new PageImpl<>(productLineDTOs, pageable, productLineEntities.getTotalElements());
    }

    @Override
    public Page<ProductLineDTO> findAllWithWarranty(int page, int limit, boolean isHasWarranty) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductLineEntity> productLineEntities;
        if(isHasWarranty){
            productLineEntities = productLineRepository.findByWarrantyIsNotNull(pageable);
        }
        else{
            productLineEntities = productLineRepository.findByWarrantyIsNull(pageable);
        }
        List<ProductLineDTO> productLineDTOs = productLineEntities.getContent().stream().map(productLineEntity -> {
            ProductLineDTO productLineDTO = productLineConverter.convertToDTO(productLineEntity);
            productLineDTO.setBrandName(productLineEntity.getBrand().getName());
            return productLineDTO;
        }).collect(Collectors.toList());

        return new PageImpl<>(productLineDTOs, pageable, productLineEntities.getTotalElements());
    }

    @Override
    public Page<ProductLineDTO> findAllWithWarrantyByBrandId(int page, int limit, boolean isHasWarranty, Long brandId) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<ProductLineEntity> productLineEntities;
        if(isHasWarranty){
            productLineEntities = productLineRepository.findByBrand_IdAndWarrantyIsNotNull(brandId, pageable);
        }
        else{
            productLineEntities = productLineRepository.findByBrand_IdAndWarrantyIsNull(brandId, pageable);
        }
        List<ProductLineDTO> productLineDTOs = productLineEntities.getContent().stream().map(productLineEntity -> {
            ProductLineDTO productLineDTO = productLineConverter.convertToDTO(productLineEntity);
            productLineDTO.setBrandName(productLineEntity.getBrand().getName());
            return productLineDTO;
        }).collect(Collectors.toList());

        return new PageImpl<>(productLineDTOs, pageable, productLineEntities.getTotalElements());
    }

    @Transactional
    @Override
    public void save( ProductLineDTO productLineDTO) {
        ProductLineEntity productLineEntity = productLineConverter.convertToEntity(productLineDTO);
        BrandEntity brandEntity = brandRepository.findOneById(productLineDTO.getBrandId());
        WarrantyEntity warrantyEntity = warrantyRepository.findByProductLineEntity_Id(productLineDTO.getId());
        productLineEntity.setBrand(brandEntity);
        warrantyEntity.setProductLineEntity(productLineEntity);
        productLineEntity.setWarranty(warrantyEntity);
        productLineRepository.save(productLineEntity);
    }

    @Transactional
    @Override
    public void deleteById(Long id) {
        productLineRepository.delete(id);
    }
}
