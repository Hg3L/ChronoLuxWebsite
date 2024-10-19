package com.hau.repository;

import com.hau.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<UserEntity,Long> {
    public UserEntity findOneByUserNameAndStatus(String username,Integer status);

    public UserEntity findOneByResetPasswordToken(String token);

    @Query("SELECT u FROM UserEntity u JOIN u.roles r WHERE u.email = :email AND r.code = :roleCode")
    UserEntity findByEmailAndRoleCode(@Param("email") String email, @Param("roleCode") String roleCode);


    @Query("SELECT u FROM UserEntity u WHERE u.email = :email AND u.password IS NOT NULL ")
    UserEntity findOneByEmailAndPasswordNotNull(@Param("email") String email);

}
