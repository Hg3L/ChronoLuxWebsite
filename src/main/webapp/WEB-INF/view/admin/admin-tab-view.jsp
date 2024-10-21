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
    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="nav-admin-tab" data-bs-toggle="tab" data-bs-target="#nav-admin" type="button" role="tab" aria-controls="nav-admin" aria-selected="true">Tài khoản Admin</button>
            <button class="nav-link" id="nav-user-tab" data-bs-toggle="tab" data-bs-target="#nav-user" type="button" role="tab" aria-controls="nav-user" aria-selected="false">Tài khoản Người dùng</button>
        </div>
    </nav>
    <div class="tab-content" id="nav-tabContent">
        <%--Admin--%>
        <div class="tab-pane fade show active" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab">
            <hr/>
            <div class="d-flex justify-content-end">
                <a href="${pageContext.request.contextPath}/admin/account-admin/create" class="btn btn-success mr-2 mt-1">
                    <i class="fas fa-plus mr-1"></i> Tạo tài khoản Admin
                </a>
            </div>
            <div class="card shadow mb-4 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                            <tr>
                                <th>Ảnh đại diện</th>
                                <th>Tên tài khoản</th>
                                <th>Tên người dùng</th>
                                <th>Ngày tạo</th>
                                <th>Email</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="account" items="${adminAccountPage.content}">
                                <tr>
                                    <td>
                                        <img src="<c:url value="/template/web/img/avatars/${account.imgUrl}"/>" alt="Logo" style="max-width:50px; border-radius: 50%;"/>
                                    </td>
                                    <td>${account.userName}</td>
                                    <td>${account.fullName}</td>
                                    <td>${account.createdDate}</td>
                                    <td>${account.email}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                        <ul class="pagination">
                            <c:if test="${currentAdminPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentAdminPage - 1}&size=${adminAccountPage.size}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${adminAccountPage.totalPages}">
                                <li class="page-item ${i == currentAdminPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&size=${adminAccountPage.size}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentAdminPage < adminAccountPage.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentAdminPage + 1}&size=${adminAccountPage.size}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <%--User--%>
        <div class="tab-pane fade" id="nav-user" role="tabpanel" aria-labelledby="nav-user-tab">
            <hr/>
            <div class="card shadow mb-4 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                            <tr>
                                <th>Ảnh đại diện</th>
                                <th>Tên tài khoản</th>
                                <th>Tên người dùng</th>
                                <th>Ngày tạo</th>
                                <th>Email</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="account" items="${userAccountPage.content}">
                                <tr>
                                    <td>
                                        <img src="<c:url value="/template/web/img/avatars/${account.imgUrl}"/>" alt="Logo" style="max-width:50px; border-radius: 50%;"/>
                                    </td>
                                    <td>${account.userName}</td>
                                    <td>${account.fullName}</td>
                                    <td>${account.createdDate}</td>
                                    <td>${account.email}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/account/view/?id=${account.id}" class="btn btn-info btn-sm mr-2">
                                            <i class="fas fa-eye mr-1"></i> Xem hoạt động
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/account/lock?id=${account.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn khóa tài khoản này?');">
                                            <i class="fas fa-lock mr-1"></i> Khóa tài khoản
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                        <ul class="pagination">
                            <c:if test="${currentUserPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentUserPage - 1}&size=${userAccountPage.size}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${userAccountPage.totalPages}">
                                <li class="page-item ${i == currentUserPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&size=${userAccountPage.size}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentUserPage < userAccountPage.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentUserPage + 1}&size=${userAccountPage.size}" aria-label="Next">
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
    function confirmDelete(id) {
        return confirm("Bạn có chắc muốn xóa thương hiệu này?");
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
