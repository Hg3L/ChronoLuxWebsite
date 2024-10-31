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

		h1 {
			font-size: 3rem; /* Increase title size */
			color: white;
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

<div class="container">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"> <!-- Font Awesome CSS -->
	<div class="row py-5 mt-4 align-items-center border rounded-5 p-3 bg-light shadow box-area">
		<!-- Left Column -->
		<div class="col-md-5 mb-5 mb-md-0 d-flex flex-column justify-content-center align-items-center ml-5">
			<h1>Tạo Tài Khoản ChronoLux</h1>
			<p class="font-italic text-muted">Trở thành ChronoMember để nhận nhiều ưu đãi hấp dẫn</p>
		</div>
		<!-- Registration Form -->
		<div class="col-md-7 col-lg-6 ml-auto">
				<div class="row col-md-6 rounded-4 d-flex justify-content-center align-items-center flex-column left-box">
					<!-- First Name -->
					<form:form method="post" id="formSubmit"  action="${pageContext.request.contextPath}/login/add" enctype="multipart/form-data" >
					<div class="row ml-5 rounded-4 d-flex justify-content-center align-items-center flex-column left-box">
						<input class="text" type="text" name="userName" id="userName" placeholder="Username" required minlength="6" maxlength="20">
						<span id="usernameFeedback" style="color: red; display: none;"></span>
						<input class="text email" type="email" name="email" placeholder="Email" required="">

						<input class="text" type="text" name="fullName" placeholder="FullName" required="">
						<br> </br>
						<label> Avatar: </label>
						<input class="text" type="file" name="img" id ="img" accept="image/*"  >
						<br> </br>
						<img id = "imgPreview" alt = "Avt Preview"/>

						<br> </br>
						<input class="text" type="password" name="password" id="password" placeholder="Password" required="" minlength = "6">
						<input class="text w3lpass" type="password" name="ConfirmPassword" id="ConfirmPassword" placeholder="Confirm Password" oninput="checkPasswordMatch(this);" required="" >
						<div class="wthree-text">
						</div>
						<div class="g-recaptcha" data-sitekey="6LcvolUqAAAAAHsPdMaMhrNDeg_HE-FuNR4XO95n"></div>
						<div id ="error"> </div>
						<button type="submit" class="btn btn-success btn-sm">
							Sign Up
						</button>
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
