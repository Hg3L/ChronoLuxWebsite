package com.hau.service;

import com.hau.dto.ProductLineDTO;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductLineService {
    public List<ProductLineDTO> findAllByBrandId(Long brandId);
    public ProductLineDTO findOneById(long id);
    Page<ProductLineDTO> findAllByBrandId(Long brandId, int page, int limit);
    Page<ProductLineDTO> findAll(int page, int limit);
    void save(ProductLineDTO productLineDTO);
    void deleteById(Long id);
}
