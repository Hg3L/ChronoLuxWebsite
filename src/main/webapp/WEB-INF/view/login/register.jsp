<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/common/taglib.jsp" %>
<c:url var="loginURL" value="/login"/>
<c:url var="registerURL" value="/login/register"/>
<c:url var="APIurl" value="/api/user"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ChronoLux - Create an Account</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- Bootstrap CSS -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"> <!-- Font Awesome CSS -->
	<style>
		body {
			background-color: #2e2f37;
			background-size: cover;
			background-position: center;
			background-repeat: no-repeat;
		}
		.overlay {
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(12, 10, 10, 0.93); /* Semi-transparent overlay */
			z-index: 1;
		}

		h2 {
			color: #333;
			font-weight: 700;
			letter-spacing: 1px;
			font-family: Corbel;
		}

		.form-control {
			margin-bottom: 15px; /* Spacing between inputs */
		}

		.btn-primary {
			width: 100%; /* Full width button */
		}

		.text-muted {
			color: black !important; /* Change color of text-muted to white */
		}

		.alert {
			display: none; /* Hide alert initially */
		}
	</style>
</head>

<body>

<!-- Navbar -->
<header class="header">
	<nav class="navbar navbar-expand-lg navbar-light py-3">
		<div class="container">
			<a href="<c:url value='/home'/>" class="navbar-brand">
				<img src="${pageContext.request.contextPath}/template/web/img/Logo.svg" alt="ChronoLux Logo">
			</a>
		</div>
	</nav>
</header>

<div class="row justify-content-center mx-0 py-5"style="background-image: url('${pageContext.request.contextPath}/template/login/img/bg-6.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat; min-height: 400px;">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"> <!-- Font Awesome CSS -->
	<div class="login-container p-4 rounded-5 bg-white shadow col-12 col-sm-8 col-md-6 col-lg-5 mx-auto" style="border-radius: 1rem;">
		<div class="row flex-nowrap ">
			<!-- Left Column -->
			<div class="col-md-5 mx-3 d-flex flex-column justify-content-center align-items-center text-center border-end ">
				<img class="mx-5" src="${pageContext.request.contextPath}/template/login/img/promo-1.png" alt="ChronoLux Logo">
				<h2 class="mt-5">Tạo Tài Khoản ChronoLux</h2>
				<p class="font-italic " style="color: #cd9a2a;">Trở thành ChronoMember <br> để nhận được nhiều ưu đãi hấp dẫn</p>
				<img class="mt-5" src="${pageContext.request.contextPath}/template/web/img/Logo.svg" alt="ChronoLux Logo">
			</div>

			<!-- Vertical Divider -->
			<div class="d-none d-md-block" style="width: 1px; background-color: #cd9a2a;"></div>

			<!-- Registration Form -->
			<div class="col-md-7 col-lg-6 ml-3">
				<form:form method="post" id="formSubmit" action="${pageContext.request.contextPath}/login/add" enctype="multipart/form-data">
					<div class="row mx-5 rounded-5 d-flex justify-content-center align-items-center flex-column left-box">
						<input class="text mb-0 mt-2" type="text" name="userName" id="userName" placeholder="Tên Tài Khoản" required minlength="6" maxlength="20">
						<span id="usernameFeedback" style="color: red; display: none;"></span>
						<input class="text email mt-3 mb-3" type="email" name="email" placeholder="Email" required="">
						<input class="text mt-0 mb-3" type="text" name="fullName" placeholder="Họ Và Tên" required="">
						<input class="text mb-0" type="password" name="password" id="password" placeholder="Mật Khẩu" required minlength="6">
						<input class="text w3lpass mt-3 mb-3" type="password" name="ConfirmPassword" id="ConfirmPassword" placeholder="Xác Nhân Mật Khẩu" oninput="checkPasswordMatch(this);" required="">
						<label class="mt-2">Avatar:</label>
						<input class="text mb-3" type="file" name="img" id="img" accept="image/*" onchange="previewImage(event)">
						<img id="imgPreview" alt="Avt Preview" class="mb-3" style="display: none; max-width: 100px; max-height: 100px;" />
						<script>
							function previewImage(event) {
								const imgPreview = document.getElementById('imgPreview');
								const file = event.target.files[0];

								if (file) {
									const reader = new FileReader();

									reader.onload = function(e) {
										imgPreview.src = e.target.result;
										imgPreview.style.display = 'block'; // Show the image preview
									};

									reader.readAsDataURL(file);
								} else {
									imgPreview.style.display = 'none'; // Hide the image preview if no file is selected
								}
							}
						</script>
						<div class="g-recaptcha mb-0" data-sitekey="6LcvolUqAAAAAHsPdMaMhrNDeg_HE-FuNR4XO95n"></div>
						<div id="error" class="mb-3"></div>
						<button type="submit" class="btn btn-success mb-3 w-75">Đăng Ký</button>
						<div class="row mx-5 mb-2 rounded-5 d-flex justify-content-center align-items-center flex-column left-box">
							<p class="text-center">Đã là ChronoMember?</p>
							<a href="<c:url value='/login'/>">Đăng Nhập</a>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

</div>

<script src='https://www.google.com/recaptcha/api.js'></script> <!-- Google reCAPTCHA API -->
<script>
	$(document).ready(function() {
		$('#img').on('change', function() {
			showImage(this);
		});
	});

	function checkPasswordMatch(fieldConfirmPassword){
		if(fieldConfirmPassword.value != $('#password').val()){
			fieldConfirmPassword.setCustomValidity("Password do not match");
		}
		else{
			fieldConfirmPassword.setCustomValidity("");
		}
	}

	window.onload = function(){
		let isValid = false;
		const form = document.getElementById("formSubmit");
		const error = document.getElementById("error");

		form.addEventListener("submit",function(event){
			event.preventDefault();
			const response = grecaptcha.getResponse();
			if(response){
				form.submit();
			}
			else{
				error.innerHTML = "Please Check";
			}

		});
	}
	function showImage(fileInput){
		file = fileInput.files[0];
		reader = new FileReader();

		reader.onload = function(e){
			$('#imgPreview').attr('src',e.target.result);
		}
		reader.readAsDataURL(file);
	}
	$(document).ready(function() {
		$('#userName').on('blur', function() {
			const username = $(this).val();
			const usernameInput = $(this)[0]; // Lấy phần tử DOM của input
			// Gửi yêu cầu tới server
			$.ajax({
				url:  "<c:url value='/check-username'/>" ,
				method: 'POST',
				data: { userName: username },
				success: function(response) {
					const feedback = $('#usernameFeedback');
					if (response.exists) {
						feedback.text('Username đã tồn tại. Vui lòng chọn tên khác.').show();
						usernameInput.setCustomValidity('Username đã tồn tại.');
					} else {
						feedback.hide();
						usernameInput.setCustomValidity("");
					}
				},
				error: function() {
					console.error('Lỗi khi kiểm tra tên người dùng.');
				}
			});
		});
	});
</script>
</body>
</html>
