package com.hau.controller.admin;

import com.hau.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BillController {
    @Autowired
    private BillService billService;

    @GetMapping("/admin/bills")
    public String showBill(Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "10") int limit) {
        model.addAttribute("unpaidBillsPage", billService.getUnPaidBills(page, limit));
        model.addAttribute("paidBillsPage", billService.getPaidBills(page, limit));
        model.addAttribute("currentUnpaidPage", page);
        return "admin/bill-view";
    }
}
