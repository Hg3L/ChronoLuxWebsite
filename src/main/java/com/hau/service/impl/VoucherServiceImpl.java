package com.hau.service.impl;

import com.hau.converter.VoucherConverter;
import com.hau.dto.VoucherDTO;
import com.hau.repository.VoucherRepository;
import com.hau.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VoucherServiceImpl implements VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;
    @Autowired
    private VoucherConverter voucherConverter;
    @Override
    public VoucherDTO findOneByCode(String code) {
        if(code != null && !code.isEmpty()){
            return voucherConverter.convertToDTO(voucherRepository.findOneByCode(code));
        }
        else return null;
    }
}
