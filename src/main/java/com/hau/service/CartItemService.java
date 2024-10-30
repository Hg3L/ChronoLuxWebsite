package com.hau.service;

import com.hau.dto.CartItemDTO;
import com.hau.dto.ProductDTO;
import com.hau.dto.UserDTO;
import com.hau.entity.CartItemEntity;
import com.hau.entity.UserEntity;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CartItemService {
    List<CartItemDTO> findAllByUser(UserDTO userDTO);
    CartItemDTO save(UserDTO userDTO, Long productId,Integer quantity);
    long getTotalPrice(UserDTO userDTO);
    void updateQuantity(UserDTO userDTO,Long productId,Integer quantity);
    void delete(UserDTO userDTO,Long productId);
}
