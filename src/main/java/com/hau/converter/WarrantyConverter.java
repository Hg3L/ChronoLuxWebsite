package com.hau.converter;

import com.hau.dto.WarrantyDTO;
import com.hau.entity.WarrantyEntity;
import org.springframework.stereotype.Component;

@Component
public class WarrantyConverter implements Converter<WarrantyEntity, WarrantyDTO> {
    @Override
    public WarrantyEntity convertToDTO(WarrantyDTO entity) {
        return null;
    }

    @Override
    public WarrantyDTO convertToEntity(WarrantyEntity dto) {
        return null;
    }
}
