package com.hau.repository;

import com.hau.entity.CartItemEntity;
import com.hau.entity.ProductEntity;
import com.hau.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CartItemRepository extends JpaRepository<CartItemEntity,Long> {
    List<CartItemEntity> findAllByUser(UserEntity user);
    CartItemEntity findOneByUserAndProduct(UserEntity user, ProductEntity productEntity);
    Page<CartItemEntity> findByUserId(Pageable pageable, Long userId);
}
