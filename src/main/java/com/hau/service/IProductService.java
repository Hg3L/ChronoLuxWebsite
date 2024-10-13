package com.hau.service;

import com.hau.dto.ProductDTO;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;


public interface IProductService {
    public List<ProductDTO> findTop8ByOrderByIdDesc();
    public List<ProductDTO> findAll(Pageable pageable,String keyword,String filter);
    public long getTotalItem(String keyword,String filter);
    public List<ProductDTO> findAllByIdBrand(Pageable pageable,Long id,String keyword,String filter);
    public long getTotalItemByIdBrand(Long id,String keyword,String filter);
}
