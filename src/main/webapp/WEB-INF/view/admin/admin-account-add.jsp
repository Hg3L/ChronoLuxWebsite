<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<head>
    <title>ChronoLux - Account Information</title>
    <meta charset="UTF-8">
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
<div class="container rounded bg-white m-5">
    <div class="p-2">
        <form:form method="post" action="${pageContext.request.contextPath}/admin/account/save" enctype="multipart/form-data" modelAttribute="account" >
            <div class="d-flex justify-content-between align-items-center my-4">
                <h1 class="h3 mb-1 mt-2 text-gray-800">Tạo tài khoản Admin</h1>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-warning">
                        <i class="fa fa-reply mr-1" aria-hidden="true"></i>
                        Quay lại
                    </a>
                    <button type="submit" class="btn btn-success ml-2">
                        <i class="fa-solid fa-user-plus mr-1"></i>
                        Tạo tài khoản
                    </button>
                </div>
            </div>
            <hr/>
            <input type="hidden" name="page" value="${currentAdminPage}">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center" style="height: 300px; position: relative;">
                        <img id="imgPreview"
                             src="${pageContext.request.contextPath}/template/web/img/account-representation/admin.png"
                             alt="Img Preview"
                             class="rounded-circle mt-5"
                             style="max-width: 150px; height: auto; margin-bottom: 20px;" />
                        <div class="custom-file" style="position: absolute; bottom: 0;">
                            <input type="file" class="custom-file-input" id="img" name="img" accept="image/*"
                                   onchange="previewImage(event, 'imgPreview')" style="display:none;">
                            <button type="button" class="btn btn-primary" onclick="document.getElementById('img').click()">
                                <i class="fa-solid fa-upload mr-1"></i>
                                Tải ảnh đại diện
                            </button>
                        </div>
                    </div>
                </div>


                <!-- Cột nhập liệu -->
                <div class="col-md-9">
                    <div class="form-group">
                        <label for="userName">Tài khoản *</label>
                        <form:input path="userName" type="text" class="form-control" id="userName" required="required"/>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu *</label>
                        <form:input path="password" type="password" class="form-control" id="password" required="required" />
                    </div>
                    <div class="form-group">
                        <label for="fullName">Họ và tên *</label>
                        <form:input path="fullName" type="text" class="form-control" id="fullName" required="required" />
                    </div>
                    <label for="email">Email</label>
                    <form:input path="email" type="email" class="form-control" id="email"/>
                    <div id="email-error" class="invalid-feedback" style="display: none; color: red;">
                        Email không hợp lệ. Vui lòng điền email hợp lệ.
                    </div>
                    <div class="form-group">
                        <label class="text-danger mt-4">(*) Thông tin bắt buộc</label>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>

<!-- Img review-->
<script>
    function previewImage(event, previewId) {
        var input = event.target;
        var reader = new FileReader();

        reader.onload = function(){
            var dataURL = reader.result;
            var imagePreview = document.getElementById(previewId);
            imagePreview.src = dataURL;
            imagePreview.style.display = 'block'; // Hiển thị ảnh sau khi tải
        };

        reader.readAsDataURL(input.files[0]);
    }
</script>
<script>
    document.getElementById("email").addEventListener("input", function() {
        var emailInput = document.getElementById("email");
        var emailError = document.getElementById("email-error");

        // Biểu thức chính quy kiểm tra email hợp lệ (RFC 5321/5322)
        var emailPattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (emailPattern.test(emailInput.value)) {
            emailInput.classList.remove("is-invalid");
            emailError.style.display = "none";
        } else {
            emailInput.classList.add("is-invalid");
            emailError.style.display = "block";
        }
    });
</script>
</body>