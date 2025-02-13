package com.hau.service;

import com.hau.dto.BillDTO;
import org.springframework.data.domain.Page;

import java.math.BigDecimal;
import java.util.List;

public interface BillService {
    BillDTO save(BillDTO billDTO);
    void confirmPaidBill(Long id);
    int getTotalUnpaidBill();
    int getTotalPaidBill();
    Double getTotalOfPaidBills();
    Page<BillDTO> getUnPaidBills(int page, int limit);
    Page<BillDTO> getPaidBills(int page, int limit);
    Double getTotalOfSuccessfulBillsInMonth(int month, int year);
    BillDTO findByIdWithDetail(Long id);
    List< BillDTO> getBillByUser(Long userId);
}
