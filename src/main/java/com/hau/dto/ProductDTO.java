package com.hau.dto;

import javax.persistence.Column;

public class ProductDTO extends AbstractDTO{

    private double waterResistant;

    private String watchType;

    private String glassMaterial;

    private String strapMaterial;

    private String faceSize;

    private double thickness;

    private String imgUrl;

    private String gender;

    private long price;
    private String productLineName;
    private String name;


    public String getProductLineName() {
        return productLineName;
    }

    public void setProductLineName(String productLineName) {
        this.productLineName = productLineName;
    }

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

    public double getThickness() {
        return thickness;
    }

    public void setThickness(double thickness) {
        this.thickness = thickness;
    }

    public String getFaceSize() {
        return faceSize;
    }

    public void setFaceSize(String faceSize) {
        this.faceSize = faceSize;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
