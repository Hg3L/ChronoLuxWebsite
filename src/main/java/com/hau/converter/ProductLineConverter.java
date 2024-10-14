package com.hau.converter;

import com.hau.dto.ProductLineDTO;
import com.hau.entity.ProductLineEntity;
import org.springframework.stereotype.Component;

@Component
public class ProductLineConverter implements Converter< ProductLineDTO,ProductLineEntity>{


    @Override
    public ProductLineDTO convertToDTO(ProductLineEntity entity) {
        ProductLineDTO productLineDTO = new ProductLineDTO();
        productLineDTO.setId(entity.getId());
        productLineDTO.setName(entity.getName());
        productLineDTO.setBrandId(entity.getBrand().getId());
        productLineDTO.setWarrantyId(entity.getWarranty().getId());
        return productLineDTO;
    }

    @Override
    public ProductLineEntity convertToEntity(ProductLineDTO dto) {
        return null;
    }
}
