package com.hau.repository;

import com.hau.entity.BrandEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BrandRepository extends JpaRepository<BrandEntity, Long> {
    @Query ("SELECT b FROM BrandEntity b WHERE b.active = true")
    public List<BrandEntity>  findAllBrand();
    public BrandEntity findOneById(long id);
}
