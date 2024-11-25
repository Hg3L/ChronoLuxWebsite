package com.hau.service;

import com.hau.dto.BrandDTO;
import org.springframework.data.domain.Page;

import java.util.List;

public interface BrandService {
    List<BrandDTO> findAll();
    Page<BrandDTO> findAll(int page, int limit);
    BrandDTO getBrandById(Long id);
    void saveBrand(BrandDTO brandDTO);
    void deleteBrandById(Long id);
}
