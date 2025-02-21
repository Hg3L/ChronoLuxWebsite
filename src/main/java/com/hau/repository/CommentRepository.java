package com.hau.repository;

import com.hau.entity.CommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CommentRepository extends JpaRepository<CommentEntity ,Long> {
    Optional<List<CommentEntity> > findByProductId(Long id);
    Optional<CommentEntity> findById(Long id);
    Integer countByProductId(Long id);
}
