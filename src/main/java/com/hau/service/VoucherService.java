package com.hau.service;

import com.hau.dto.VoucherDTO;
import org.springframework.data.domain.Page;

public interface VoucherService {
    VoucherDTO findOneByCode(String code);
    Page<VoucherDTO> findValidVouchers(int validVoucherPage, int limit);
    Page<VoucherDTO> findExpiredVouchers(int expiredVoucherPage, int limit);
    void save(VoucherDTO voucherDTO);
}
