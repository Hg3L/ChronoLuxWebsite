package com.hau.repository;

import com.hau.entity.BrandEntity;
import com.hau.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.TreeSet;

public interface ProductRepository extends JpaRepository<ProductEntity,Long> {
    List<ProductEntity> findTop8ByActiveOrderByIdDesc(Boolean active);
    @Query(value = "SELECT p FROM ProductEntity p " +
            "JOIN p.cartItems ci " +
            "WHERE p.active = true " +
            "GROUP BY p.id " +
            "ORDER BY SUM(ci.quantity) DESC")
    LinkedHashSet<ProductEntity> findTop8BestSellingProducts();
    ProductEntity findByIdAndActive(long id,boolean active);
    List<ProductEntity> findAllByActive(boolean active);

    ProductEntity findOneByNameAndActive(String name,Integer active);

    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE " +
            "(:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND p.active = true")
    long count(@Param("gender") String gender,
               @Param("keyword") String keyword,
               @Param("minPrice") Long minPrice,
               @Param("maxPrice") Long maxPrice);

    @Query("SELECT COUNT(p) FROM ProductEntity p " +
            "INNER JOIN p.productLine pl " +
            "WHERE pl.brand.id = :brandId " +
            "AND (:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)" +
            "AND p.active = true")
    long countByIdBrand(@Param("brandId") Long brandId,
                        @Param("gender") String gender,
                        @Param("keyword") String keyword,
                        @Param("minPrice") Long minPrice,
                        @Param("maxPrice") Long maxPrice);


    @Query("SELECT p FROM ProductEntity p WHERE " +
            "(:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND p.active = true")
    Page<ProductEntity> findAll(@Param("gender") String gender,
                                @Param("keyword") String keyword,
                                @Param("minPrice") Long minPrice,
                                @Param("maxPrice") Long maxPrice,
                                Pageable pageable);



    @Query("SELECT p FROM ProductEntity p " +
            "INNER JOIN p.productLine pl " +
            "WHERE pl.brand.id = :brandId " +
            "AND (:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)" +
            "AND p.active = true"

    )
    Page<ProductEntity> findAllByIdBrand(@Param("brandId") Long brandId,
                                         @Param("gender") String gender,
                                         @Param("keyword") String keyword,
                                         @Param("minPrice") Long minPrice,
                                         @Param("maxPrice") Long maxPrice,
                                         Pageable pageable);
    
    @Query("SELECT p FROM ProductEntity p " +
            "INNER JOIN p.productLine pl " +
            "WHERE pl.brand.id = :brandId " +
            "AND p.active = true"
    )
    List<ProductEntity> findAllByIdBrandNotPage(@Param("brandId") Long brandId);

    @Query("SELECT COUNT(p) FROM ProductEntity p " +
            "WHERE p.productLine.id = :productLineId " +
            "AND (:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)" +
            "AND p.active = true"
    )
    long countByIdProductLine(@Param("productLineId") Long productLineId,
                        @Param("gender") String gender,
                        @Param("keyword") String keyword,
                        @Param("minPrice") Long minPrice,
                        @Param("maxPrice") Long maxPrice);

    @Query("SELECT p FROM ProductEntity p " +
            "WHERE p.productLine.id = :productLineId " +
            "AND (:gender IS NULL OR p.gender LIKE :gender) " +
            "AND (:keyword IS NULL OR CONCAT(p.name, ' ', p.price) LIKE :keyword) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)" +
            "AND p.active = true"
    )
    Page<ProductEntity> findAllByIdProductLine(@Param("productLineId") Long productLineId,
                                         @Param("gender") String gender,
                                         @Param("keyword") String keyword,
                                         @Param("minPrice") Long minPrice,
                                         @Param("maxPrice") Long maxPrice,
                                         Pageable pageable);

    Page<ProductEntity> findAllByProductLine_IdAndActive(Long productLineId, boolean active, Pageable pageable);

    @Query("SELECT p FROM ProductEntity p WHERE p.productLine.brand.id = :brandId AND p.active = :active")
    Page<ProductEntity> findAllByBrandIdAndActive(Long brandId, boolean active, Pageable pageable);

    Page<ProductEntity> findAllByActive(boolean active, Pageable pageable);
}
