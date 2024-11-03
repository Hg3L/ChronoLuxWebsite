<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>ChronoLux - Bill</title>
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
        <i class="h3 mb-1 mr-3 fa-solid fa-receipt" style="font-size: 28px"></i>
        <h1 class="h3 mb-1 text-gray-800">Tình trạng đơn hàng</h1>
    </div>
    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="nav-admin-tab" data-bs-toggle="tab" data-bs-target="#nav-admin" type="button" role="tab" aria-controls="nav-admin" aria-selected="true">Chưa thanh toán</button>
            <button class="nav-link" id="nav-user-tab" data-bs-toggle="tab" data-bs-target="#nav-user" type="button" role="tab" aria-controls="nav-user" aria-selected="false">Đã thanh toán</button>
        </div>
    </nav>
    <div class="tab-content" id="nav-tabContent">
        <%--<input type="hidden" name="unpaidPage" value="${currentUnpaidPage}">--%>
        <%--Admin--%>
        <div class="tab-pane fade show active" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab">
            <div class="mt-4">
                <div class="card shadow mb-4 mt-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle" width="100%" cellspacing="0">
                                <thead class="table-secondary">
                                <tr>
                                    <th>Thời gian đặt</th>
                                    <th>Tên khách hàng</th>
                                    <th>Số điện thoại</th>
                                    <th>Hình thức thanh toán</th>
                                    <th>Tổng đơn hàng</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="ub" items="${unpaidBillsPage.content}">
                                    <tr>
                                        <td>${ub.createdDate}</td>
                                        <td>${ub.displayName}</td>
                                        <td>${ub.phone}</td>
                                        <td>${ub.paymentMethod}</td>
                                        <td class="currency">${ub.total}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/bill/view/?id=${ub.id}" class="btn btn-secondary btn-sm mr-2">
                                                <i class="fa-solid fa-eye mr-1"></i>
                                                Xem
                                            </a>
                                            <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#confirmModal${ub.id}">
                                                <i class="fa-solid fa-check mr-1"></i>
                                                Xác nhận thanh toán
                                            </button>
                                        </td>
                                    </tr>

                                    <!-- Modal -->
                                    <div class="modal fade" id="confirmModal${ub.id}" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel${ub.id}" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="confirmModalLabel${ub.id}">Xác nhận thanh toán</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    Xác nhận đơn hàng của <strong>${ub.displayName}</strong> đã thanh toán?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                        <i class="fa-solid fa-reply mr-1"></i>
                                                        Trở lại
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/admin/bill/update/?id=${ub.id}" class="btn btn-warning">
                                                        <i class="fa-solid fa-check mr-1"></i>
                                                        Xác nhận
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <%--<nav aria-label="Page navigation example" class="d-flex justify-content-center">
                            <ul class="pagination">
                                <c:if test="${currentUnpaidPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentUnpaidPage - 1}&size=${unpaidBillsPage.size}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${unpaidBillsPage.totalPages}">
                                    <li class="page-item ${i == currentUnpaidPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&size=${unpaidBillsPage.size}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentUnpaidPage < unpaidBillsPage.totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentUnpaidPage + 1}&size=${unpaidBillsPage.size}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>--%>
                    </div>
                </div>
            </div>
        </div>

        <%--User--%>
        <div class="tab-pane fade" id="nav-user" role="tabpanel" aria-labelledby="nav-user-tab">
            <div class="card shadow mb-4 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered text-center align-middle" width="100%" cellspacing="0">
                            <thead class="table-secondary">
                            <tr>
                                <th>Thời gian đặt</th>
                                <th>Thời gian duyệt đơn</th>
                                <th>Tên khách hàng</th>
                                <th>Số điện thoại</th>
                                <th>Hình thức thanh toán</th>
                                <th>Tổng đơn hàng</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="ub" items="${paidBillsPage.content}">
                                <tr>
                                    <td>${ub.createdDate}</td>
                                    <td>${ub.modifiedDate}</td>
                                    <td>${ub.displayName}</td>
                                    <td>${ub.phone}</td>
                                    <td>${ub.paymentMethod}</td>
                                    <td class="currency">${ub.total}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/bill/view/?id=${ub.id}" class="btn btn-secondary btn-sm mr-2">
                                            <i class="fa-solid fa-eye mr-1"></i>
                                            Xem
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <%--<nav aria-label="Page navigation example" class="d-flex justify-content-center">
                        <ul class="pagination">
                            <c:if test="${currentPaidPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPaidPage - 1}&size=${paidBillsPage.size}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${paidBillsPage.totalPages}">
                                <li class="page-item ${i == currentPaidPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&size=${paidBillsPage.size}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPaidPage < paidBillsPage.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPaidPage + 1}&size=${paidBillsPage.size}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>--%>
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
<div aria-live="polite" aria-atomic="true" style="position: fixed; bottom: 1rem; right: 1rem; z-index: 1050;">
    <div class="toast" id="successToast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="3500">
        <div class="toast-header bg-success text-white">
            <strong class="mr-auto custom-font-20">Thông báo</strong>
            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="toast-body">
            <span id="toastMessage" class="custom-font-20">Thêm thành công</span>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const successMessage = "${successMessage}";
        if (successMessage) {
            const toastElement = document.getElementById("successToast");
            const toast = new bootstrap.Toast(toastElement);
            document.getElementById("toastMessage").innerText = successMessage;
            toast.show();
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
