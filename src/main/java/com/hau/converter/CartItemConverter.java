package com.hau.converter;

import com.hau.dto.CartItemDTO;
import com.hau.entity.CartItemEntity;
import org.springframework.stereotype.Component;

@Component
public class CartItemConverter implements Converter<CartItemDTO, CartItemEntity>{
    @Override
    public CartItemDTO convertToDTO(CartItemEntity entity) {
        CartItemDTO cartItemDTO = new CartItemDTO();
        cartItemDTO.setId(entity.getId());
        cartItemDTO.setProductId(entity.getProduct().getId());
        cartItemDTO.setUserId(entity.getUser().getId());
        cartItemDTO.setCustomerName(entity.getUser().getFullName());
        cartItemDTO.setProductName(entity.getProduct().getName());
        cartItemDTO.setProductPrice(entity.getProduct().getPrice());
        cartItemDTO.setQuantity(entity.getQuantity());
        cartItemDTO.setProductImgUrl(entity.getProduct().getImgUrl());
        cartItemDTO.setProductQuantity(entity.getProduct().getInstock());
        return cartItemDTO;
    }

    @Override
    public CartItemEntity convertToEntity(CartItemDTO cartItemDTO) {
        CartItemEntity cartItemEntity = new CartItemEntity();
        cartItemEntity.setQuantity(Integer.parseInt(cartItemDTO.getQuantity()));
        return cartItemEntity;
    }
}
