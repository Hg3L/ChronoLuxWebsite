package com.hau.dto;

public class VoucherDTO extends AbstractDTO<VoucherDTO>{
    private String code;
    private long discount;
    private String beginDay;
    private String endDay;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public long getDiscount() {
        return discount;
    }

    public void setDiscount(long discount) {
        this.discount = discount;
    }

    public String getBeginDay() {
        return beginDay;
    }

    public void setBeginDay(String beginDay) {
        this.beginDay = beginDay;
    }

    public String getEndDay() {
        return endDay;
    }

    public void setEndDay(String endDay) {
        this.endDay = endDay;
    }
}
