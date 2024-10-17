package com.hau.repository;

import com.hau.entity.WarrantyEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface WarrantyRepository extends JpaRepository<WarrantyEntity, Long> {
}
