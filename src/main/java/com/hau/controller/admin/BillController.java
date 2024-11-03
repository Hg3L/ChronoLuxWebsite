package com.hau.controller.admin;

import com.hau.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BillController {
    @Autowired
    private BillService billService;

    @GetMapping("/admin/bills")
    public String showBill(Model model,
                           @RequestParam(defaultValue = "1") int unpaidPage,
                            @RequestParam(defaultValue = "1") int paidPage,
                           @RequestParam(defaultValue = "100") int limit) {
        model.addAttribute("unpaidBillsPage", billService.getUnPaidBills(unpaidPage, limit));
        model.addAttribute("paidBillsPage", billService.getPaidBills(unpaidPage, limit));
        model.addAttribute("currentUnpaidPage", unpaidPage);
        model.addAttribute("currentPaidPage", paidPage);
        return "admin/bill-view";
    }

    @GetMapping("/admin/bill/update")
    public String updateBill(@RequestParam Long id,
                             RedirectAttributes redirectAttributes) {
        billService.confirmPaidBill(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xác nhận đơn hàng thanh toán thành công");
        return "redirect:/admin/bills";
    }

    @GetMapping("/admin/bill/view")
    public String viewBill(@RequestParam Long id,
                           Model model) {
        model.addAttribute("billDTO", billService.findByIdWithDetail(id));
        return "admin/bill-detail-view";
    }
}
