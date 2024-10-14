package com.hau.dto;

public class ProductLineDTO extends AbstractDTO<ProductLineDTO>{
    private String name;
    private long brandId;
    private long warrantyId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getBrandId() {
        return brandId;
    }

    public void setBrandId(long brandId) {
        this.brandId = brandId;
    }

    public long getWarrantyId() {
        return warrantyId;
    }

    public void setWarrantyId(long warrantyId) {
        this.warrantyId = warrantyId;
    }
}
