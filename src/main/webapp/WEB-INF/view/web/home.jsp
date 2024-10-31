<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>

        <head>
            <meta charset="UTF-8">
            <title>ChronoLux - Home</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="Free HTML Templates" name="keywords">
            <meta content="Free HTML Templates" name="description">
            <!-- Favicon -->
            <link href="<c:url value='/template/web/img/ChronoLuxIcon.svg'/>" rel="icon">

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link
                href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">


            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="<c:url value='/template/web/lib/owlcarousel/assets/owl.carousel.min.css'/>" rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href=" <c:url value='/template/web/css/style.css'/>" rel="stylesheet">
            <%----------------------------%>
                <style>
                    .product-card {
                        width: 320px;
                        border: 1px solid #ddd;
                        border-radius: 10px;
                        padding: 10px;
                        text-align: center;
                        font-family: Arial, sans-serif;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                        position: relative;
                        margin: 15px;
                        display: inline-block;
                    }

                    .product-card img {
                        width: 100%;
                        border-radius: 5px;
                        cursor: pointer;
                    }

                    .try-on-label {
                        position: absolute;
                        top: 10px;
                        left: 10px;
                        background-color: white;
                        font-size: 12px;
                        padding: 3px 7px;
                        border-radius: 5px;
                        border: 1px solid #ddd;
                    }

                    .wishlist-btn {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background: white;
                        border: none;
                        cursor: pointer;
                        font-size: 18px;
                        padding: 5px;
                        border-radius: 5px;
                    }

                    .product-info {
                        margin-top: 10px;
                    }

                    .product-name {
                        font-size: 18px;
                        font-weight: bold;
                        margin: 10px 0;
                    }

                    .product-description {
                        color: #555;
                        font-size: 14px;
                        margin: 5px 0;
                    }

                    .product-price {
                        font-size: 16px;
                        color: #007b00;
                        margin: 10px 0;
                    }

                    .add-to-bag-btn {
                        background-color: black;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        cursor: pointer;
                        font-size: 14px;
                        border-radius: 5px;
                        margin-top: 10px;
                    }
                </style>


        </head>

<%--        <body>--%>
<%--            <!-- Navbar Start -->--%>
<%--            <div class="container-fluid mb-5">--%>
<%--                <div class="row border-top px-xl-5">--%>

<%--                    <div class="col-lg-9">--%>

<%--                        <div id="header-carousel" class="carousel slide" data-ride="carousel">--%>
<%--                            <div class="carousel-inner">--%>
<%--                                <div class="carousel-item active" style="height: 410px;">--%>
<%--                                    <img class="img-fluid" src="<c:url value='/template/web/img/carousel-1.jpg'/>"--%>
<%--                                        alt="Image">--%>
<%--                                    <div--%>
<%--                                        class="carousel-caption d-flex flex-column align-items-center justify-content-center">--%>
<%--                                        <div class="p-3" style="max-width: 700px;">--%>
<%--                                            <h4 class="text-light text-uppercase font-weight-medium mb-3">10% Off Your--%>
<%--                                                First Order</h4>--%>
<%--                                            <h3 class="display-4 text-white font-weight-semi-bold mb-4">Fashionable--%>
<%--                                                Dress</h3>--%>
<%--                                            <a href="" class="btn btn-light py-2 px-3">Shop Now</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="carousel-item" style="height: 410px;">--%>
<%--                                    <img class="img-fluid" src="img/carousel-2.jpg" alt="Image">--%>
<%--                                    <div--%>
<%--                                        class="carousel-caption d-flex flex-column align-items-center justify-content-center">--%>
<%--                                        <div class="p-3" style="max-width: 700px;">--%>
<%--                                            <h4 class="text-light text-uppercase font-weight-medium mb-3">10% Off Your--%>
<%--                                                First Order</h4>--%>
<%--                                            <h3 class="display-4 text-white font-weight-semi-bold mb-4">Reasonable Price--%>
<%--                                            </h3>--%>
<%--                                            <a href="" class="btn btn-light py-2 px-3">Shop Now</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <a class="carousel-control-prev" href="#header-carousel" data-slide="prev">--%>
<%--                                <div class="btn btn-dark" style="width: 45px; height: 45px;">--%>
<%--                                    <span class="carousel-control-prev-icon mb-n2"></span>--%>
<%--                                </div>--%>
<%--                            </a>--%>
<%--                            <a class="carousel-control-next" href="#header-carousel" data-slide="next">--%>
<%--                                <div class="btn btn-dark" style="width: 45px; height: 45px;">--%>
<%--                                    <span class="carousel-control-next-icon mb-n2"></span>--%>
<%--                                </div>--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- Navbar End -->--%>


<%--            <!-- Featured Start -->--%>
<%--            <div class="container-fluid pt-5">--%>
<%--                <div class="row px-xl-5 pb-3">--%>
<%--                    <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--                        <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                            <h1 class="fa fa-check text-primary m-0 mr-3"></h1>--%>
<%--                            <h5 class="font-weight-semi-bold m-0">Quality Product</h5>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--                        <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                            <h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>--%>
<%--                            <h5 class="font-weight-semi-bold m-0">Free Shipping</h5>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--                        <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                            <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>--%>
<%--                            <h5 class="font-weight-semi-bold m-0">14-Day Return</h5>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--                        <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                            <h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>--%>
<%--                            <h5 class="font-weight-semi-bold m-0">24/7 Support</h5>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- Featured End -->--%>


<%--            <!-- Brand Start -->--%>
<%--            <div class="container-fluid pt-5">--%>
<%--                <div class="row px-xl-5 pb-3">--%>
<%--                    <c:forEach var="item" items="${brand.listResult}">--%>
<%--                        <div class="col-lg-2 col-md-6 pb-1">--%>
<%--                            <div class="cat-item d-flex flex-column border mb-4" style="padding: 20px;">--%>
<%--                                <p class="text-right">15 Products</p>--%>
<%--                                <a href="<c:url value='/shop/brand?id=${item.id}&page=1&limit=8'/>"--%>
<%--                                    class="cat-img position-relative overflow-hidden mb-3">--%>
<%--                                    <img class="img-fluid"--%>
<%--                                        src="<c:url value='/template/web/img/brands/${item.iconUrl}'/>" alt="">--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- Categories End -->--%>


<%--            <!-- Offer Start -->--%>
<%--            <div class="container-fluid offer pt-5">--%>
<%--                <div class="row px-xl-5">--%>
<%--                    <div class="col-md-6 pb-4">--%>
<%--                        <div class="position-relative bg-secondary text-center text-md-right text-white mb-2 py-5 px-5">--%>
<%--                            <img src="img/offer-1.png" alt="">--%>
<%--                            <div class="position-relative" style="z-index: 1;">--%>
<%--                                <h5 class="text-uppercase text-primary mb-3">20% off the all order</h5>--%>
<%--                                <h1 class="mb-4 font-weight-semi-bold">Spring Collection</h1>--%>
<%--                                <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Shop Now</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6 pb-4">--%>
<%--                        <div class="position-relative bg-secondary text-center text-md-left text-white mb-2 py-5 px-5">--%>
<%--                            <img src="img/offer-2.png" alt="">--%>
<%--                            <div class="position-relative" style="z-index: 1;">--%>
<%--                                <h5 class="text-uppercase text-primary mb-3">20% off the all order</h5>--%>
<%--                                <h1 class="mb-4 font-weight-semi-bold">Winter Collection</h1>--%>
<%--                                <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Shop Now</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- Offer End -->--%>


            <!-- Products Start -->
            <div class="container-fluid pt-5">
                <div class="text-center mb-4">
                    <h2 class="section-title px-5"><span class="px-2">Trandy Products</span></h2>
                </div>
                <div class="row px-xl-5 pb-3">
                    <c:forEach var="item" items="${productTrendy}">
                                           <div class="product-card">
                                               <c:if test="${item.stock <= 0}">
                                                   <span class="try-on-label">SOLD OUT</span>
                                               </c:if>

                                               <a href="<c:url value='/product-detail?id=${item.id}'/>">
                                                   <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"
                                                       alt="Santos De Cartier Watch">
                                               </a>
                                               <div class="product-info">
                                                   <div class="product-name">${item.name}</div>
                                                   <div class="product-description">watch type: ${item.watchType}</div>
                                                   <div id="price">${item.price}đ</div>
                                                   <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn" >ADD TO BAG</a>
                                               </div>
                                           </div>
                                       </c:forEach>
                </div>
            </div>
            <!-- Products End -->


<%--            <!-- Subscribe Start -->--%>
<%--            <div class="container-fluid bg-secondary my-5">--%>
<%--                <div class="row justify-content-md-center py-5 px-xl-5">--%>
<%--                    <div class="col-md-6 col-12 py-5">--%>
<%--                        <div class="text-center mb-2 pb-2">--%>
<%--                            <h2 class="section-title px-5 mb-3"><span class="bg-secondary px-2">Stay Updated</span></h2>--%>
<%--                            <p>Amet lorem at rebum amet dolores. Elitr lorem dolor sed amet diam labore at justo ipsum--%>
<%--                                eirmod duo labore labore.</p>--%>
<%--                        </div>--%>
<%--                        <form action="">--%>
<%--                            <div class="input-group">--%>
<%--                                <input type="text" class="form-control border-white p-4" placeholder="Email Goes Here">--%>
<%--                                <div class="input-group-append">--%>
<%--                                    <button class="btn btn-primary px-4">Subscribe</button>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- Subscribe End -->--%>


<%--            <!-- Products Start -->--%>
<%--            <div class="container-fluid pt-5">--%>
<%--                <div class="text-center mb-4">--%>
<%--                    <h2 class="section-title px-5"><span class="px-2">Just Arrived</span></h2>--%>
<%--                </div>--%>
<%--                <div class="row px-xl-5 pb-3">--%>
<%--                    <c:forEach var="item" items="${product.listResult}">--%>
<%--                        <div class="product-card">--%>
<%--                            <c:if test="${item.stock <= 0}">--%>
<%--                                <span class="try-on-label">SOLD OUT</span>--%>
<%--                            </c:if>--%>

<%--                            <a href="<c:url value='/product-detail?id=${item.id}'/>">--%>
<%--                                <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"--%>
<%--                                    alt="Santos De Cartier Watch">--%>
<%--                            </a>--%>
<%--                            <div class="product-info">--%>
<%--                                <div class="product-name">${item.name}</div>--%>
<%--                                <div class="product-description">watch type: ${item.watchType}</div>--%>
<%--                                <div class="product-price">$${item.price}</div>--%>
<%--                                <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn" >ADD TO BAG</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </div>--%>


<%--            <!-- Products End -->--%>
<%--        </body>--%>
<body>
<!-- Navbar Start -->
<div class="container-fluid mb-5">
    <div class="row border-top px-xl-5">
        <div id="header-carousel" class="carousel slide" style="width: 100%;" data-ride="carousel">
            <!-- Carousel Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#header-carousel" data-slide-to="0" class="active"></li>
                <li data-target="#header-carousel" data-slide-to="1"></li>
            </ol>

            <div class="carousel-inner">
                <div class="carousel-item active" style="height: 410px;">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Banner-1.webp" alt="Image">
                    <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                        <div class="p-3" style="max-width: 700px;">
                            <h3 class="display-4 text-white font-weight-semi-bold mb-4">Elite Style</h3>
                            <h4 class="text-light text-uppercase font-weight-medium mb-3">
                                Elevate your wrist with watches that define <br> timeless prestige and contemporary flair
                            </h4>
                            <a href="" class="btn btn-light py-2 px-3">Shop Now</a>
                        </div>
                    </div>
                </div>
            <!-- Products Start -->
            <div class="container-fluid pt-5">
                <div class="text-center mb-4">
                    <h2 class="section-title px-5"><span class="px-2">Just Arrived</span></h2>
                </div>
                <div class="row px-xl-5 pb-3">
                    <c:forEach var="item" items="${product.listResult}">
                        <div class="product-card">
                            <c:if test="${item.stock <= 0}">
                                <span class="try-on-label">SOLD OUT</span>
                            </c:if>

                            <a href="<c:url value='/product-detail?id=${item.id}'/>">
                                <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"
                                    alt="Santos De Cartier Watch">
                            </a>
                            <div class="product-info">
                                <div class="product-name">${item.name}</div>
                                <div class="product-description">watch type: ${item.watchType}</div>
                                <div class="product-price">
                                  <span id="price" >${item.price}đ</span>
                                </div>
                                <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn" >ADD TO BAG</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Navbar End -->



<!-- Categories Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Top Brand</span></h2>
    </div>
    <div class="row px-xl-5 pb-3">
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Rolexw.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Rolex.png" alt="">
                </a>
            </div>
        </div>
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Hublotw.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Hublot.png" alt="">
                </a>
            </div>
        </div>
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Omegaw.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Omega.png" alt="">
                </a>
            </div>
        </div>
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/RichardMillew.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/RichardMille.png" alt="">
                </a>
            </div>
        </div>
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Patekw.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Patek.png" alt="">
                </a>
            </div>
        </div>
        <div class="col-lg-2 col-md-6 pb-1">
            <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                <p class="text-right">15 Products</p>
                <a href="" class="cat-img position-relative overflow-hidden mb-8 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Jaegerw.png" alt="">
                </a>
                <a href="" class="cat-logo position-relative overflow-hidden mb-3 text-center">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/home/Jaeger.png" alt="">
                </a>
            </div>
        </div>
    </div>
</div>
<!-- Categories End -->


<!-- Offer Start -->
<div class="container-fluid offer pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Featured</span></h2>
    </div>
    <div class="row px-xl-5">
        <div class="col-lg-6 col-md-12 pb-4 border">
            <div class="position-relative text-center text-md-right text-lg-right text-white mb-2 py-5 px-3">
                <img src="${pageContext.request.contextPath}/template/web/img/home/Featured1.png" alt="">
                <div class="position-relative" style="z-index: 1;">
                    <h5 class="text-uppercase text-primary mb-3">GRANDMASTER CHIME6300GR-001</h5>
                    <h1 class="mb-4 font-weight-semi-bold">PATEK PHILIPPE</h1>
                    <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Learn More</a>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12 pb-4 border">
            <div class="position-relative text-center text-md-left text-lg-left text-white mb-2 py-5 px-3">
                <img src="${pageContext.request.contextPath}/template/web/img/home/Featured2.png" alt="">
                <div class="position-relative" style="z-index: 1;">
                    <h5 class="text-uppercase text-primary mb-3">Master Control Chronograph</h5>
                    <h1 class="mb-4 font-weight-semi-bold">Jaeger-LeCoultre</h1>
                    <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Learn More</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Offer End -->
<%--chỉnh sửa responsive mobile--%>


<!-- Products Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Hot Product</span></h2>
    </div>
    <div class="row px-xl-5 pb-3">
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/hot product/hp1.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Rolex GMT-Master II 18 ct White Gold</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$54,000.00</h6><h6 class="text-muted ml-2"><del>$60,000.00</del></h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/hot product/hp2.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Hublot Big Bang Unico White Ceramic 44 mm</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$23,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/hot product/hp3.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Omega Speedmaster Moonwatch Professional Co-Axial Master Chronometer Chronograph 42 mm Canopus Gold</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$60,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/hot product/hp4.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Patek Philippe Grandmaster Chime Reference 6300G</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$5,400,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Products End -->


<!-- Products Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Just Arrived</span></h2>
    </div>
    <div class="row px-xl-5 pb-3">
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na1.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Richard Mille RM 27-05 Manual Winding Flying Tourbillon Rafael Nadal</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$1,100,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na2.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Patek Philippe World Time with Date, Ref. 5330G-001</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$75,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na3.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">A. Lange & Söhne Datograph Perpetual Tourbillon Honeygold “Lumen”</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$350,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na4.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Audemars Piguet Royal Oak Perpetual Calendar for Eternity ‘John Mayer’</h6>
                    <div class="d-flex justify-content-center">
                        <h6>$200,000.00</h6>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Products End -->

<!-- Products Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Coming Soon</span></h2>
    </div>
    <div class="row px-xl-5 pb-3">
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na1.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Richard Mille RM 27-05 Manual Winding Flying Tourbillon Rafael Nadal</h6>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <i class="fas fa-clock text-primary mr-1"></i>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na2.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Patek Philippe World Time with Date, Ref. 5330G-001</h6>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <i class="fas fa-clock text-primary mr-1"></i>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na3.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">A. Lange & Söhne Datograph Perpetual Tourbillon Honeygold “Lumen”</h6>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <i class="fas fa-clock text-primary mr-1"></i>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="card product-item border-0 mb-4">
                <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/template/web/img/home/new arrival/na4.png" alt="">
                </div>
                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                    <h6 class="text-truncate mb-3">Audemars Piguet Royal Oak Perpetual Calendar for Eternity ‘John Mayer’</h6>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light border">
                    <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                    <i class="fas fa-clock text-primary mr-1"></i>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Products End -->

<!-- Subscribe Start -->
<div class="container-fluid bg-secondary my-5">
    <div class="row justify-content-md-center py-5 px-xl-5">
        <div class="col-md-6 col-12 py-5">
            <div class="text-center mb-2 pb-2">
                <h2 class="section-title px-5 mb-3"><span class="bg-secondary px-2">Stay Updated</span></h2>
                <p>Amet lorem at rebum amet dolores. Elitr lorem dolor sed amet diam labore at justo ipsum eirmod duo labore labore.</p>
            </div>
            <form action="">
                <div class="input-group">
                    <input type="text" class="form-control border-white p-4" placeholder="Your Email">
                    <div class="input-group-append">
                        <button class="btn btn-primary px-4">Subscribe</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Subscribe End -->

<!-- Vendor Start -->
<div class="container-fluid py-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Our Partner</span></h2>
    </div>
    <div class="row px-xl-5">
        <div class="col">
            <div class="owl-carousel vendor-carousel">
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn1.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn2.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn3.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn4.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn5.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn6.png" alt="">
                </div>
                <div class="vendor-item p-4">
                    <img src="${pageContext.request.contextPath}/template/web/img/home/partner/pn7.png" alt="">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Vendor End -->
<%-- thiếu thư viện--%>

<script>
        document.querySelectorAll('#price').forEach(element => {
                let price = parseInt(element.innerText.replace("đ", ""), 10);
                element.innerText = price.toLocaleString("vi-VN") + "đ";
            });

</script>





</body>