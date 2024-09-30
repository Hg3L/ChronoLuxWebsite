<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>ChronoLux- Reset Password</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

<div>
  <p class="text-center">
    <h1 style="
        text-align: center;
        color: #f1c40f;
        font-size: 2.5em;
        font-weight: bold;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        Reset your password
    </h1>
   </p>
</div>

<form action="<c:url value='/login/reset_password'/>"  method="post" style="max-width: 500px; margin: 50px auto;height: 600px;">
    <input type="hidden" name="token" value="${token}" />
<div class="border border-secondary rounded p-3">
    <div>
            <c:if test="${not empty message}">
               <p class="text-warning"> ${message} </p>
            </c:if>
        <p>
            <input type="password" name="password" id="password" class="form-control"
                placeholder="Enter your new password" required autofocus />
        </p>
        <p>
            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm your new password" oninput="checkPasswordMatch(this);"
                required  />
        </p>
        <p class="text-center">
            <input type="submit" value="Change Password" class="btn btn-primary" />
        </p>
    </div>
    <div class="row">
                <div class="col-12">
                  <hr class="mt-5 mb-4 border-secondary-subtle">
                  <div class="d-flex gap-4 justify-content-center">
                    <a href="#!" class="link-secondary text-decoration-none">Log In</a>
                  </div>
                </div>
              </div>
</div>
</form>
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