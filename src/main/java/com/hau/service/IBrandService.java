package com.hau.service;

import com.hau.dto.BrandDTO;
import com.hau.entity.BrandEntity;

import java.util.List;

public interface IBrandService {
    public List<BrandDTO> findAll();
}
