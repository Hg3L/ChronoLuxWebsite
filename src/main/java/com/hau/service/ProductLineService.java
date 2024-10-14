package com.hau.service;

import com.hau.dto.ProductLineDTO;

import java.util.List;

public interface ProductLineService {
    public List<ProductLineDTO> findAllByBrandId(Long brandId);
    public ProductLineDTO findOneById(long id);
}
