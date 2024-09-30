<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url var="loginURL" value="/login"/>
<c:url var="registerURL" value="/login/register"/>
<c:url var="APIurl" value="/api/user"/>
<!DOCTYPE html>
<html>
<head>
   <title>ChronoLux-Register</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<!-- main -->
	<div class="main-w3layouts wrapper">
		<h1>Creative SignUp Form</h1>
		<div class="main-agileinfo">
			<div class="agileits-top">
				<form id="formSubmit" method="post" action="<c:url value='/login/add'/>">
					<input class="text" type="text" name="userName" id="userName" placeholder="Username" required="">
					<input class="text email" type="email" name="email" placeholder="Email" required="">
					<input class="text" type="text" name="fullName" placeholder="FullName" required="">
					<br> </br>
					<input class="text" type="password" name="password" id="password" placeholder="Password" required="">
					<input class="text w3lpass" type="password" name="ConfirmPassword" id="ConfirmPassword" placeholder="Confirm Password" oninput="checkPasswordMatch(this);" required="">
					<div class="wthree-text">
					</div>
					<button type="submit" class="btn btn-success btn-sm">
						Sign Up
					</button>
				</form>
				<p> Don't have an Account? <a href="#"> Login Now!</a> </p>
				    <div class="alert alert-danger" role="alert" id="message" style="text-align: center; display: none;"> </div>
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
	<!-- //main -->
	<script>
        function checkPasswordMatch(fieldConfirmPassword){
            if(fieldConfirmPassword.value != $('#password').val()){
                fieldConfirmPassword.setCustomValidity("Password do not match");
            }
            else{
                fieldConfirmPassword.setCustomValidity("");
            }
        }
    </script>
</body>
</html>