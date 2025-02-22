package com.hau.controller.web;

import com.hau.dto.BillDTO;
import com.hau.dto.UserDTO;
import com.hau.service.BillService;
import com.hau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/user-order")
public class UserOrderController {
    @Autowired
    private BillService billService;
    @Autowired
    private UserService userService;
    @GetMapping
    public String userOrder(Model model, @AuthenticationPrincipal Authentication authentication) {
        UserDTO user = userService.getCurrentLoggedInCustomer(authentication);
        List<BillDTO> billDTO = billService.getBillByUser(user.getId());
        model.addAttribute("bill",billDTO);
        return "web/user-order";
    }
}
