package com.hau.entity;

import javax.persistence.*;

@Entity
@Table(name = "product")
public class ProductEntity extends BaseEntity {
    @Column(name = "water_resistant")
    private double waterResistant;
    @Column(name = "watch_type")
    private String watchType;
    @Column(name = "glass_material")
    private String glassMaterial;
    @Column(name = "strap_material")
    private String strapMaterial;
    @Column(name = "face_size")
    private String faceSize;
    @Column(name = "thickness")
    private double thickness;
    @Column(name = "img_url")
    private String imgUrl;
    @Column(name = "gender")
    private String gender;
    @Column(name = "price")
    private long price;

    @ManyToOne (fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "product_line_id")
    private ProductLineEntity productLine;

    public double getWaterResistant() {
        return waterResistant;
    }

    public void setWaterResistant(double waterResistant) {
        this.waterResistant = waterResistant;
    }

    public String getWatchType() {
        return watchType;
    }

    public void setWatchType(String watchType) {
        this.watchType = watchType;
    }

    public String getGlassMaterial() {
        return glassMaterial;
    }

    public void setGlassMaterial(String glassMaterial) {
        this.glassMaterial = glassMaterial;
    }

    public String getStrapMaterial() {
        return strapMaterial;
    }

    public void setStrapMaterial(String strapMaterial) {
        this.strapMaterial = strapMaterial;
    }

    public String getFaceSize() {
        return faceSize;
    }

    public void setFaceSize(String faceSize) {
        this.faceSize = faceSize;
    }

    public double getThickness() {
        return thickness;
    }

    public void setThickness(double thickness) {
        this.thickness = thickness;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public ProductLineEntity getProductLine() {
        return productLine;
    }

    public void setProductLine(ProductLineEntity productLine) {
        this.productLine = productLine;
    }
}
