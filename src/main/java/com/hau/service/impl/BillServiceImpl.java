package com.hau.service.impl;

import com.hau.constant.SystemConstant;
import com.hau.converter.BillConverter;
import com.hau.converter.CartItemConverter;
import com.hau.dto.BillDTO;
import com.hau.dto.CartItemDTO;
import com.hau.entity.*;
import com.hau.repository.*;
import com.hau.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BillServiceImpl implements BillService {
    @Autowired
    private BillRepository billRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private VoucherRepository voucherRepository;
    @Autowired
    private CartItemRepository cartItemRepository;
    @Autowired
    private BillConverter billConverter;
    @Autowired
    private CartItemConverter cartItemConverter;
    @Override
    @Transactional
    public BillDTO save(BillDTO billDTO) {
        BillEntity billEntity = billConverter.convertToEntity(billDTO);
        if(billDTO.getUsername() != null){
            UserEntity user = userRepository.findOneByUserNameAndStatus(billDTO.getUsername(), SystemConstant.ACTIVE_STATUS);
            billEntity.setUser(user);
        }

        List<CartItemEntity> cartItemEntities = new ArrayList<>();
        for(CartItemDTO cartItemDTO : billDTO.getCartItemDTOS()){
            CartItemEntity cartItemEntity = cartItemConverter.convertToEntity(cartItemDTO);
            ProductEntity productEntity = productRepository.findOneByNameAndActive(cartItemDTO.getProductName(),true);
            productEntity.setInstock(productEntity.getInstock() - Integer.parseInt(cartItemDTO.getQuantity()));
            if(cartItemDTO.getUsername() != null && cartItemDTO.getUsername() != "null"){
                UserEntity userEntity = userRepository.findOneByUserNameAndStatus(cartItemDTO.getUsername(),SystemConstant.ACTIVE_STATUS);
                cartItemEntity.setUser( userEntity);
            }
            cartItemEntity.setProduct(productEntity);
            cartItemRepository.save(cartItemEntity);
            productRepository.save(productEntity);
            cartItemEntities.add(cartItemEntity);
        }
        if(billDTO.getVoucherCode() != null){
           VoucherEntity voucherEntity =  voucherRepository.findOneByCode(billDTO.getVoucherCode());
           billEntity.setVoucher(voucherEntity);
        }

        billEntity.setCartItems(cartItemEntities);

        BillEntity bill= billRepository.save(billEntity);
        for(CartItemEntity cartItemEntity : cartItemEntities){
            cartItemEntity.setBill(bill);
        }
        return  billConverter.convertToDTO(billEntity);
    }

    @Override
    public void confirmPaidBill(Long id) {
        BillEntity billEntity = billRepository.findOne(id);
        billEntity.setStatus("Thanh toán thành công");
        billRepository.save(billEntity);
    }

    @Override
    public int getTotalUnpaidBill() {
        return billRepository.countTotalUnpaidBill();
    }

    @Override
    public int getTotalPaidBill() {
        return billRepository.countTotalPaidBill();
    }

    @Override
    public Double getTotalOfPaidBills() {
        Double total = billRepository.findTotalOfPaidBills();
        if(total == null){
            return 0.0;
        }
        return billRepository.findTotalOfPaidBills();
    }

    @Override
    public Page<BillDTO> getUnPaidBills(int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<BillEntity> billEntities = billRepository.findUnpaidBills(pageable);
        List<BillDTO> billDTOS = billEntities.getContent().stream().map(billEntity -> {
            BillDTO billDTO = billConverter.convertToDTO(billEntity);
            return billDTO;
        }).collect(Collectors.toList());
        return new PageImpl<>(billDTOS, pageable, billEntities.getTotalElements());
    }

    @Override
    public Page<BillDTO> getPaidBills(int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        Page<BillEntity> billEntities = billRepository.findPaidBills(pageable);
        List<BillDTO> billDTOS = billEntities.getContent().stream().map(billEntity -> {
            BillDTO billDTO = billConverter.convertToDTO(billEntity);
            return billDTO;
        }).collect(Collectors.toList());
        return new PageImpl<>(billDTOS, pageable, billEntities.getTotalElements());
    }

    @Override
    public Double getTotalOfSuccessfulBillsInMonth(int month, int year) {
        Double total = billRepository.findTotalOfSuccessfulBillsInMonth(month, year);
        if(total == null){
            return 0.0;
        }
        return billRepository.findTotalOfSuccessfulBillsInMonth(month, year);
    }

    @Override
    public BillDTO findByIdWithDetail(Long id) {
        BillEntity billEntity = billRepository.findOne(id);
        List<CartItemDTO> cartItemDTOS = billEntity.getCartItems().stream().map(cartItemEntity -> {
            CartItemDTO cartItemDTO = cartItemConverter.convertToDTO(cartItemEntity);
            cartItemDTO.setProductName(cartItemEntity.getProduct().getName());
            cartItemDTO.setProductImgUrl(cartItemEntity.getProduct().getImgUrl());
            cartItemDTO.setTotal(cartItemEntity.getQuantity() * cartItemEntity.getProduct().getPrice());
            return cartItemDTO;
        }).toList();
        BillDTO billDTO = billConverter.convertToDTO(billEntity);
        billDTO.setCartItemDTOS(cartItemDTOS);
        return billDTO;
    }


}
