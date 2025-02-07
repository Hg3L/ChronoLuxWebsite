package com.hau.service.impl;

import com.hau.constant.SystemConstant;
import com.hau.converter.CommentConverter;
import com.hau.converter.Converter;
import com.hau.dto.CommentDTO;
import com.hau.dto.UserDTO;
import com.hau.entity.CommentEntity;
import com.hau.entity.UserEntity;
import com.hau.repository.CommentRepository;
import com.hau.repository.ProductRepository;
import com.hau.repository.UserRepository;
import com.hau.service.CommentService;
import com.hau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentRepository  commentRepository;
    @Autowired
    private Converter<CommentDTO, CommentEntity> commentConverter;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ProductRepository productRepository;

    @Override
    public void save(CommentDTO commentDTO) {
        CommentEntity commentEntity = commentConverter.convertToEntity(commentDTO);
       String userName = SecurityContextHolder.getContext().getAuthentication().getName();
       UserEntity user =  userRepository.findOneByUserNameAndStatus(userName, SystemConstant.ACTIVE_STATUS);
        commentEntity.setUser(user);

       commentEntity.setProduct(productRepository.findByIdAndActive(commentDTO.getProductId(),true));
       commentRepository.save(commentEntity);// qua controller xu ly them phan id product o view
    }

    @Override
    public List<CommentDTO> findByProductId(Long id) {
        return commentRepository.findByProductId(id)
                .orElseThrow(() ->new RuntimeException("Không tìm thấy bình luận nào về sản phẩm"))
                .stream()
                .map(commentEntity -> commentConverter.convertToDTO(commentEntity)
         ).toList();
    }

    @Override
    public CommentDTO findById(Long id) {
        CommentEntity commentEntity = commentRepository.findById(id).orElseThrow(() ->  new RuntimeException("không tìm thấy bình luận nào"));
        return commentConverter.convertToDTO(commentEntity);
    }
}
