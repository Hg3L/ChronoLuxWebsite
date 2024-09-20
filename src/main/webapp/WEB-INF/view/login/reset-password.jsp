<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Reset Password</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

<div>
    <h2>Reset Your Password</h2>
</div>

<form action="<c:url value='/login/reset_password'/>"  method="post" style="max-width: 500px; margin: 50px auto;height: 600px;">
    <input type="hidden" name="token" value="${token}" />
<div class="border border-secondary rounded p-3">
    <div>

        <p>
            <input type="password" name="password" id="password" class="form-control"
                placeholder="Enter your new password" required autofocus />
        </p>
        <p>
            <input type="password" class="form-control" placeholder="Confirm your new password"
                required />
        </p>
        <p class="text-center">
            <input type="submit" value="Change Password" class="btn btn-primary" />
        </p>
    </div>
</div>
</form>

</body>
</html>