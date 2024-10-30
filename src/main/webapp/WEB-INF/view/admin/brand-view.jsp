<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>ChronoLux - Brands Information</title>
    <!-- Custom fonts for this template-->
    <link href="<c:url value='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <link href="<c:url value='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
    <!-- Begin Page Content -->
    <div class="container-fluid">
        <div class="d-sm-flex align-items-center justify-content-start mb-3">
            <i class="h3 mb-1 mr-2 fas fa-star" style="font-size: 28px"></i>
            <h1 class="h3 mb-1 text-gray-800">Thương hiệu đồng hồ</h1>
        </div>
        <hr/>
        <div class="d-flex justify-content-end">
            <a href="${pageContext.request.contextPath}/admin/brand/create" class="btn btn-success mr-2 mt-1">
                <i class="fas fa-plus mr-1"></i> Thêm thương hiệu
            </a>
        </div>

        <div class="card shadow mb-4 mt-4">
            <%--<div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
            </div>--%>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                            <tr>
                                <th>Tên thương hiệu</th>
                                <th>Quốc gia</th>
                                <th>Logo</th>
                                <th>Banner</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="brand" items="${brandPage.content}">
                                <tr>
                                    <td>${brand.name}</td>
                                    <td>${brand.country}</td>
                                    <td><img src="<c:url value="/template/web/img/brands/${brand.iconUrl}"/>" alt="Logo" style="max-width:80px;" /></td>
                                    <td><img src="<c:url value="/template/web/img/brands/${brand.bannerUrl}"/>" alt="Banner" style="max-width:250px;" /></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/brand/update/?id=${brand.id}" class="btn btn-info btn-sm mr-2">
                                            <i class="fas fa-pencil-alt mr-1"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/brand/delete?id=${brand.id}" class="btn btn-danger btn-sm" onclick="return confirmDelete(${brand.id});">
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
</body>