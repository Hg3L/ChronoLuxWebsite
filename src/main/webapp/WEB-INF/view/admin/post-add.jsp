<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

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
<div class="container">
    <form:form method="post" action="${pageContext.request.contextPath}/admin/post/save" enctype="multipart/form-data" modelAttribute="post">
        <div class="d-flex justify-content-between align-items-center my-4">
            <h3>Thêm bài viết mới</h3>
            <div>
                <button type="submit" class="btn btn-primary mr-2">Lưu</button>
                <a href="${pageContext.request.contextPath}/admin/posts" class="btn btn-secondary">Hủy</a>
            </div>
        </div>
        <hr/>
        <!-- Trường nhập tiêu đề (Caption) -->
        <div class="form-group">
            <label for="caption">Tiêu đề</label>
            <form:input path="caption" type="text" class="form-control" id="caption" required=""/>
        </div>
        <!-- Trường nhập nội dung -->
        <div class="form-group">
            <label for="content">Nội dung</label>
            <form:textarea path="content" class="form-control" id="content" rows="5" required=""></form:textarea>
        </div>
        <!-- Trường upload ảnh -->
        <div class="form-group">
            <label for="img_file">Tải lên ảnh</label>
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="img_file" name="img_file" accept="image/*" required onchange="previewImage(event)">
                <label class="custom-file-label" for="img_file">Chọn ảnh</label>
            </div>
        </div>
        <!-- Phần xem trước ảnh -->
        <div class="form-group">
            <img id="imagePreview" src="" alt="Image Preview" class="img-fluid" style="max-width: 300px; display: none;" />
        </div>
    </form:form>
</div>


<script>
    function previewImage(event) {
        var input = event.target;
        var reader = new FileReader();
        reader.onload = function(){
            var dataURL = reader.result;
            var imagePreview = document.getElementById('imagePreview');
            imagePreview.src = dataURL;
            imagePreview.style.display = 'block'; // Show image after loading
        };
        reader.readAsDataURL(input.files[0]);
    }
</script>
</body>