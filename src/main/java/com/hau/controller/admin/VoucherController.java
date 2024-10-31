package com.hau.controller.admin;

import com.hau.dto.VoucherDTO;
import com.hau.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
public class VoucherController {
    @Autowired
    private VoucherService voucherService;

    @GetMapping("/admin/vouchers")
    public String showVouchers(Model model,
                               @RequestParam(defaultValue = "1") int validVoucherPage,
                               @RequestParam(defaultValue = "1") int expiredVoucherPage,
                               @RequestParam(defaultValue = "10") int limit) {
        model.addAttribute("validVouchers", voucherService.findValidVouchers(validVoucherPage, limit));
        model.addAttribute("expiredVouchers", voucherService.findExpiredVouchers(expiredVoucherPage, limit));
        model.addAttribute("currentValidVoucherPage", validVoucherPage);
        model.addAttribute("currentExpiredVoucherPage", expiredVoucherPage);
        return "admin/vouchers-view";
    }

    @GetMapping("/admin/voucher/create")
    public String showCreateVoucherForm(Model model) {
        model.addAttribute("voucher", new VoucherDTO());
        return "admin/voucher-add";
    }

    @PostMapping("/admin/voucher/save")
    public String saveVoucher(@ModelAttribute("voucher") VoucherDTO voucherDTO,
                              HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        voucherService.save(voucherDTO);
        return "redirect:/admin/vouchers";
    }
}
