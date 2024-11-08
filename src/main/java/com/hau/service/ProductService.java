package com.hau.service;

import com.hau.dto.ProductDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.TreeSet;


public interface ProductService {
    public List<ProductDTO> findTop8ByOrderByIdDesc();
    LinkedHashSet<ProductDTO> findTop8BestSelling();
    List<ProductDTO> findAll();
    public List<ProductDTO> findAll(Pageable pageable,String keyword,String filter);
    public long getTotalItem(String keyword,String filter);
    public List<ProductDTO> findAllByIdBrand(Pageable pageable,Long id,String keyword,String filter);
    public long getTotalItemByIdBrand(Long id,String keyword,String filter);
    public long getTotalItemByIdProductLine(Long id,String keyword,String filter);
    public List<ProductDTO> findAllByIdProductLine(Pageable pageable,Long id,String keyword,String filter);
    public ProductDTO findOneById(long id);
    Page<ProductDTO> findByProductLine_Id(Long id, int page, int limit);
    Page<ProductDTO> findByBrand_Id(Long id, int page, int limit);
    Page<ProductDTO> findAll(int page, int limit);
    void save(ProductDTO productDTO);
    void delete(long id);
    List<ProductDTO> findAllByIdBrandNotPage(Long id);
    // admin

}
