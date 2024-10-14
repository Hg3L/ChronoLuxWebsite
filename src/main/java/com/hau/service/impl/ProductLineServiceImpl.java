package com.hau.service.impl;

import com.hau.converter.Converter;
import com.hau.converter.ProductLineConverter;
import com.hau.dto.ProductLineDTO;
import com.hau.entity.ProductLineEntity;
import com.hau.repository.ProductLineRepository;
import com.hau.repository.ProductRepository;
import com.hau.service.ProductLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductLineServiceImpl implements ProductLineService {
    @Autowired
    private ProductLineRepository productLineRepository;
    @Autowired
    private Converter<ProductLineDTO,ProductLineEntity> productLineConverter;
    @Override
    public List<ProductLineDTO> findAllByBrandId(Long brandId) {
        List<ProductLineDTO> productLines = new ArrayList<>();
        List<ProductLineEntity> productLineEntities = productLineRepository.findAllByBrand_Id(brandId);
        for(ProductLineEntity productLineEntity : productLineEntities){
            ProductLineDTO productLine = productLineConverter.convertToDTO(productLineEntity);
            productLines.add(productLine);
        }
        return productLines;
    }

    @Override
    public ProductLineDTO findOneById(long id) {
        ProductLineEntity productLineEntity = productLineRepository.findOneById(id);
        return productLineConverter.convertToDTO(productLineEntity);
    }
}
