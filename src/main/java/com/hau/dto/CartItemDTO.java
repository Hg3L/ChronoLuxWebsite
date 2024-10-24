package com.hau.dto;

public class CartItemDTO extends AbstractDTO<CartItemDTO>{
    private Integer quantity;
    private String customerName;
    private String productName;
    private double productPrice;
    private long productId;
    private long userId;
    private String productImgUrl;
    private double subtotal;
    private double total;
    private Double discount;
    private String username;

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public CartItemDTO() {
    }

    public CartItemDTO(Integer quantity, String productName, double productPrice, long productId, String productImgUrl,String username) {
        this.quantity = quantity;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productId = productId;
        this.productImgUrl = productImgUrl;
        this.username = username;
    }

    public CartItemDTO(String productName, String subtotal, String total, String quantity) {
        this.productName = productName;
        this.subtotal =Double.parseDouble(subtotal)  ;
        this.total =Double.parseDouble(total);
        this.quantity = Integer.parseInt(quantity);
    }

    public String getTotal() {
        return String.format("%.2f",total);
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getSubtotal() {
        return String.format("%.2f",subtotal) ;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public String getProductImgUrl() {
        return productImgUrl;
    }

    public void setProductImgUrl(String productImgUrl) {
        this.productImgUrl = productImgUrl;
    }

    public String getQuantity() {
        return this.quantity.toString();
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPrice() {
        return String.format("%.2f",productPrice);
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }
}
