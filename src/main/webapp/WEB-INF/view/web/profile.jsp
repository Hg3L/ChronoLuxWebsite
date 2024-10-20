<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Profile</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="Free HTML Templates" name="keywords">
            <meta content="Free HTML Templates" name="description">

            <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css"
                rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"
                rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href=" <c:url value='/template/web/cssviewprofile/style.css'/>" rel="stylesheet">
            <link href=" <c:url value='/template/web/css/style.css'/>" rel="stylesheet">
            <%----------------------------%>
        </head>

        <body>
            <div class="container rounded bg-white mt-5 mb-5">
                <div class="row">
                    <div class="col-md-3 border-right">
                        <c:if test="${user.password != null}">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img
                                    class="rounded-circle mt-5" width="150px"
                                    src="<c:url value='/template/web/img/user-logos/${user.imgUrl}'/>"><span
                                    class="font-weight-bold">${user.getFullName()}</span><span
                                    class="text-black-50">${user.getEmail()}</span><span> </span></div>
                        </c:if>
                        <c:if test="${user.password == null}">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img
                                    class="rounded-circle mt-5" width="150px" src="${user.getImgUrl()}"><span
                                    class="font-weight-bold">${user.getFullName()}</span><span
                                    class="text-black-50">${user.getEmail()}</span><span> </span></div>
                        </c:if>

                    </div>
                    <div class="col-md-9 border-right">
                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-right">Your Profile</h4>
                            </div>
                            <form method="post" action="<c:url value='/user-profile'/>">
                                <div class="row mt-2">
                                    <c:if test="${user.password != null}">
                                        <input type="hidden" name="id" class="form-control" value="${user.id}">
                                    </c:if>

                                    <div class="col-md-6"><label class="labels">Name</label><input type="text"
                                            name="firstName" class="form-control" placeholder="first name"
                                            value="${user.getFirstName()}" required></div>
                                    <div class="col-md-6"><label class="labels">Surname</label><input type="text"
                                            name="surName" class="form-control" value="${user.getSurName()}"
                                            placeholder="surname" required></div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-12"><label class="labels">UserName</label><input type="text"
                                            name="userName" class="form-control" placeholder="enter your phone number"
                                            value="${user.getUsername()}" required readonly></div>
                                    <div class="col-md-12"><label class="labels">Email</label><input type="text"
                                            name="email" class="form-control" placeholder="enter your email"
                                            value="${user.getEmail()}" required></div>
                                    <c:if test="${user.password != null}">
                                        <div class="col-md-12"><label class="labels">Password</label><input
                                                type="password" name="password" class="form-control"
                                                placeholder="enter your password" value="${user.getPassword()}"
                                                required></div>
                                    </c:if>



                                </div>
                                <c:if test="${param.success != null}">
                                    <div class="alert alert-success " role="alert" style="text-align: center;">
                                        Update Successful!
                                    </div>
                                </c:if>
                                <c:if test="${param.error != null}">
                                    <div class="alert alert-danger " role="alert" style="text-align: center;">
                                        Update failed!
                                    </div>
                                </c:if>
                                <c:if test="${user.password != null}">
                                    <div class="mt-5 text-center"><button class="btn btn-primary profile-button"
                                            type="submit">Save Profile</button></div>
                                </c:if>
                                 <input type="hidden" name="imgUrl" class="form-control" value="${user.imgUrl}">
                            </form>
                        </div>
                    </div>

                </div>
            </div>
            </div>
            </div>

        </body>

        </html>