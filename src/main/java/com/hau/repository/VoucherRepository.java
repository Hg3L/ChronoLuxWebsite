package com.hau.repository;

import com.hau.entity.VoucherEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoucherRepository extends JpaRepository<VoucherEntity,Long> {
    VoucherEntity findOneByCode(String code);
}
