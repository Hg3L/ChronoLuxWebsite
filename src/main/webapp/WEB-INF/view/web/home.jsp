<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

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

<body>
<!-- Banner Start -->
<div class="container-fluid mb-5">
    <div class="row border-top px-xl-5">
        <div id="header-carousel" class="carousel slide" style="width: 100%;" data-ride="carousel" data-interval="5000">
            <!-- Carousel Indicators -->
            <ol class="carousel-indicators">
                <c:forEach var="item" items="${posts}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.first}">
                            <li data-target="#header-carousel" data-slide-to="${status.index}" class="active"></li>
                        </c:when>
                        <c:otherwise>
                            <li data-target="#header-carousel" data-slide-to="${status.index}"></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ol>

            <!-- Carousel Items -->
            <div class="carousel-inner">
                <c:forEach var="item" items="${posts}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.first}">
                            <div class="carousel-item active" style="height: 410px;">
                                <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/posts/${item.img}" alt="Image">

                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item" style="height: 410px;">
                                <img class="img-fluid" src="${pageContext.request.contextPath}/template/web/img/posts/${item.img}" alt="Image">

                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

        </div>
    </div>
</div>
<!-- Banner End -->


<%--<!-- Featured Start -->--%>
<%--<div class="container-fluid pt-5">--%>
<%--    <div class="row px-xl-5 pb-3">--%>
<%--        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                <h1 class="fa fa-check text-primary m-0 mr-3"></h1>--%>
<%--                <h5 class="font-weight-semi-bold m-0">Quality Product</h5>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                <h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>--%>
<%--                <h5 class="font-weight-semi-bold m-0">Free Shipping</h5>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>--%>
<%--                <h5 class="font-weight-semi-bold m-0">14-Day Return</h5>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">--%>
<%--            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">--%>
<%--                <h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>--%>
<%--                <h5 class="font-weight-semi-bold m-0">24/7 Support</h5>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Featured End -->--%>


<!-- Brand Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5" style="font-family: Arial"><span class="px-2">Thương Hiệu</span></h2>
    </div>
    <div class="row px-xl-5 pb-3">
        <c:forEach var="item" items="${brand.listResult}">
            <div class="col-6 col-sm-4 col-md-3 col-lg-2 col-xl-1 pb-1"> <!-- Chỉnh responsive -->
                <div class="item d-flex flex-column border m-1" style="padding: 4px;">
                    <a href="<c:url value='/shop/brand?id=${item.id}&page=1&limit=8'/>"
                       class="cat-img position-relative overflow-hidden mb-3">
                        <img class="img-fluid"
                             src="<c:url value='/template/web/img/brands/${item.iconUrl}'/>" alt=""
                             style="max-width: 100%; height: auto;"> <!-- Giới hạn kích thước hình ảnh -->
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- Categories End -->


<%--<!-- Offer Start -->--%>
<%--<div class="container-fluid offer pt-5">--%>
<%--    <div class="row px-xl-5">--%>
<%--        <div class="col-md-6 pb-4">--%>
<%--            <div class="position-relative bg-secondary text-center text-md-right text-white mb-2 py-5 px-5">--%>
<%--                <img src="img/offer-1.png" alt="">--%>
<%--                <div class="position-relative" style="z-index: 1;">--%>
<%--                    <h5 class="text-uppercase text-primary mb-3">20% off the all order</h5>--%>
<%--                    <h1 class="mb-4 font-weight-semi-bold">Spring Collection</h1>--%>
<%--                    <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Shop Now</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-6 pb-4">--%>
<%--            <div class="position-relative bg-secondary text-center text-md-left text-white mb-2 py-5 px-5">--%>
<%--                <img src="img/offer-2.png" alt="">--%>
<%--                <div class="position-relative" style="z-index: 1;">--%>
<%--                    <h5 class="text-uppercase text-primary mb-3">20% off the all order</h5>--%>
<%--                    <h1 class="mb-4 font-weight-semi-bold">Winter Collection</h1>--%>
<%--                    <a href="" class="btn btn-outline-primary py-md-2 px-md-3">Shop Now</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Offer End -->--%>


<!-- Products Start -->
<div class="container-fluid pt-5 px-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5" style="font-family: Arial"><span class="px-2">Bán Chạy</span></h2>
    </div>
    <div class="product_list d-flex justify-content-center align-items-center flex-wrap">
        <c:forEach var="item" items="${productTrendy}">
            <div class="product-card p-5">
                <c:if test="${item.stock <= 0}">
                    <span class="try-on-label">SOLD OUT</span>
                </c:if>

                <a href="<c:url value='/product-detail?id=${item.id}'/>">
                    <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"
                         alt="Santos De Cartier Watch">
                </a>
                <div class="product-info">
                    <div class="product-name" style="color: black">${item.name}</div>
                    <div class="product-description">Loại Đồng Hồ: ${item.watchType}</div>
                    <div class="product-price">
                        <span id="price" >${item.price}đ</span>
                    </div>
                    <div class="button-list d-flex justify-content-center align-items-center flex-wrap">
                        <a href="<c:url value='/product-detail?id=${item.id}'/>" class="add-to-bag-btn bg-dark" style="width: 300px">Thông Tin Chi Tiết</a>
                        <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn bg-dark" style="width: 300px">Thêm Vào Giỏ Hàng</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<style>
    .product_list {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        gap: 1rem; /* Adjusts space between items */
    }

    .product_card {
        max-width: 250px; /* Set a fixed or responsive max width */
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }
</style>


<!-- Products End -->


<%--<!-- Subscribe Start -->--%>
<%--<div class="container-fluid bg-secondary my-5">--%>
<%--    <div class="row justify-content-md-center py-5 px-xl-5">--%>
<%--        <div class="col-md-6 col-12 py-5">--%>
<%--            <div class="text-center mb-2 pb-2">--%>
<%--                <h2 class="section-title px-5 mb-3"><span class="bg-secondary px-2">Stay Updated</span></h2>--%>
<%--                <p>Amet lorem at rebum amet dolores. Elitr lorem dolor sed amet diam labore at justo ipsum--%>
<%--                    eirmod duo labore labore.</p>--%>
<%--            </div>--%>
<%--            <form action="">--%>
<%--                <div class="input-group">--%>
<%--                    <input type="text" class="form-control border-white p-4" placeholder="Email Goes Here">--%>
<%--                    <div class="input-group-append">--%>
<%--                        <button class="btn btn-primary px-4">Subscribe</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Subscribe End -->--%>


<!-- Products Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5" style="font-family: Arial"><span class="px-2">Sản Phẩm Mới</span></h2>
    </div>
    <div class="product_list d-flex justify-content-center align-items-center flex-wrap">
        <c:forEach var="item" items="${product.listResult}">
            <div class="product-card p-5">
                <c:if test="${item.stock <= 0}">
                    <span class="try-on-label">SOLD OUT</span>
                </c:if>

                <a href="<c:url value='/product-detail?id=${item.id}'/>">
                    <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"
                         alt="Santos De Cartier Watch">
                </a>
                <div class="product-info">
                    <div class="product-name" style="color: black">${item.name}</div>
                    <div class="product-description">Loại Đồng Hồ: ${item.watchType}</div>
                    <div class="product-price">
                        <span id="price" >${item.price}đ</span>
                    </div>
                    <div class="button-list d-flex justify-content-center align-items-center flex-wrap">
                        <a href="<c:url value='/product-detail?id=${item.id}'/>" class="add-to-bag-btn bg-dark text-decoration-none" style="width: 300px">Thông Tin Chi Tiết</a>
                        <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn bg-dark text-decoration-none" style="width: 300px">Thêm Vào Giỏ Hàng</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    document.querySelectorAll('#price').forEach(element => {
        let price = parseInt(element.innerText.replace("đ", ""), 10);
        element.innerText = price.toLocaleString("vi-VN") + "đ";
    });

</script>

<!-- Products End -->
</body>