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

    @Query("SELECT p FROM ProductEntity p WHERE "
            + "CONCAT(p.name, ' ', p.price, ' ', p.gender) LIKE %?1% "
            + "AND (p.price BETWEEN ?2 AND ?3)")
    Page<ProductEntity> findAll(Pageable pageable, String keyword, long minPrice, long maxPrice);

    @Query("SELECT p FROM ProductEntity p WHERE p.price BETWEEN ?1 AND ?2")
    Page<ProductEntity> findAll(Pageable pageable, long minPrice, long maxPrice);

    @Query("SELECT p FROM ProductEntity p WHERE p.price > ?1")
    Page<ProductEntity> findAll(Pageable pageable, long Price);

    @Query("SELECT p FROM ProductEntity p WHERE "
            + "CONCAT(p.name, ' ', p.price, ' ', p.gender) LIKE %?1% "
            + "AND (p.price > ?2)")
    Page<ProductEntity> findAll(Pageable pageable, String keyword, long minPrice);



}
