package com.hau.repository;

import com.hau.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity,Long> {
    public UserEntity findOneByUserNameAndStatus(String username,Integer status);
}
