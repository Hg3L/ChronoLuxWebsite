package com.hau.repository;

import com.hau.entity.BrandEntity;
import com.hau.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductEntity,Long> {
    List<ProductEntity> findTop8ByOrderByIdDesc();
    @Query("Select p from ProductEntity p Where "
            + "CONCAT(p.name,' ', p.price,' ', p.gender)" +
            " Like %?1%")
    Page<ProductEntity> findAll(Pageable pageable,String keyword);

    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE " +
            "CONCAT(p.name, ' ', p.price, ' ', p.gender) LIKE %?1%")
    long count(String keyword);
}
