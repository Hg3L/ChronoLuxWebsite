package com.hau.service;

import com.hau.dto.BillDTO;
import org.springframework.data.domain.Page;

import java.math.BigDecimal;

public interface BillService {
    void save(BillDTO billDTO);
    int getTotalUnpaidBill();
    int getTotalPaidBill();
    Double getTotalOfPaidBills();
    Page<BillDTO> getUnPaidBills(int page, int limit);
    Page<BillDTO> getPaidBills(int page, int limit);
    Double getTotalOfSuccessfulBillsInMonth(int month, int year);
}