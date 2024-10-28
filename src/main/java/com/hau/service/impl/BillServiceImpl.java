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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

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
    public void save(BillDTO billDTO) {
        BillEntity billEntity = billConverter.convertToEntity(billDTO);
        if(billDTO.getUsername() != null){
            UserEntity user = userRepository.findOneByUserNameAndStatus(billDTO.getUsername(), SystemConstant.ACTIVE_STATUS);
            billEntity.setUser(user);
        }

        List<CartItemEntity> cartItemEntities = new ArrayList<>();
        for(CartItemDTO cartItemDTO : billDTO.getCartItemDTOS()){
            CartItemEntity cartItemEntity = cartItemConverter.convertToEntity(cartItemDTO);
            ProductEntity productEntity = productRepository.findOneByName(cartItemDTO.getProductName());
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
    }
}
