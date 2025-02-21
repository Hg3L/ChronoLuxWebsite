package com.hau.Enum;

public enum DeliveryStatus {
    PENDING("Đang chờ xử lý"),
    CONFIRMED("Đã tiếp nhận"),
    SHIPPING("Đang giao hàng"),
    DELIVERED("Đã giao thành công"),
    CANCELLED("Đã hủy đơn hàng");

    private final String displayName;
    // Constructor
    DeliveryStatus(String displayName) {
        this.displayName = displayName;
    }


    // Getter để lấy tên hiển thị
    public String getDisplayName() {
        return displayName;
    }
}
