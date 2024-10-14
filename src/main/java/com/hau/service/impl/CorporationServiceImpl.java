package com.hau.service.impl;

import com.hau.converter.Converter;
import com.hau.converter.CorporationConverter;
import com.hau.dto.CorporationDTO;
import com.hau.entity.CorporationEntity;
import com.hau.repository.CorporationRepository;
import com.hau.service.CorporationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CorporationServiceImpl implements CorporationService {
    private final CorporationRepository corporationRepository;
    private final Converter<CorporationDTO, CorporationEntity> converter;

    @Autowired
    public CorporationServiceImpl(CorporationRepository corporationRepository, Converter<CorporationDTO, CorporationEntity> converter) {
        this.corporationRepository = corporationRepository;
        this.converter = converter;
    }

    @Override
    public CorporationDTO getAllCorporationInformation() {
       List<CorporationEntity> list = corporationRepository.findAll();
        System.out.println("size: " + list.size());

        if (list.isEmpty()) {
            return new CorporationDTO();
        }
        System.out.println("id: " + list.getFirst().getId());
        return converter.convertToDTO(list.getFirst());
    }

    @Transactional
    @Override
    public void saveCorporation(CorporationDTO corporationDTO) {
        CorporationEntity corporationEntity = converter.convertToEntity(corporationDTO);
        corporationRepository.save(corporationEntity);
    }
}
