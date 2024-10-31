package com.hau.converter;

import com.hau.dto.VoucherDTO;
import com.hau.entity.VoucherEntity;
import org.springframework.stereotype.Component;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
        VoucherEntity voucherEntity = new VoucherEntity();
        voucherEntity.setCode(dto.getCode());
        voucherEntity.setDiscount(dto.getDiscount());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate beginDate = LocalDate.parse(dto.getBeginDay(), formatter);
        LocalDate endDate = LocalDate.parse(dto.getEndDay(), formatter);
        LocalDateTime beginDateTime = beginDate.atStartOfDay();
        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
        voucherEntity.setBeginDay(Date.valueOf(beginDateTime.toLocalDate()));
        voucherEntity.setEndDay(Date.valueOf(endDateTime.toLocalDate()));
        return voucherEntity;
    }
}
