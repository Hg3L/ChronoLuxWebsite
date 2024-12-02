package com.hau.repository;

import com.hau.entity.BrandEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BrandRepository extends JpaRepository<BrandEntity, Long> {

    List<BrandEntity>  findAllByActive(boolean active);
    BrandEntity findOneByIdAndActive(long id,boolean active);

    Page<BrandEntity> findAllByActive(boolean active, Pageable pageable);
}
