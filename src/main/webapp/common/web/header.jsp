<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>

  <!-- Topbar Start -->
    <div class="container-fluid">
        <div class="row align-items-center py-3 px-xl-5">
            <div class="col-lg-3 d-none d-lg-block">
                <a href="" class="text-decoration-none">
                    <img src="${pageContext.request.contextPath}/template/web/img/header/Logo.svg" alt="ChronoLux Logo">
                </a>
            </div>
            <div class="col-lg-6 col-6 text-left">
                <form action="">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Find Your Watch">
                        <div class="input-group-append">
                                <span class="input-group-text bg-transparent text-primary">
                                    <i class="fa fa-search"></i>
                                </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-3 col-6 text-right">
                <a href="" class="btn border">
                    <i class="fas fa-heart text-primary"></i>
                    <span class="badge">0</span>
                </a>
                <a href="" class="btn border">
                    <i class="fas fa-shopping-cart text-primary"></i>
                    <span class="badge">0</span>
                </a>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


<!-- Navbar Start -->

        <style>
            /* Custom styles for centering, font size, and spacing */
            .navbar-nav-center {
                font-size: 1.1rem; /* Adjust font size as needed */
            }
            .navbar-nav-center .nav-link {
                margin: 0 15px; /* Increase spacing between items */
            }
        </style>

        <div class="container">
            <div class="row">
                <div class="col-lg-9">
                    <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">
                        <a href="/" class="text-decoration-none d-block d-lg-none">
                            <img src="/img/Logo.svg" alt="ChronoLux Logo">
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">

                            <!-- Centered Navbar Links with Increased Spacing -->
                            <div class="navbar-nav mx-auto py-0 navbar-nav-center">
                                <a href="<c:url value='/home'/>" class="nav-item nav-link active">Home</a>
                                <a href="<c:url value='/shop?page=1&limit=8'/>" class="nav-item nav-link">Shop</a>
                                <a href="<c:url value='/shop?page=1&limit=8'/>" class="nav-item nav-link">Shop Detail</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">More</a>
                                    <div class="dropdown-menu rounded-0 m-0">
                                        <a href="cart.html" class="dropdown-item">Your Cart</a>
                                        <a href="checkout.html" class="dropdown-item">Checkout</a>
                                    </div>
                                </div>
                                <a href="contact.html" class="nav-item nav-link">Contact</a>
                            </div>

                            <!-- Right-aligned Navbar Links -->
                            <div class="navbar-nav ml-auto py-0">
                                <a href="login.html" class="nav-item nav-link">Login</a>
                                <a href="register.html" class="nav-item nav-link">Register</a>
                            </div>

                        </div>
                    </nav>
                </div>
            </div>
        </div>
<!-- Navbar End -->
