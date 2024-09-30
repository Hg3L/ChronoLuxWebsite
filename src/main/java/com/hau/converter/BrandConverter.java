package com.hau.converter;

import com.hau.dto.BrandDTO;

import com.hau.entity.BrandEntity;

import org.springframework.stereotype.Component;


@Component
public class BrandConverter {
    public BrandDTO toDTO(BrandEntity brandEntity){
        BrandDTO brandDTO = new BrandDTO();
        brandDTO.setIconUrl(brandEntity.getIconUrl());
        brandDTO.setCountry(brandEntity.getCountry());
        brandDTO.setName(brandEntity.getName());
        brandDTO.setBannerUrl(brandEntity.getBannerUrl());
        return brandDTO;
    }
    public BrandEntity toEntity(BrandDTO brandDTO){
        BrandEntity brandEntity = new BrandEntity();
        //save
        return brandEntity;
    }
}
