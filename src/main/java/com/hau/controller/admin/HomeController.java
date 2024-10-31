package com.hau.controller.admin;

import com.hau.service.BillService;
import com.hau.service.CurrencyFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Controller(value = "ControllerOfAdmin")
public class HomeController {
    @Autowired
    private BillService billService;
    @Autowired
    private CurrencyFormat currencyFormat;

    @RequestMapping("/admin/home")
    public String showDashboard(Model model) {
        model.addAttribute("totalUnpaidBill", billService.getTotalUnpaidBill());
        model.addAttribute("totalPaidBill", billService.getTotalPaidBill());
        int currentMonth = LocalDate.now().getMonthValue();
        int currentYear = LocalDate.now().getYear();
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("currentYear", currentYear);
        model.addAttribute("totalOfPaidBills", currencyFormat.formatCurrency(billService.getTotalOfPaidBills()));
        model.addAttribute("totalOfSuccessfulBillsInMonth", currencyFormat.formatCurrency(billService.getTotalOfSuccessfulBillsInMonth(currentMonth, currentYear)));
        return "admin/home";
    }

    @GetMapping("/admin/total")
    @ResponseBody
    public ResponseEntity<Double> getMonthlyTotal(
            @RequestParam("month") int month,
            @RequestParam("year") int year
    ) {
        Double total = billService.getTotalOfSuccessfulBillsInMonth(month, year);
        return ResponseEntity.ok(total != null ? total : 0.0);
    }

}
