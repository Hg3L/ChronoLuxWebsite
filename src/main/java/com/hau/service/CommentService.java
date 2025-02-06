package com.hau.service;

import com.hau.dto.CommentDTO;

import java.util.List;

public interface CommentService {
    void save(CommentDTO commentDTO);
    List<CommentDTO> findByProductId(Long id);
}
