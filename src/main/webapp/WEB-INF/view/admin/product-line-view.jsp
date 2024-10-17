<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>ChronoLux - Product Line Information</title>
    <!-- Custom fonts for this template-->
    <link href="<c:url value='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <link href="<c:url value='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet" type="text/css">
    <link href="<c:url value='/template/admin/css/styles.css'/>" rel="stylesheet" type="text/css">
</head>
<body>
<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-between mb-3">
        <h1 class="h3 mb-1 text-gray-800">Các dòng đồng hồ</h1>
    </div>
    <hr/>
    <div class="d-flex justify-content-end">
        <a href="${pageContext.request.contextPath}/admin/product-line/create" class="btn btn-success mr-2 mt-1">
            <i class="fas fa-plus mr-1"></i> Thêm dòng đồng hồ
        </a>
    </div>
    <div class="card shadow mb-4 mt-4">
        <div class="card-body">
            <div class="d-flex justify-content-start mb-4 mt-3">
                <label class="mr-3">Thương hiệu:</label>
                <form class="form-group" action="${pageContext.request.contextPath}/admin/product-lines" method="get">
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
                        <th>Tên thương hiệu</th>
                        <th>Dòng đồng hồ</th>
                        <th>Logo</th>
                        <th>Banner</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="productLine" items="${productLines.content}">
                        <tr>
                            <td>${productLine.brandName}</td>
                            <td>${productLine.name}</td>
                            <td><img src="<c:url value='/template/web/img/product-lines/${productLine.iconUrl}'/>" alt="Logo" style="max-width:80px;"/></td>
                            <td><img src="<c:url value='/template/web/img/product-lines/${productLine.bannerUrl}'/>" alt="Banner" style="max-width:250px;"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/product-line/update/?id=${productLine.id}" class="btn btn-info btn-sm mr-2">
                                    <i class="fas fa-pencil-alt mr-1"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product-line/delete?id=${productLine.id}" class="btn btn-danger btn-sm" onclick="return confirmDelete(${productLine.id})">
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
                            <a class="page-link" href="?page=${currentPage - 1}&size=${brandPage.size}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                    </c:if>
                    <!-- Hiển thị các số trang -->
                    <c:forEach var="i" begin="1" end="${brandPage.totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&size=${brandPage.size}">${i}</a>
                        </li>
                    </c:forEach>
                    <!-- Nút Next -->
                    <c:if test="${currentPage < brandPage.totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}&size=${brandPage.size}" aria-label="Next">
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

<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        var currentPage = 1;
        var limit = 6;

        function loadProductLines(brandId, page) {
            $.ajax({
                url: "/admin/product-lines/by-brand",
                type: "GET",
                data: { brandId: brandId, page: page, limit: limit },
                success: function(response) {
                    var tableBody = $("#productLineTableBody");
                    tableBody.empty();

                    if (response.content.length === 0) {
                        tableBody.append("<tr><td colspan='5'>Không có dữ liệu</td></tr>");
                    } else {
                        response.content.forEach(function(productLine) {
                            var row = "<tr>" +
                                "<td>" + productLine.brandName + "</td>" +
                                "<td>" + productLine.name + "</td>" +
                                "<td><img src='/template/web/img/product-line/" + productLine.iconUrl + "' alt='Logo' style='max-width:80px;' /></td>" +
                                "<td><img src='/template/web/img/product-line/" + productLine.bannerUrl + "' alt='Banner' style='max-width:250px;' /></td>" +
                                "<td>" +
                                "<a href='/admin/product-line/update/?id=" + productLine.id + "' class='btn btn-info btn-sm mr-2'>" +
                                "<i class='fas fa-pencil-alt mr-1'></i> Sửa" +
                                "</a>" +
                                "<a href='/admin/product-line/delete?id=" + productLine.id + "' class='btn btn-danger btn-sm'>" +
                                "<i class='fas fa-trash-alt mr-1'></i> Xóa" +
                                "</a>" +
                                "</td>" +
                                "</tr>";
                            tableBody.append(row);
                        });

                        // Cập nhật phân trang
                        var pagination = $(".pagination");
                        pagination.empty();

                        if (response.totalPages > 1) {
                            // Nút Previous
                            if (page > 1) {
                                pagination.append(
                                    "<li class='page-item'>" +
                                    "<a class='page-link' href='#' onclick='loadProductLines(" + brandId + ", " + (page - 1) + ")'>&laquo;</a>" +
                                    "</li>"
                                );
                            }
                            // Các số trang
                            for (var i = 1; i <= response.totalPages; i++) {
                                pagination.append(
                                    "<li class='page-item " + (i === page ? "active" : "") + "'>" +
                                    "<a class='page-link' href='#' onclick='loadProductLines(" + brandId + ", " + i + ")'>" + i + "</a>" +
                                    "</li>"
                                );
                            }
                            // Nút Next
                            if (page < response.totalPages) {
                                pagination.append(
                                    "<li class='page-item'>" +
                                    "<a class='page-link' href='#' onclick='loadProductLines(" + brandId + ", " + (page + 1) + ")'>&raquo;</a>" +
                                    "</li>"
                                );
                            }
                        }
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Error details:", textStatus, errorThrown);
                    console.error("Response text:", jqXHR.responseText);
                    alert("Đã xảy ra lỗi khi lấy dữ liệu.");
                }
            });
        }

        $("#brandSelect").change(function() {
            var brandId = $(this).val();
            currentPage = 1;
            loadProductLines(brandId, currentPage);
        });
        loadProductLines(0, currentPage);  // 0 là lấy tất cả product lines
    });
</script>--%>
</body>