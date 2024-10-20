package com.hau.service;

import com.hau.dto.VoucherDTO;

public interface VoucherService {
    VoucherDTO findOneByCode(String code);
}
