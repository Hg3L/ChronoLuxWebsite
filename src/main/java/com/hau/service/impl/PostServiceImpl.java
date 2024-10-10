package com.hau.service.impl;

import com.hau.converter.Converter;
import com.hau.dto.PostDTO;
import com.hau.entity.PostEntity;
import com.hau.repository.PostRepository;
import com.hau.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostServiceImpl implements PostService {
    private final PostRepository postRepository;
    private final Converter<PostDTO, PostEntity> converter;

    @Autowired
    public PostServiceImpl(PostRepository postRepository,
                           @Qualifier("postConverter") Converter<PostDTO, PostEntity> converter) {
        this.postRepository = postRepository;
        this.converter = converter;
    }

    @Override
    public List<PostDTO> getAllPosts() {
        List<PostEntity> postEntities = postRepository.findAll();

        return postEntities.stream()
                .map(converter::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public PostDTO getPostById(Long id) {
        return null;
    }

    @Override
    public void savePost(PostDTO postDTO) {

    }

    @Override
    public void deletePostById(Long id) {

    }
}
