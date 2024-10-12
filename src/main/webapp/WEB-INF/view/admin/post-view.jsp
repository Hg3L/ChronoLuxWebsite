<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
            <html lang="vi">
<head>
    <title>ChronoLux - Post Management</title>
    <!-- Custom fonts for this template-->
    <link href="<c:url value='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <link href="<c:url value='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template-->
    <link href="" rel="stylesheet">
</head>
<body>
<!-- Begin Page Content -->
<div class="container-fluid">
    <!-- Add New Post Button -->
    <div class="d-flex justify-content-start mb-3">
        <a href="${pageContext.request.contextPath}/admin/post/create" class="btn btn-success btn-sm add-product">
            <i class="fas fa-plus"></i> Add New Post
        </a>
    </div>

    <!-- Loop through posts list -->
    <c:forEach var="a" items="${posts}">
        <div class="card mb-4 shadow-sm" style="border-radius: 15px; position: relative;">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <h5 class="card-title">${a.caption}</h5>
                    <div>
                        <!-- Edit button (pencil icon) -->
                        <a href="${pageContext.request.contextPath}/admin/post/update/?id=${a.id}" class="btn btn-primary btn-sm mr-2">
                            <i class="fas fa-pen"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/post/delete?id=${a.id}" class="btn btn-danger btn-sm" onclick="return confirmDelete(${a.id});">
                            <i class="fas fa-times"></i>
                        </a>
                    </div>
                </div>
                <!-- Content -->
                <p class="card-text">${a.content}</p>

                <!-- Image (Small size) -->
                <img src="<c:url value='/template/web/img/posts/${a.img}'/>" alt="Post Image" class="img-fluid"
                     style="border-radius: 10px; max-width: 150px; height: auto;" />
            </div>
        </div>
    </c:forEach>
</div>
<script>
    function confirmDelete(id) {
        return confirm("Are you sure you want to delete this post ?");
    }
</script>
</body>