package com.hau.service.impl;

import com.hau.Enum.VoucherType;
import com.hau.converter.VoucherConverter;
import com.hau.dto.VoucherDTO;
import com.hau.entity.VoucherEntity;
import com.hau.repository.VoucherRepository;
import com.hau.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.chrono.ChronoLocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

@Service
public class VoucherServiceImpl implements VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;
    @Autowired
    private VoucherConverter voucherConverter;
    @Override
    public VoucherDTO findOneByCode(String code) {
        VoucherDTO voucherDTO = null;
        if (code != null && !code.isEmpty()) {
            Date now = new Date();
            if (voucherRepository.findOneByCodeAndValidVoucher(code, now) != null) {
                return voucherConverter.convertToDTO(voucherRepository.findOneByCodeAndValidVoucher(code,now));
            }
        }
        return null;
    }


    @Override
    public Page<VoucherDTO> findValidVouchers(int validVoucherPage, int limit) {
        Pageable pageable = new PageRequest(validVoucherPage - 1, limit);
        Date now = new Date();
        Page<VoucherEntity> voucherEntities = voucherRepository.findValidVouchers(pageable, now);
        return voucherEntities.map(voucherConverter::convertToDTO);
    }

    @Override
    public Page<VoucherDTO> findExpiredVouchers(int expiredVoucherPage, int limit) {
        Pageable pageable = new PageRequest(expiredVoucherPage - 1, limit);
        Date now = new Date();
        Page<VoucherEntity> voucherEntities = voucherRepository.findExpiredVouchers(pageable, now);
        return voucherEntities.map(voucherConverter::convertToDTO);
    }

    @Override
    public void save(VoucherDTO voucherDTO) {
        VoucherEntity voucherEntity = voucherConverter.convertToEntity(voucherDTO);
        voucherRepository.save(voucherEntity);
    }

    @Override
    public VoucherDTO findOneById(Long id) {
        if(id !=null){
            VoucherEntity voucherEntity = voucherRepository.findOne(id);
            if (ChronoUnit.DAYS
                    .between(convertToChronoLocalDate(voucherEntity.getBeginDay())
                            ,convertToChronoLocalDate(voucherEntity.getEndDay())) >= 0) {
                return voucherConverter.convertToDTO(voucherEntity);
            }
        }
        return  null;
    }

    @Override
    public List<VoucherDTO> findByType(VoucherType voucherType) {
        return voucherRepository.findByType(voucherType).stream()
                .map(voucherEntity -> voucherConverter.convertToDTO(voucherEntity))
                .toList();
    }

    private static ChronoLocalDate convertToChronoLocalDate(Date date) {
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }
}
