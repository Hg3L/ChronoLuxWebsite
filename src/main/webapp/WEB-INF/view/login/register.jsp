<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
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
			font-size: 2.5rem; /* Increase title size */
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
<div class="overlay"></div>

<!-- Navbar -->
<header class="header">
	<nav class="navbar navbar-expand-lg navbar-light py-3">
		<div class="container">
			<a href="#" class="navbar-brand">
				<img src="${pageContext.request.contextPath}/template/web/img/Logo.svg" alt="ChronoLux Logo">
			</a>
		</div>
	</nav>
</header>

<div class="container">
	<div class="row py-5 mt-4 align-items-center">
		<!-- Left Column -->
		<div class="col-md-5 pr-lg-5 mb-5 mb-md-0">
			<h1>Tạo Tài Khoản ChronoLux</h1>
			<p class="font-italic text-muted mb-0">Trở thành ChronoMember để nhận nhiều ưu đãi hấp dẫn</p>
		</div>

		<!-- Registration Form -->
		<div class="col-md-7 col-lg-6 ml-auto">
			<form id="registrationForm" enctype="multipart/form-data">
				<div class="row">
					<!-- First Name -->
					<div class="input-group col-lg-6 mb-4">
						<div class="input-group-prepend">
                                <span class="input-group-text bg-white px-4 border-md border-right-0">
                                    <i class="fa-regular fa-user text-primary"></i>
                                </span>
						</div>
						<input id="firstName" type="text" name="firstname" placeholder="First Name" class="form-control bg-white border-left-0 border-md" required>
					</div>

					<!-- Last Name -->
					<div class="input-group col-lg-6 mb-4">
						<div class="input-group-prepend">
                                <span class="input-group-text bg-white px-4 border-md border-right-0">
                                    <i class="fa fa-user text-primary"></i>
                                </span>
						</div>
						<input id="lastName" type="text" name="lastname" placeholder="Last Name" class="form-control bg-white border-left-0 border-md" required>
					</div>

					<!-- Email Address -->
					<div class="input-group col-lg-12 mb-4">
						<div class="input-group-prepend">
                                <span class="input-group-text bg-white px-4 border-md border-right-0">
                                    <i class="fa-regular fa-envelope"></i>
                                </span>
						</div>
						<input id="email" type="email" name="email" placeholder="Email Address" class="form-control bg-white border-left-0 border-md" required>
					</div>

					<!-- Password -->
					<div class="input-group col-lg-6 mb-4">
						<div class="input-group-prepend">
                                <span class="input-group-text bg-white px-4 border-md border-right-0">
                                    <i class="fa fa-lock text-muted"></i>
                                </span>
						</div>
						<input id="password" type="password" name="password" placeholder="Password" class="form-control bg-white border-left-0 border-md" required minlength="6">
					</div>

					<!-- Password Confirmation -->
					<div class="input-group col-lg-6 mb-4">
						<div class="input-group-prepend">
                                <span class="input-group-text bg-white px-4 border-md border-right-0">
                                    <i class="fa fa-lock text-muted"></i>
                                </span>
						</div>
						<input id="passwordConfirmation" type="password" name="passwordConfirmation" placeholder="Confirm Password" class="form-control bg-white border-left-0 border-md" required oninput="checkPasswordMatch(this);">
					</div>

					<!-- Avatar Upload -->
					<div class="input-group col-lg-12 mb-4 align-items-center">
						<label for="img">Avatar:</label>
						<input class="text form-control" type="file" name="img" id="img" accept="image/*">
					</div>

					<!-- Google reCAPTCHA -->
					<div class="form-group mb-3 d-flex justify-content-center">
						<div class="g-recaptcha mb-4" data-sitekey="6LcvolUqAAAAAHsPdMaMhrNDeg_HE-FuNR4XO95n"></div>
						<script>
							<c:if test="${param.registerSuccessful != null}">
							var toastLiveExample = document.getElementById("liveToast");
							var toast = new bootstrap.Toast(toastLiveExample);
							toast.show();
							</c:if>

							window.onload = function() {
								const form = document.getElementById("formLogin");
								const error = document.getElementById("error");
								form.addEventListener("submit", function(event) {
									event.preventDefault();
									const response = grecaptcha.getResponse();
									if (response) {
										form.submit();
									} else {
										error.innerText = "Please complete the CAPTCHA";
									}
								});
							}
						</script>
					</div>


					<!-- Submit Button -->
					<div class="form-group col-lg-12 mx-auto mb-0">
						<button type="submit" class="btn btn-primary btn-block py-2">
							<span class="font-weight-bold">Create your account</span>
						</button>
					</div>

					<!-- Divider Text -->
					<div class="form-group col-lg-12 mx-auto d-flex align-items-center my-4">
						<div class="border-bottom w-100 ml-5"></div>
						<span class="px-2 small text-muted font-weight-bold text-muted">OR</span>
						<div class="border-bottom w-100 mr-5"></div>
					</div>

					<!-- Social Login -->
					<div class="form-group col-lg-12 mx-auto">
						<a href="href=https://www.facebook.com/v19.0/dialog/oauth?scope=email&client_id=1529293951010030&redirect_uri=http://localhost:8080/ChronoLuxWeb/login-facebook&prompt=login" class="btn btn-primary btn-block py-2 btn-facebook">
							<i class="fab fa-facebook-f mr-2"></i>
							<span class="font-weight-bold">Continue with Facebook</span>
						</a>
						<a href="https://accounts.google.com/o/oauth2/auth?scope=profile%20email&redirect_uri=http://localhost:8080/ChronoLuxWeb/login-google&response_type=code&client_id=236344479421-3djectr8kffvuu3ec4o7ceges5jv2jld.apps.googleusercontent.com&approval_prompt=force" class="btn btn-primary btn-block py-2 btn-twitter">
							<i class="fab fa-twitter mr-2"></i>
							<span class="font-weight-bold">Continue with Gmail</span>
						</a>
					</div>

					<!-- Already Registered -->
					<div class="text-center w-100">
						<p class="text-muted font-weight-bold">Already Registered? <a href="<c:url value ='/login'/>" class="text-primary ml-2">Login</a></p>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> <!-- jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script> <!-- Popper.js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> <!-- Bootstrap JS -->
<script src='https://www.google.com/recaptcha/api.js'></script> <!-- Google reCAPTCHA API -->
<script>
	// Check Password Match
	function checkPasswordMatch(input) {
		var password = document.getElementById("password").value;
		var passwordConfirmation = input.value;
		if (password !== passwordConfirmation) {
			input.setCustomValidity("Passwords do not match.");
		} else {
			input.setCustomValidity('');
		}
	}

	// Image Preview
	document.getElementById("img").addEventListener("change", function (e) {
		const [file] = e.target.files;
		if (file) {
			const imgPreview = document.getElementById("imgPreview");
			imgPreview.src = URL.createObjectURL(file);
			imgPreview.style.display = 'block'; // Show the image
		}
	});

	// Handle Form Submission
	document.getElementById("registrationForm").addEventListener("submit", function (event) {
		event.preventDefault(); // Prevent default form submission

		// Validate reCAPTCHA
		const response = grecaptcha.getResponse();
		if (response.length === 0) {
			document.getElementById("error").innerText = "Please complete the reCAPTCHA.";
			document.getElementById("error").style.display = "block";
			return;
		}

		// Here you can handle form submission (e.g., using AJAX)
		alert("Form submitted successfully!");
		// Reset the form after submission
		this.reset();
		document.getElementById("imgPreview").style.display = 'none'; // Hide the image preview
	});
</script>
</body>

</html>
