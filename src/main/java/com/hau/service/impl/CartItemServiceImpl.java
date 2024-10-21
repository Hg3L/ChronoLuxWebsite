package com.hau.service.impl;

import com.hau.converter.Converter;
import com.hau.converter.UserConverter;
import com.hau.dto.CartItemDTO;
import com.hau.dto.UserDTO;
import com.hau.entity.CartItemEntity;
import com.hau.entity.ProductEntity;
import com.hau.entity.UserEntity;
import com.hau.repository.CartItemRepository;
import com.hau.repository.ProductRepository;
import com.hau.repository.UserRepository;
import com.hau.service.CartItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
@Service
public class CartItemServiceImpl implements CartItemService {
    @Autowired
    private CartItemRepository cartItemRepository;
    @Autowired
    private Converter<CartItemDTO,CartItemEntity> cartItemConverter;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private ProductRepository productRepository;
    @Override
    public List<CartItemDTO> findAllByUser(UserDTO userDTO) {
        List<CartItemDTO> cartItemList = new ArrayList<>();
        UserEntity user = userRepository.findOne(userDTO.getId());
        for(CartItemEntity cartItemEntity : cartItemRepository.findAllByUser(user)){
            CartItemDTO cartItemDTO = cartItemConverter.convertToDTO(cartItemEntity);
            cartItemList.add(cartItemDTO);
        }
        return cartItemList;
    }

    @Override
    @Transactional
    public CartItemDTO save(UserDTO userDTO,Long productId, Integer quantity) {
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        ProductEntity productEntity = productRepository.findOne(productId);
        CartItemEntity cartItemEntity = cartItemRepository.findOneByUserAndProduct(userEntity,productEntity);
        if(cartItemEntity != null){
            cartItemEntity.setQuantity(cartItemEntity.getQuantity() + quantity);
        }
        else{
            cartItemEntity = new CartItemEntity();
            cartItemEntity.setUser(userEntity);
            cartItemEntity.setProduct(productEntity);
            cartItemEntity.setQuantity(quantity);
        }
        return cartItemConverter.convertToDTO(cartItemRepository.save(cartItemEntity)) ;
    }

    @Override
    public long getTotalPrice(UserDTO userDTO) {
        long totalPrice = 0L;
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        for(CartItemEntity cartItemEntity : cartItemRepository.findAllByUser(userEntity)){
            totalPrice += cartItemEntity.getSubTotal() ;

        }
        return totalPrice;
    }

    @Override
    @Transactional
    public void updateQuantity(UserDTO userDTO, Long productId, Integer quantity) {
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        ProductEntity productEntity = productRepository.findOne(productId);
        CartItemEntity cartItemEntity = cartItemRepository.findOneByUserAndProduct(userEntity,productEntity);
        cartItemEntity.setQuantity(quantity);
        cartItemRepository.save(cartItemEntity);
    }

    @Override
    @Transactional
    public void delete(UserDTO userDTO, Long productId) {
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        ProductEntity productEntity = productRepository.findOne(productId);
        CartItemEntity cartItemEntity = cartItemRepository.findOneByUserAndProduct(userEntity,productEntity);
        cartItemRepository.delete(cartItemEntity);
    }

}
