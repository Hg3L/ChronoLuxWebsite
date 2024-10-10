package com.hau.converter;

import com.hau.dto.PostDTO;
import com.hau.entity.PostEntity;
import org.springframework.stereotype.Component;

@Component
public class PostConverter implements Converter<PostDTO, PostEntity> {
    @Override
    public PostDTO convertToDTO(PostEntity entity) {
        PostDTO postDTO = new PostDTO();
        postDTO.setId(entity.getId());
        postDTO.setImg(entity.getImg());
        postDTO.setCaption(entity.getCaption());
        postDTO.setContent(entity.getContent());
        return postDTO;
    }

    @Override
    public PostEntity convertToEntity(PostDTO dto) {
        return null;
    }
}
