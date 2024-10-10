<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

    <!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <hr/>
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex flex-column align-items-center justify-content-center p-5" href="index.html">
        <div class="sidebar-brand-icon p-3">
            <i class="fa fa-user-tie"></i>
        </div>
        <div class="sidebar-brand-text mx-4 text-center">ChronoLux Admin</div>
    </a>

    <!-- Divider -->
    <hr/>
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/admin/home'/>">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Nav Item - Quản lý thương hiệu -->
    <li class="nav-item">
        <a class="nav-link" href="<c:url value='/admin/posts'/>">
            <i class="fas fa-star"></i>
            <span>Quản lý thương hiệu</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">
</ul>

<!-- End of Sidebar -->