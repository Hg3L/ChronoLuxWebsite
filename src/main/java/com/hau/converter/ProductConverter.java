package com.hau.converter;

import com.hau.dto.BrandDTO;
import com.hau.dto.ProductDTO;
import com.hau.dto.ProductLineDTO;
import com.hau.entity.BrandEntity;
import com.hau.entity.ProductEntity;
import org.springframework.stereotype.Component;

@Component
public class ProductConverter {
    public ProductDTO toDTO(ProductEntity productEntity){
        ProductDTO productDTO = new ProductDTO();
        productDTO.setId(productEntity.getId());
        productDTO.setWaterResistant(productEntity.getWaterResistant());
        productDTO.setFaceSize(productEntity.getFaceSize());
        productDTO.setGender(productEntity.getGender());
        productDTO.setGlassMaterial(productEntity.getGlassMaterial());
        productDTO.setPrice(productEntity.getPrice());
        productDTO.setThickness(productEntity.getThickness());
        productDTO.setWatchType(productEntity.getWatchType());
        productDTO.setImgUrl(productEntity.getImgUrl());
        productDTO.setStrapMaterial(productEntity.getStrapMaterial());
        productDTO.setName(productEntity.getName());
        productDTO.setProductLineName(productEntity.getProductLine().getName());
        productDTO.setBrandName(productEntity.getProductLine().getBrand().getName());
        productDTO.setCountry(productEntity.getProductLine().getBrand().getCountry());
        productDTO.setWarrantyContent(productEntity.getProductLine().getWarranty().getContent());
        return productDTO;
    }
    public ProductEntity toEntity(ProductDTO productDTO){
        ProductEntity productEntity = new ProductEntity();
        //save
        return productEntity;
    }
}
