<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>ChronoLux - Sign Up</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="path/to/bootstrap.min.css"> <!-- Link to Bootstrap CSS -->
	<link rel="stylesheet" href="path/to/font-awesome.min.css"> <!-- Link to Font Awesome CSS -->
	<style>
		body {
			background-image: url('<c:url value="/src/main/webapp/template/login/img/bg-1.jpg"/>');
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
			background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent overlay */
			z-index: 1;
		}

		.main-w3layouts {
			position: relative;
			z-index: 2; /* Ensure content is above overlay */
			color: white; /* Set text color to white */
		}

		h1 {
			font-size: 2.5rem; /* Increase title size */
			margin-bottom: 30px; /* Spacing below title */
		}

		.form-control {
			margin-bottom: 15px; /* Spacing between inputs */
		}

		.btn-success {
			width: 100%; /* Full width button */
		}
	</style>
</head>

<body>
<div class="overlay"></div> <!-- Semi-transparent overlay -->

<div class="main-w3layouts wrapper">
	<h1>Creative SignUp Form</h1>
	<div class="main-agileinfo">
		<div class="agileits-top">
			<form:form method="post" id="formSubmit" action="${pageContext.request.contextPath}/login/add" enctype="multipart/form-data">
				<input class="text form-control" type="text" name="userName" id="userName" placeholder="Username" required minlength="6" maxlength="20">
				<span id="usernameFeedback" style="color: red; display: none;"></span>

				<input class="text form-control email" type="email" name="email" placeholder="Email" required>

				<input class="text form-control" type="text" name="fullName" placeholder="Full Name" required>

				<label for="img">Avatar:</label>
				<input class="text form-control" type="file" name="img" id="img" accept="image/*">

				<img id="imgPreview" alt="Avatar Preview" class="img-fluid mb-3" />

				<input class="text form-control" type="password" name="password" id="password" placeholder="Password" required minlength="6">
				<input class="text form-control" type="password" name="ConfirmPassword" id="ConfirmPassword" placeholder="Confirm Password" oninput="checkPasswordMatch(this);" required>

				<div class="g-recaptcha" data-sitekey="6LcvolUqAAAAAHsPdMaMhrNDeg_HE-FuNR4XO95n"></div>
				<div id="error"></div>

				<button type="submit" class="btn btn-success btn-sm">Sign Up</button>
			</form:form>

			<p>Don't have an Account? <a href="#">Login Now!</a></p>
			<div class="alert alert-danger" role="alert" id="message" style="text-align: center; display: none;"></div>
		</div>
	</div>

	<!-- copyright -->
	<div class="colorlibcopy-agile">
		<p>© 2018 Colorlib Signup Form. All rights reserved | Design by <a href="https://colorlib.com/" target="_blank">Colorlib</a></p>
	</div>
	<!-- //copyright -->

	<ul class="colorlib-bubbles">
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
	</ul>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
	$(document).ready(function () {
		$('#img').on('change', function () {
			showImage(this);
		});

		$('#userName').on('blur', function () {
			const username = $(this).val();
			const usernameInput = $(this)[0]; // Get the DOM element of input

			// Send request to server
			$.ajax({
				url: "<c:url value='/check-username'/>",
				method: 'POST',
				data: { userName: username },
				success: function (response) {
					const feedback = $('#usernameFeedback');
					if (response.exists) {
						feedback.text('Username already exists. Please choose another.').show();
						usernameInput.setCustomValidity('Username already exists.');
					} else {
						feedback.hide();
						usernameInput.setCustomValidity("");
					}
				},
				error: function () {
					console.error('Error checking username.');
				}
			});
		});
	});

	function checkPasswordMatch(fieldConfirmPassword) {
		if (fieldConfirmPassword.value != $('#password').val()) {
			fieldConfirmPassword.setCustomValidity("Passwords do not match");
		} else {
			fieldConfirmPassword.setCustomValidity("");
		}
	}

	window.onload = function () {
		const form = document.getElementById("formSubmit");
		const error = document.getElementById("error");

		form.addEventListener("submit", function (event) {
			event.preventDefault();
			const response = grecaptcha.getResponse();
			if (response) {
				form.submit();
			} else {
				error.innerHTML = "Please check the reCAPTCHA.";
			}
		});
	}

	function showImage(fileInput) {
		const file = fileInput.files[0];
		const reader = new FileReader();

		reader.onload = function (e) {
			$('#imgPreview').attr('src', e.target.result);
		}
		reader.readAsDataURL(file);
	}
</script>
</body>
</html>
