package com.hau.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "brand")
public class BrandEntity extends BaseEntity{
    @Column(name = "name")
    private String name;
    @Column(name ="country")
    private String country;
    @Column(name = "banner_url")
    private String bannerUrl;
    @Column(name ="icon_url")
    private String iconUrl;
    @OneToMany(mappedBy = "brand")
    private List<ProductLineEntity> productLines = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getBannerUrl() {
        return bannerUrl;
    }

    public void setBannerUrl(String bannerUrl) {
        this.bannerUrl = bannerUrl;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }
}