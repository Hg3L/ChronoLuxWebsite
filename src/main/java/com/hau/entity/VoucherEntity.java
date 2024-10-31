package com.hau.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "voucher")
public class VoucherEntity extends BaseEntity {
    @Column(name = "code")
    private String code;
    @Column(name = "discount")
    private long discount;
    @Column(name = "begin_day")
    private Date beginDay;
    @Column(name = "end_day")
    private Date endDay;
    @OneToMany(mappedBy = "voucher")
    private List<BillEntity> bills = new ArrayList<>();
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

    public Date getBeginDay() {
        return beginDay;
    }

    public void setBeginDay(Date beginDay) {
        this.beginDay = beginDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }
}
