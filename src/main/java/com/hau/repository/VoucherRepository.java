package com.hau.repository;

import com.hau.entity.VoucherEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;

public interface VoucherRepository extends JpaRepository<VoucherEntity,Long> {

    VoucherEntity findOneByCode(String code);
    @Query("SELECT v FROM VoucherEntity v WHERE v.code = :code AND :currentDate BETWEEN v.beginDay AND v.endDay")
    VoucherEntity findOneByCodeAndValidVoucher(@Param("code") String code, @Param("currentDate") Date currentDate);

    @Query("SELECT v FROM VoucherEntity v WHERE v.endDay >= ?1 ORDER BY v.beginDay DESC")
    Page<VoucherEntity> findValidVouchers(Pageable pageable, Date now);

    @Query("SELECT v FROM VoucherEntity v WHERE v.endDay < ?1 ORDER BY v.beginDay DESC")
    Page<VoucherEntity> findExpiredVouchers(Pageable pageable, Date now);
}
