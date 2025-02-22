<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>ChronoLux - Profile</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">


    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">



    <!-- Customized Bootstrap Stylesheet -->
    <link href=" <c:url value='/template/web/cssviewprofile/style.css'/>" rel="stylesheet">
    <link href=" <c:url value='/template/web/css/style.css'/>" rel="stylesheet">
    <%----------------------------%>
    <style>



        .order-container {
            width: 100%;
            margin: 20px auto;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: #fff;
        }

        .order-header {
            font-size: 18px;
            font-weight: bold;
            padding: 15px;
            background: #f8f9fa;
            border-bottom: 2px solid #ddd;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .order-table th {
            font-weight: bold;
        }

        .order-table td {
            color: #333;
        }

        .order-table tr:last-child td {
            border-bottom: none;
        }

    </style>
</head>

<body>
<div class="container rounded bg-white mt-5 mb-5">
    <form method="post" action="<c:url value='/user-profile'/>" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-2 border-right">

            </div>
            <div class="col-md-9 border-right">

                    <div class="order-container">
                        <div class="order-header">DANH SÁCH ĐƠN HÀNG MỚI NHẤT</div>

                        <c:choose>
                            <c:when test="${not empty bill}">
                                <table class="order-table">
                                    <thead>
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Thành tiền</th>
                                        <th>Trạng thái thanh toán</th>
                                        <th>Trạng thái vận chuyển</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${bill}" varStatus="status">
                                        <tr>
                                            <td>${item.id}</td>
                                            <td>${item.createdDate}</td>
                                            <td id="price">${item.total}đ</td>
                                            <td>${item.status}</td>
                                            <td>${item.orderStatus.displayName}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p style="padding: 15px; font-size: 16px; color: #888;">Bạn chưa có đơn hàng nào.</p>
                            </c:otherwise>
                        </c:choose>

                    </div>


            </div>
        </div>
    </form>
</div>
</div>
</div>
<script>
    document.querySelectorAll('#price').forEach(element => {
        let price = parseFloat(element.innerText.replace("đ", "").trim()); // Chuyển từ chuỗi sang số
        element.innerText = price.toLocaleString("vi-VN", { style: "currency", currency: "VND" }); // Format tiền tệ VNĐ
    });
</script>

<script>
    function displayImg(fileInput) {
        const file = fileInput.files[0];
        const imgPreview = $('#img_display');
        const imgChosen = $('#img_chosen');

        if(file){
            const reader = new FileReader();
            reader.onload = function (e){
                imgPreview.attr('src',e.target.result);
                imgPreview.css('display','block');
            }
            reader.readAsDataURL(file);
        }
        else{
            imgPreview.css('display','none');
        }

    }
</script>
</body>

</html>