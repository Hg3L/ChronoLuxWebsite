<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hau.util.SecurityUtil" %>

    <!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" >
    <ul class="navbar-nav ml-auto"> <!-- Thêm ml-auto để đẩy nội dung sang phải -->
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <img class="img-profile rounded-circle mr-3" src="${pageContext.request.contextPath}/template/web/img/user-logos/<%=SecurityUtil.getPrincipal().getImgUrl()%>" alt="Avatar">
                <span class="mr-2 d-none d-lg-inline text-gray-600">Wellcome, <%=SecurityUtil.getPrincipal().getFullName()%></span>

            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/admin-profile">
                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                    Profile
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="<c:url value='/logout'/>">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Logout
                </a>
            </div>
        </li>
    </ul>
</nav>

<!-- End of Topbar -->