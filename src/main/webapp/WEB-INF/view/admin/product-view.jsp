<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>ChronoLux - Product Information</title>
    <!-- Custom fonts for this template-->
    <link href="<c:url value='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <link href="<c:url value='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet" type="text/css">
    <link href="<c:url value='/template/admin/css/styles.css'/>" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-between mb-3">
        <h1 class="h3 mb-1 text-gray-800">Đồng hồ</h1>
    </div>
    <hr/>
    <div class="d-flex justify-content-end">
        <a href="${pageContext.request.contextPath}/admin/product/create" class="btn btn-success mr-2 mt-1">
            <i class="fas fa-plus mr-1"></i> Thêm đồng hồ
        </a>
    </div>
    <div class="card shadow mb-4 mt-4">
        <div class="card-body">
            <div class="d-flex justify-content-start mb-4 mt-3">
                <label class="mr-3">Thương hiệu:</label>
                <form class="form-group" action="${pageContext.request.contextPath}/admin/products" method="get">
                    <select class="custom-select-box" id="brandSelect" name="brandId" aria-label="Select brand">
                        <c:choose>
                            <c:when test="${empty brands}">
                                <option selected>Chưa có dữ liệu</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0" <c:if test="${brandId == 0}">selected</c:if>>Tất cả</option>
                                <c:forEach var="brand" items="${brands}">
                                    <option value="${brand.id}" <c:if test="${brand.id == brandId}">selected</c:if>>
                                            ${brand.name}
                                    </option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <label class="mr-3 ml-5">Dòng đồng hồ:</label>
                    <select class="custom-select-box" id="productLineSelect" name="productLineId" data-product-line-id="${productLineId}" aria-label="Select product line" required>
                    </select>
                    <button type="submit" class="btn btn-dark ml-3 d-inline-flex align-items-center">
                        <i class="fa fa-filter mr-1" aria-hidden="true"></i> Lọc
                    </button>
                    <input type="hidden" name="page" value="${currentPage}">
                    <input type="hidden" name="limit" value="6">
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>Ảnh sản phẩm</th>
                        <th>Tên đồng hồ</th>
                        <th>Tên thương hiệu</th>
                        <th>Dòng đồng hồ</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${productPage.content}">
                        <tr>
                            <td><img src="<c:url value='/template/web/img/products/${product.imgUrl}'/>" alt="Logo" style="max-width:80px;"/></td>
                            <td>${product.name}</td>
                            <td>${product.brandName}</td>
                            <td>${product.productLineName}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/product/update/?id=${product.id}" class="btn btn-info btn-sm mr-2">
                                    <i class="fas fa-pencil-alt mr-1"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.id}" class="btn btn-danger btn-sm" onclick="return confirmDelete(${productLine.id})">
                                    <i class="fas fa-trash-alt mr-1"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                <ul class="pagination">
                    <!-- Nút Previous -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}&size=${productPage.size}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                    </c:if>
                    <!-- Hiển thị các số trang -->
                    <c:forEach var="i" begin="1" end="${productPage.totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&size=${productPage.size}">${i}</a>
                        </li>
                    </c:forEach>
                    <!-- Nút Next -->
                    <c:if test="${currentPage < productPage.totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}&size=${productPage.size}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
<script>
    function confirmDelete(id) {
        return confirm("Bạn sẽ mất tất cả các sản phẩm của thương hiệu. Bạn có chắc muốn xóa thương hiệu này ?");
    }
</script>
<script>
    /*$(document).ready(function(){
        var productLineId = $('#productLineSelect').val();
        // Khi người dùng thay đổi lựa chọn brand
        $('#brandSelect').change(function(){
            var brandId = $(this).val();

            // Gửi yêu cầu AJAX để lấy danh sách product lines dựa trên brandId
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/product-line/getProductLines',  // URL xử lý yêu cầu
                type: 'GET',
                data: { brandId: brandId },
                success: function(response){
                    // Làm trống thẻ select productline trước khi cập nhật
                    $('#productLineSelect').empty();
                    // Kiểm tra nếu không có dữ liệu trả về
                    if (response.length === 0) {
                        $('#productLineSelect').append('<option value="" disabled>Chưa có dữ liệu</option>');
                    } else {
                        // Thêm product lines vào thẻ select nếu có dữ liệu
                        $('#productLineSelect').append('<option value="0">Tất cả</option>');  // Thêm lựa chọn "Tất cả"
                        $.each(response, function(key, value){
                            $('#productLineSelect').append('<option value="'+ value.id +'">'+ value.name +'</option>');
                        });
                    }
                    if (productLineId) {
                        $('#productLineSelect').val(productLineId);
                    }
                }
            });
        });
        $('#brandSelect').trigger('change');
    });*/

    $(document).ready(function() {
        // Khi người dùng thay đổi lựa chọn brand
        $('#brandSelect').change(function() {
            var brandId = $(this).val(); // Lấy giá trị của brand được chọn
            var productLineId = $('#productLineSelect').data('product-line-id'); // Lấy productLineId từ thuộc tính data

            // Gửi yêu cầu AJAX để lấy danh sách product lines dựa trên brandId
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/product-line/getProductLines',
                type: 'GET',
                data: { brandId: brandId },
                success: function(response) {
                    // Làm trống thẻ select productline trước khi cập nhật
                    $('#productLineSelect').empty();

                    if (response.length === 0) {
                        // Nếu không có dòng sản phẩm nào
                        $('#productLineSelect').append('<option value="" disabled selected>Chưa có dữ liệu</option>');
                        $('#productLineSelect').val('');
                    } else {
                        // Nếu brandId là "Tất cả" (giá trị 0)
                        if (brandId == 0) {
                            $('#productLineSelect').append('<option value="0">Tất cả</option>');
                        }

                        // Thêm product lines vào thẻ select nếu có dữ liệu
                        $.each(response, function(key, value) {
                            $('#productLineSelect').append('<option value="'+ value.id +'">'+ value.name +'</option>');
                        });
                    }

                    // Giữ lại lựa chọn trước đó nếu tồn tại
                    if (productLineId) {
                        $('#productLineSelect').val(productLineId); // Gán lại productLineId trước đó
                    }
                }
            });
        });

        // Trigger event change để tải danh sách product lines ban đầu
        $('#brandSelect').trigger('change');
    });


</script>
</body>