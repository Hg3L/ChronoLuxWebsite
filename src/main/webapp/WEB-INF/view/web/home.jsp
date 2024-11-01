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
     #carousel {
         display: flex;
         overflow: hidden;
         position: relative;
         height: 400px; /* Đặt chiều cao theo ý bạn */
     }

     .slide-item {
         flex: 0 0 45%; /* Mỗi hình ảnh chiếm 45% chiều rộng */
         background-size: cover;
         background-position: center;
         background-repeat: no-repeat;
         border-radius: 15px; /* Bo tròn góc */
         margin: 0 10px; /* Khoảng cách giữa hai hình ảnh */
         transition: transform 0.5s ease;
     }

     .spring-collection {
         background-image: url('https://www.watchstore.vn/images/banners/compress/fc-luxury-banner_1711707751.webp');
     }

     .winter-collection {
         background-image: url('https://www.watchstore.vn/images/banners/compress/omega-luxury-banner_1711707171.webp');
     }

     .slide-link {
         display: block; /* Làm cho thẻ a trở thành khối */
         width: 100%; /* Chiều rộng 100% để phủ toàn bộ slide */
         height: 100%; /* Chiều cao 100% để phủ toàn bộ slide */
         position: absolute; /* Đặt vị trí tuyệt đối */
         top: 0; /* Đặt vị trí ở trên cùng */
         left: 0; /* Đặt vị trí ở bên trái */
         text-decoration: none; /* Bỏ gạch chân */
     }

     .slide-btn {
         position: absolute;
         top: 50%;
         transform: translateY(-50%);
         background-color: rgba(0, 0, 0, 0.5);
         color: white;
         border: none;
         padding: 10px;
         cursor: pointer;
         font-size: 24px;
         z-index: 1;
     }

     .prev {
         left: 10px; /* Vị trí nút trước */
     }

     .next {
         right: 10px; /* Vị trí nút tiếp theo */
     }

     .slide-btn:hover {
         background-color: rgba(0, 0, 0, 0.7); /* Hiệu ứng hover */
     }
     .disabled {
         pointer-events: none; /* Không cho phép tương tác */
         opacity: 0.5; /* Giảm độ mờ */
         cursor: not-allowed; /* Hiển thị con trỏ như không cho phép */
     }



    </style>


</head>

<body>
<!-- Banner Start -->
<div class="container-fluid mb-5">
    <div class="row border-top px-xl-5">
        <div id="header-carousel" class="carousel slide" style="width: 100%;" data-ride="carousel">
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


<!-- Featured Start -->
<div class="container-fluid pt-5">
    <div class="row px-xl-5 pb-3">
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                <h1 class="fa fa-check text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0">Quality Product</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                <h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>
                <h5 class="font-weight-semi-bold m-0">Free Shipping</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0">14-Day Return</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
            <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                <h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0">24/7 Support</h5>
            </div>
        </div>
    </div>
</div>
<!-- Featured End -->


<!-- Brand Start -->
<div class="container-fluid pt-5">
    <div class="row px-xl-5 pb-3">
        <c:forEach var="item" items="${brand.listResult}">
            <div class="col-lg-2 col-md-6 pb-1">
                <div class="cat-item d-flex flex-column border mb-4" style="padding: 20px;">

                    <a href="<c:url value='/shop/brand?id=${item.id}&page=1&limit=8'/>"
                       class="cat-img position-relative overflow-hidden mb-3">
                        <img class="img-fluid"
                             src="<c:url value='/template/web/img/brands/${item.iconUrl}'/>" alt="">
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- Categories End -->


<!-- Offer Start -->
<div class="container-fluid offer pt-5">
   <div class="row px-xl-5">
       <div class="col-md-12 pb-4">
           <div id="carousel" class="d-flex position-relative justify-content-center">
               <div class="slide-item">
                   <a href="link_to_spring_collection" class="slide-link">
                       <div class="spring-collection"></div>
                   </a>
                   <a href="link_to_another_spring_collection" class="slide-link">
                       <div class="spring-collection"></div>
                   </a>
               </div>
               <div class="slide-item">
                   <a href="link_to_winter_collection" class="slide-link">
                       <div class="winter-collection"></div>
                   </a>
                   <a href="link_to_another_winter_collection" class="slide-link">
                       <div class="winter-collection"></div>
                   </a>
               </div>
               <button class="slide-btn prev" onclick="prevSlide()">&#10094;</button>
               <button class="slide-btn next" onclick="nextSlide()">&#10095;</button>
           </div>
       </div>

   </div>


</div>
<!-- Offer End -->


<!-- Products Start -->
<div class="container-fluid pt-5 px-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Sản Phẩm Bán Nhiều</span></h2>
    </div>
    <div class="product_list d-flex justify-content-center align-items-center flex-wrap">
        <c:forEach var="item" items="${productTrendy}">
            <div class="product-card">
                <c:if test="${item.stock <= 0}">
                    <span class="try-on-label">Bán Hết</span>
                </c:if>

                <a href="<c:url value='/product-detail?id=${item.id}'/>">
                    <img src="<c:url value='/template/web/img/products/${item.imgUrl}'/>"
                         alt="Santos De Cartier Watch">
                </a>
                <div class="product-info">
                    <div class="product-name">${item.name}</div>
                    <div class="product-description">Loại máy: ${item.watchType}</div>
                    <div class="product-price">
                       <span>Giá: </span>  <span id="price" >${item.price}đ</span>
                    </div>
                     <c:if test="${item.stock <= 0}">
                       <a href="#" class="add-to-bag-btn bg-warning disabled">Thêm Vào Giỏ(đang tạm hết)</a>
                     </c:if>
                      <c:if test="${item.stock > 0}">
                           <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn bg-warning" >Thêm Vào Giỏ</a>
                      </c:if>

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


<!-- Subscribe Start -->
<div class="container-fluid bg-secondary my-5">
    <div class="row justify-content-md-center py-5 px-xl-5">
        <div class="col-md-6 col-12 py-5">
            <div class="text-center mb-2 pb-2">
                <h2 class="section-title px-5 mb-3"><span class="bg-secondary px-2">Stay Updated</span></h2>
                <p>Amet lorem at rebum amet dolores. Elitr lorem dolor sed amet diam labore at justo ipsum
                    eirmod duo labore labore.</p>
            </div>
            <form action="">
                <div class="input-group">
                    <input type="text" class="form-control border-white p-4" placeholder="Email Goes Here">
                    <div class="input-group-append">
                        <button class="btn btn-primary px-4">Subscribe</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Subscribe End -->


<!-- Products Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Hàng Mới Về</span></h2>
    </div>
    <div class="product_list d-flex justify-content-center align-items-center flex-wrap">
        <c:forEach var="item" items="${product.listResult}">
            <div class="product-card">
                <c:if test="${item.stock <= 0}">
                    <span class="try-on-label">Bán hết</span>
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
                    <c:if test="${item.stock <= 0}">
                       <a href="#" class="add-to-bag-btn bg-warning disabled">Thêm Vào Giỏ(đang tạm hết)</a>
                     </c:if>
                      <c:if test="${item.stock > 0}">
                           <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>" class="add-to-bag-btn bg-warning" >Thêm Vào Giỏ</a>
                      </c:if>
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
<script>
const images = [
    ['https://www.watchstore.vn/images/banners/compress/fc-luxury-banner_1711707751.webp', 'https://www.watchstore.vn/images/banners/compress/omega-luxury-banner_1711707171.webp'],
    ['https://www.watchstore.vn/images/banners/compress/omega-luxury-banner_1711707171.webp', 'https://www.watchstore.vn/images/banners/compress/lg-giam-34-banner_1711707950.webp'],
];

let currentIndex = 0;

function showSlides(index) {
    const slideItems = document.querySelectorAll('.slide-item');

    // Kiểm tra nếu index nằm trong phạm vi hợp lệ
    if (index >= 0 && index < images.length) {
        // Kiểm tra nếu `images[index]` tồn tại và có đủ 2 phần tử
        if (images[index] && images[index].length >= 2) {
            slideItems[0].style.backgroundImage = 'url(' + images[index][0] + ')';
            slideItems[1].style.backgroundImage = 'url(' + images[index][1] + ')';
        } else {
            console.error("Hình ảnh không đủ trong mảng images[index].");
        }
    } else {
        console.error("Index nằm ngoài phạm vi của mảng images.");
    }
}

function nextSlide() {
    currentIndex = (currentIndex + 1) % images.length;
    showSlides(currentIndex);
}

function prevSlide() {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    showSlides(currentIndex);
}

// Hàm tự động lướt slide sau mỗi 3 giây
function autoSlide() {
    nextSlide(); // Gọi hàm nextSlide để chuyển đến slide tiếp theo
}

// Khởi tạo hình ảnh ban đầu
showSlides(currentIndex);

// Thiết lập tự động lướt slide mỗi 3 giây (3000ms)
setInterval(autoSlide, 3000);

</script>

<!-- Products End -->
</body>