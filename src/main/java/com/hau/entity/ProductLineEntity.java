package com.hau.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "product_line")
public class ProductLineEntity extends BaseEntity{
    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "brand_id")
    private BrandEntity brand;

    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JoinColumn(name="warranty_id")
    private WarrantyEntity warranty;

    @OneToMany(mappedBy = "productLine")
    private List<ProductEntity> products;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BrandEntity getBrand() {
        return brand;
    }

    public void setBrand(BrandEntity brand) {
        this.brand = brand;
    }

    public WarrantyEntity getWarranty() {
        return warranty;
    }

    public void setWarranty(WarrantyEntity warranty) {
        this.warranty = warranty;
    }

    public List<ProductEntity> getProducts() {
        return products;
    }

    public void setProducts(List<ProductEntity> products) {
        this.products = products;
    }
}
