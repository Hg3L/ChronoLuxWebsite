package com.hau.service.impl;

import com.hau.converter.BrandConverter;
import com.hau.dto.BrandDTO;
import com.hau.entity.BrandEntity;
import com.hau.repository.BrandRepository;
import com.hau.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BrandService implements IBrandService {
    @Autowired
    private BrandConverter brandConverter;
    @Autowired
    private BrandRepository brandRepository;
    @Override
    public List<BrandDTO> findAll() {
        List<BrandDTO> brands = new ArrayList<>();
        List<BrandEntity> brandEntities = brandRepository.findAllBrand();
        for(BrandEntity brandEntity : brandEntities){
            BrandDTO brand = brandConverter.toDTO(brandEntity);
            brands.add(brand);
        }
        return brands;
    }

    @Override
    public BrandDTO findOneById(Long id) {
        BrandEntity brandEntity = brandRepository.findOneById(id);
        return brandConverter.toDTO(brandEntity);
    }
}
