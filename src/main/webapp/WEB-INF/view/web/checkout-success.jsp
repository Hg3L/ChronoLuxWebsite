<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Checkout Successful</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="Free HTML Templates" name="keywords">
            <meta content="Free HTML Templates" name="description">

            <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">

            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js" rel="stylesheet">
             <!-- Thêm FontAwesome để hiện icon dấu tích -->
                <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
                <!-- Thêm Bootstrap JS (tùy chọn) -->
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <!-- Customized Bootstrap Stylesheet -->
            <link href=" <c:url value='/template/web/cssviewprofile/style.css'/>" rel="stylesheet">
            <link href=" <c:url value='/template/web/css/style.css'/>" rel="stylesheet">
            <style>
                    .success-icon {
                        font-size: 80px;
                        color: #28a745; /* Màu xanh lá cây */
                    }
                </style>
            <%----------------------------%>
        </head>

        <body>
<div class="container text-center my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <!-- Dấu tích lớn màu xanh lá cây -->
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <!-- Thông báo thanh toán thành công -->
                <h3 class="mt-3 text-success">Đặt hàng thành công!</h3>
                <p class="text-muted">Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được tiếp nhận để xử lý.</p>
                <a href="<c:url value='/home'/>" class="btn btn-primary mt-3">Quay lại trang chủ</a>
            </div>
        </div>
    </div>

        </body>

        </html>