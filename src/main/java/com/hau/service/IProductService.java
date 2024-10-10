package com.hau.service;

import com.hau.dto.ProductDTO;
import org.springframework.stereotype.Service;

import java.util.List;


public interface IProductService {
    public List<ProductDTO> findTop8ByOrderByIdDesc();
    public List<ProductDTO> findAll();
}
