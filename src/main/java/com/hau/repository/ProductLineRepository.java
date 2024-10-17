package com.hau.repository;

import com.hau.entity.ProductLineEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductLineRepository extends JpaRepository<ProductLineEntity,Long> {
    List<ProductLineEntity> findAllByBrand_Id(Long brandId);
    Page<ProductLineEntity> findAllByBrand_Id(Long brandId, Pageable page);
    ProductLineEntity findOneById(long id);
    Page<ProductLineEntity> findByWarrantyIsNotNull(Pageable pageable);
    Page<ProductLineEntity> findByWarrantyIsNull(Pageable pageable);
    Page<ProductLineEntity> findByBrand_IdAndWarrantyIsNotNull(Long brandId, Pageable pageable);
    Page<ProductLineEntity> findByBrand_IdAndWarrantyIsNull(Long brandId, Pageable pageable);
}
