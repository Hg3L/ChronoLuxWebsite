package com.hau.converter;

import com.hau.dto.VoucherDTO;
import com.hau.entity.VoucherEntity;
import org.springframework.stereotype.Component;

@Component
public class VoucherConverter implements Converter<VoucherDTO, VoucherEntity>{
    @Override
    public VoucherDTO convertToDTO(VoucherEntity entity) {
        VoucherDTO voucherDTO = new VoucherDTO();
        voucherDTO.setCode(entity.getCode());
        voucherDTO.setDiscount(entity.getDiscount());
        voucherDTO.setBeginDay(entity.getBeginDay().toString());
        voucherDTO.setEndDay(entity.getEndDay().toString());
        return voucherDTO;
    }

    @Override
    public VoucherEntity convertToEntity(VoucherDTO dto) {
        return null;
    }
}
