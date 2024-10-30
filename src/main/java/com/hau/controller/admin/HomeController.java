package com.hau.controller.admin;

import com.hau.service.BillService;
import com.hau.service.CurrencyFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;

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
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("totalOfPaidBills", currencyFormat.formatCurrency(billService.getTotalOfPaidBills()));
        model.addAttribute("totalOfSuccessfulBillsInMonth", currencyFormat.formatCurrency(billService.getTotalOfSuccessfulBillsInMonth(currentMonth, LocalDate.now().getYear())));
        return "admin/home";
    }
}
