<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>ChronoLux - Vouchers</title>
    <!-- Custom fonts for this template-->
    <link href="<c:url value='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <link href="<c:url value='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="<c:url value='/template/admin/js/script.js'/>"></script>
</head>
<body>
<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-start mb-3">
        <i class="h3 mb-1 mr-3 fa-solid fa-ticket" style="font-size: 28px"></i>
        <h1 class="h3 mb-1 text-gray-800">Mã giảm giá</h1>
    </div>
    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="nav-admin-tab" data-bs-toggle="tab" data-bs-target="#nav-admin" type="button" role="tab" aria-controls="nav-admin" aria-selected="true">Voucher khả dụng</button>
            <button class="nav-link" id="nav-user-tab" data-bs-toggle="tab" data-bs-target="#nav-user" type="button" role="tab" aria-controls="nav-user" aria-selected="false">Voucher hết hạn</button>
        </div>
    </nav>
    <div class="tab-content" id="nav-tabContent">
        <%--Admin--%>
        <div class="tab-pane fade show active" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab">
            <div class="mt-4">
                <div class="d-flex justify-content-end">
                    <a href="${pageContext.request.contextPath}/admin/voucher/create" class="btn btn-success mr-2 mt-1">
                        <i class="fas fa-plus mr-1"></i> Thêm voucher
                    </a>
                </div>
                <div class="card shadow mb-4 mt-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>Mã</th>
                                    <th>Giảm giá</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Ngày tạo</th>
                                    <th>Tạo bởi</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="v" items="${validVouchers.content}">
                                    <tr>
                                        <td>${v.code}</td>
                                        <td class="currency">${v.discount}</td>
                                        <td>${v.beginDay}</td>
                                        <td>${v.endDay}</td>
                                        <td>${v.createdDate}</td>
                                        <td>${v.createdBy}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                            <ul class="pagination">
                                <c:if test="${currentValidVoucherPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentValidVoucherPage - 1}&size=${validVouchers.size}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${validVouchers.totalPages}">
                                    <li class="page-item ${i == currentValidVoucherPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&size=${validVouchers.size}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentValidVoucherPage < validVouchers.totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentValidVoucherPage + 1}&size=${validVouchers.size}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <%--User--%>
        <div class="tab-pane fade" id="nav-user" role="tabpanel" aria-labelledby="nav-user-tab">
            <div class="card shadow mb-4 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Giảm giá</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Ngày tạo</th>
                                <th>Tạo bởi</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="v" items="${expiredVouchers.content}">
                                <tr>
                                    <td>${v.code}</td>
                                    <td>${v.discount}</td>
                                    <td>${v.beginDay}</td>
                                    <td>${v.endDay}</td>
                                    <td>${v.createdDate}</td>
                                    <td>${v.createdBy}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                        <ul class="pagination">
                            <c:if test="${currentExpiredVoucherPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentExpiredVoucherPage - 1}&size=${expiredVouchers.size}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${expiredVouchers.totalPages}">
                                <li class="page-item ${i == currentExpiredVoucherPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&size=${expiredVouchers.size}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentExpiredVoucherPage < expiredVouchers.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentExpiredVoucherPage + 1}&size=${expiredVouchers.size}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.querySelectorAll('.currency').forEach(element => {
        const value = parseFloat(element.innerText);
        element.innerText = formatToVND(value);
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>