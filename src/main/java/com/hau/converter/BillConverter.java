package com.hau.converter;

import com.hau.dto.BillDTO;
import com.hau.entity.BillEntity;
import org.springframework.stereotype.Component;

@Component
public class BillConverter implements Converter<BillDTO, BillEntity> {
    @Override
    public BillDTO convertToDTO(BillEntity entity) {
        return null;
    }

    @Override
    public BillEntity convertToEntity(BillDTO dto) {
        BillEntity billEntity = new BillEntity();
        billEntity.setGender(dto.getGender());
        billEntity.setAddress(dto.getStreet() +"-"+dto.getWard()+"-"+dto.getDistrict()+"-"+dto.getCity());
        billEntity.setDisplayName(dto.getUsername());
        billEntity.setPhone(dto.getPhone());
        billEntity.setNote(dto.getNote());
        billEntity.setTotal(dto.getTotal());
        billEntity.setDisplayName(dto.getDisplayName());
        billEntity.setStatus(dto.getStatus());
        billEntity.setEmail(dto.getEmail());
        billEntity.setSubtotal(dto.getSubtotal());
        billEntity.setReceiverName(dto.getReceiverName());
        billEntity.setReceiverGender(dto.getReceiverGender());
        billEntity.setReceiverPhone(dto.getReceiverPhone());
        billEntity.setPaymentMethod(dto.getPaymentMethod());
        return billEntity;
    }
}
