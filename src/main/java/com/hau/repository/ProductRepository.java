package com.hau.repository;

import com.hau.entity.BrandEntity;
import com.hau.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductEntity,Long> {
    List<ProductEntity> findTop8ByOrderByIdDesc();
}
