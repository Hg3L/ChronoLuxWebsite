package com.hau.repository;

import com.hau.entity.ProductLineEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductLineRepository extends JpaRepository<ProductLineEntity,Long> {

    List<ProductLineEntity> findAllByBrand_Id(Long brandId);

    ProductLineEntity findOneById(long id);
}
