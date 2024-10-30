package com.hau.controller.admin;

import com.hau.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BillController {
    @Autowired
    private BillService billService;

    @GetMapping("/admin/bills")
    public String showBill() {
        return "admin/bill-view";
    }
}
