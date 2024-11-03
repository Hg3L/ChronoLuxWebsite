package com.hau.repository;

import com.hau.entity.BillEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.math.BigInteger;

public interface BillRepository extends JpaRepository<BillEntity,Long> {
    @Query("SELECT COUNT(b) FROM BillEntity b WHERE b.status = 'Chờ thanh toán'")
    int countTotalUnpaidBill();

    @Query("SELECT COUNT(b) FROM BillEntity b WHERE b.status = 'Thanh toán thành công'")
    int countTotalPaidBill();

    @Query("SELECT b FROM BillEntity b WHERE b.status = 'Chờ thanh toán' ORDER BY b.createDate DESC")
    Page<BillEntity> findUnpaidBills(Pageable pageable);

    @Query("SELECT b FROM BillEntity b WHERE b.status = 'Thanh toán thành công' ORDER BY b.modifiedDate DESC")
    Page<BillEntity> findPaidBills(Pageable pageable);


    @Query("SELECT SUM(b.total) FROM BillEntity b WHERE b.status = 'Thanh toán thành công'")
    Double findTotalOfPaidBills();

    @Query("SELECT SUM(b.total) FROM BillEntity b " +
            "WHERE b.status = 'Thanh toán thành công' " +
            "AND MONTH(b.createDate) = :month " +
            "AND YEAR(b.createDate) = :year")
    Double findTotalOfSuccessfulBillsInMonth(@Param("month") int month,@Param("year") int year);

    /*@Query("SELECT b FROM BillEntity b " +
            "LEFT JOIN FETCH b.voucher " +
            "LEFT JOIN FETCH b.user " +
            "LEFT JOIN FETCH b.products " +
            "LEFT JOIN FETCH b.cartItems " +
            "WHERE b.id = :billId")
    BillEntity findBillWithDetailsById(Long billId);*/
}
