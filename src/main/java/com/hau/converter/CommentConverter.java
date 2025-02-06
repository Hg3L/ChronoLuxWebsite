package com.hau.converter;

import com.hau.dto.CommentDTO;
import com.hau.entity.CommentEntity;
import org.springframework.stereotype.Component;

@Component
public class CommentConverter implements Converter<CommentDTO, CommentEntity>{
    @Override
    public CommentDTO convertToDTO(CommentEntity entity) {
        CommentDTO commentDTO = new CommentDTO();
        commentDTO.setProductId(entity.getProduct().getId());
        commentDTO.setUserId(entity.getUser().getId());
        commentDTO.setRating(entity.getRating());
        commentDTO.setReview(entity.getReview());
        commentDTO.setImgUrl(entity.getUser().getImgUrl());
        commentDTO.setUsername(entity.getUser().getUserName());
        return  commentDTO;
    }

    @Override
    public CommentEntity convertToEntity(CommentDTO dto) {
        CommentEntity commentEntity = new CommentEntity();
        commentEntity.setRating(dto.getRating());
        commentEntity.setReview(dto.getReview());
        return commentEntity;
    }
}
