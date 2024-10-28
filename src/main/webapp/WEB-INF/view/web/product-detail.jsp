<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Product Detail</title>
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
                    .commitment-container {
                        background-color: #fff;
                        color: #000;
                        padding: 20px;
                        border-radius: 5px;
                        max-width: 600px;
                        border: 1px solid #ccc;
                        text-align: center;
                    }

                    .commitment-title {
                        font-weight: bold;
                        margin-bottom: 15px;
                        font-size: 18px;
                    }
                    .commitment-list {
                        display: flex;
                        flex-wrap: wrap;
                        justify-content: space-between;
                    }

                    .commitment-item {
                        width: 48%;
                        margin-bottom: 15px;
                        display: flex;
                        align-items: center;
                    }

                    .commitment-item i {
                        font-size: 24px;
                        margin-right: 10px;

                        color: #ffd700;
                        /* Màu vàng cho biểu tượng */
                    
                    }

                    .commitment-text {
                        font-size: 14px;
                        line-height: 1.5;
                        text-align: left;
                    }

                    .product-specs-container {
                        max-width: 1400px;

                        font-family: Arial, sans-serif;
                        color: #333;
                    }

                    .product-specs-title {
                        font-size: 18px;
                        font-weight: bold;
                        margin-bottom: 15px;
                    }

                    .specs-table {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 10px;
                    }

                    .specs-column {
                        flex: 1;
                        min-width: 45%;
                        /* Đảm bảo các cột có kích thước tối thiểu để chia đều */
                    }

                    .specs-row {
                        display: flex;
                        justify-content: space-between;
                        padding: 10px;
                        background-color: #f5f5f5;
                        border-bottom: 1px solid #ddd;
                    }

                    .specs-row:nth-child(even) {
                        background-color: #fff;
                    }

                    .specs-label {
                        font-weight: bold;
                        color: #555;
                    }

                    .specs-value a {
                        text-decoration: none;
                        color: #007bff;
                        /* Màu xanh dương cho link */
                    }
                    .sold-out-btn {
                            background-color: #cccccc; /* Màu xám nhạt hơn để thể hiện trạng thái không khả dụng */
                            border-color: #cccccc;
                            color: #666666; /* Màu chữ xám để làm rõ trạng thái "SOLD OUT" */
                        }
                </style>
        </head>

        <body>

            <!-- Page Header Start -->
            <div class="container-fluid bg-secondary mb-5">
                <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                    <h1 class="font-weight-semi-bold text-uppercase mb-3">Shop Detail</h1>
                    <div class="d-inline-flex">
                        <p class="m-0"><a href="">Home</a></p>
                        <p class="m-0 px-2">-</p>
                        <p class="m-0">Shop Detail</p>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Shop Detail Start -->
            <div class="container-fluid py-5">
                <div class="row px-xl-5">
                    <div class="col-lg-5 pb-5">
                        <div id="product-carousel" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner border">
                                <div class="carousel-item active">
                                    <img class="w-100 h-100"
                                        src="https://www.watchstore.vn/images/products/2024/08/27/large/t120-410-22-051-00-1_1724748279.webp"
                                        alt="Image">
                                </div>
                                <div class="carousel-item">
                                    <img class="w-100 h-100" src="img/product-2.jpg" alt="Image">
                                </div>
                                <div class="carousel-item">
                                    <img class="w-100 h-100" src="img/product-3.jpg" alt="Image">
                                </div>
                                <div class="carousel-item">
                                    <img class="w-100 h-100" src="img/product-4.jpg" alt="Image">
                                </div>
                            </div>
                            <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                                <i class="fa fa-2x fa-angle-left text-dark"></i>
                            </a>
                            <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                                <i class="fa fa-2x fa-angle-right text-dark"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-7 pb-5">
                        <h3 class="font-weight-semi-bold">${model.name}</h3>
                        <div class="d-flex mb-3">
                            <div class="text-primary mr-2">
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star-half-alt"></small>
                                <small class="far fa-star"></small>
                            </div>
                            <small class="pt-1">(50 Reviews)</small>
                        </div>
                        <h3 class="font-weight-semi-bold mb-4">$${model.price}</h3>
                        <p class="mb-4">Brand: ${model.brandName} - Country: ${model.country}</p>
                        <c:if test="${model.stock < 10}">
                                <p class="mb-4">
                                    <span class="badge badge-danger">InStock:</span>
                                    <span class="ml-2 font-weight-bold text-danger">${model.stock}</span>
                                </p>
                         </c:if>
                        <div class="d-flex align-items-center mb-4 pt-2">

                            <div class="input-group quantity mr-3" style="width: 130px;">
                                <div class="input-group-btn">
                                    <button onclick="decreaseQuantity()" id="DecreaseQuantityBtn"
                                        class="btn btn-primary btn-minus">
                                        <i class="fa fa-minus"></i>
                                    </button>
                                </div>
                                <input type="text" onchange="handleQuantityChange()" name = "quantity" id="quantity" class="form-control bg-secondary text-center"
                                    value="1" >
                                <div class="input-group-btn">
                                    <button onclick="increaseQuantity()" id="IncreaseQuantityBtn"
                                        class="btn btn-primary btn-plus">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                    <input type="hidden" id="inStock" value="${model.stock}" />
                                </div>
                            </div>
                             <c:if test="${model.stock > 0}">
                            <form action="<c:url value='/cart?productId=${model.id}'/>" method="post" id ="AddToCartForm">
                                <input type="hidden" name = "quantity" id="quantity-hidden" value="1">
                            <button class="btn btn-primary px-3"><i class="fa fa-shopping-cart mr-1"></i> Add To
                                Cart</button>
                            </form>
                             </c:if>
                           <c:if test="${model.stock <= 0}">
                               <button class="btn btn-primary px-3 sold-out-btn" disabled>
                                   <i class="fa fa-shopping-cart mr-1"></i> SOLD OUT
                               </button>
                           </c:if>
                        </div>
                        <div class="d-flex pt-2">
                            <p class="text-dark font-weight-medium mb-0 mr-2">Share on:</p>
                            <div class="d-inline-flex">
                                <a class="text-dark px-2" href="">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a class="text-dark px-2" href="">
                                    <i class="fab fa-twitter"></i>
                                </a>
                                <a class="text-dark px-2" href="">
                                    <i class="fab fa-linkedin-in"></i>
                                </a>
                                <a class="text-dark px-2" href="">
                                    <i class="fab fa-pinterest"></i>
                                </a>
                            </div>
                        </div>

                        <div class="commitment-container">
                            <div class="commitment-title">CAM KẾT CỦA CHRONOLUX.COM</div>
                            <div class="commitment-list">
                                <div class="commitment-item">
                                    <i>🔒</i>
                                    <div class="commitment-text">Bảo hành máy 5 năm toàn quốc, thủ tục nhanh gọn</div>
                                </div>
                                <div class="commitment-item">
                                    <i>🔄</i>
                                    <div class="commitment-text">Không bán hàng fake, chỉ bán hàng chính hãng</div>
                                </div>
                                <div class="commitment-item">
                                    <i>📦</i>
                                    <div class="commitment-text">Sẵn hàng - quay chụp hình thực tế gửi khách xem</div>
                                </div>
                                <div class="commitment-item">
                                    <i>🚚</i>
                                    <div class="commitment-text">Freeship toàn quốc, thanh toán khi nhận hàng</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row px-xl-5">
                    <div class="col">
                        <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                            <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Description</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Warranty Policy</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Size Selection Guide</a>
                     
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-4">Reviews (0)</a>
                        </div>
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="tab-pane-1">
                                <h4 class="mb-3">Product Description</h4>

                                <div class="product-specs-container">
                                    <div class="product-specs-title">Thông số sản phẩm - ${model.name}</div>
                                    <div class="specs-table">
                                        <div class="specs-column">
                                            <div class="specs-row">
                                                <div class="specs-label">Thương hiệu:</div>
                                                <div class="specs-value"><a href="#">${model.brandName}</a></div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Xuất xứ:</div>
                                                <div class="specs-value">${model.country}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Đối tượng:</div>
                                                <div class="specs-value"><a href="#">${model.gender}</a></div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Dòng sản phẩm:</div>
                                                <div class="specs-value">${model.productLineName}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Kháng nước:</div>
                                                <div class="specs-value">${model.waterResistant}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Loại máy:</div>
                                                <div class="specs-value">${model.watchType}</div>
                                            </div>
                                        </div>
                                        <div class="specs-column">
                                            <div class="specs-row">
                                                <div class="specs-label">Chất liệu kính:</div>
                                                <div class="specs-value">${model.glassMaterial}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Chất liệu dây:</div>
                                                <div class="specs-value">${model.strapMaterial}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Size mặt:</div>
                                                <div class="specs-value">${model.faceSize}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Độ dày:</div>
                                                <div class="specs-value">${model.thickness}</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Khoảng trữ cót:</div>
                                                <div class="specs-value">80 tiếng</div>
                                            </div>
                                            <div class="specs-row">
                                                <div class="specs-label">Tiện ích:</div>
                                                <div class="specs-value">Dạ quang, Lịch ngày, Giờ, phút, giây</div>
                                            </div>
                                        </div>
                                    </div>
                                   </div>
                                  </div>
                            <div class="tab-pane fade" id="tab-pane-2">
                           ${model.warrantyContent}
                            </div>
                            <div class="tab-pane fade" id="tab-pane-2">
                                ${model.warrantyContent}
                            </div>
                            <div class="tab-pane fade" id="tab-pane-3">

                                <h4 class="mb-4">1 review for "Colorful Stylish Shirt"</h4>

                            </div>
                            <div class="tab-pane fade" id="tab-pane-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h4 class="mb-4">1 review for "Colorful Stylish Shirt"</h4>
                                        <div class="media mb-4">
                                            <img src="img/user.jpg" alt="Image" class="img-fluid mr-3 mt-1"
                                                style="width: 45px;">
                                            <div class="media-body">
                                                <h6>John Doe<small> - <i>01 Jan 2045</i></small></h6>
                                                <div class="text-primary mb-2">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <i class="far fa-star"></i>
                                                </div>
                                                <p>Diam amet duo labore stet elitr ea clita ipsum, tempor labore accusam
                                                    ipsum et no at. Kasd diam tempor rebum magna dolores sed sed eirmod
                                                    ipsum.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h4 class="mb-4">Leave a review</h4>
                                        <small>Your email address will not be published. Required fields are marked
                                            *</small>
                                        <div class="d-flex my-3">
                                            <p class="mb-0 mr-2">Your Rating * :</p>
                                            <div class="text-primary">
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                            </div>
                                        </div>
                                        <form>
                                            <div class="form-group">
                                                <label for="message">Your Review *</label>
                                                <textarea id="message" cols="30" rows="5"
                                                    class="form-control"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Your Name *</label>
                                                <input type="text" class="form-control" id="name">
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Your Email *</label>
                                                <input type="email" class="form-control" id="email">
                                            </div>
                                            <div class="form-group mb-0">
                                                <input type="submit" value="Leave Your Review"
                                                    class="btn btn-primary px-3">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Shop Detail End -->


            <!-- Products Start -->
            <div class="container-fluid py-5">
                <div class="text-center mb-4">
                    <h2 class="section-title px-5"><span class="px-2">You May Also Like</span></h2>
                </div>
                <div class="row px-xl-5">
                    <div class="col">
                        <div class="owl-carousel related-carousel">

                            <div class="card product-item border-0">
                                <div
                                    class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                    <img class="img-fluid w-100" src="img/product-2.jpg" alt="">
                                </div>
                                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                    <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                                    <div class="d-flex justify-content-center">
                                        <h6>$123.00</h6>
                                        <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                                    </div>
                                </div>
                                <div class="card-footer d-flex justify-content-between bg-light border">
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                                </div>
                            </div>
                            <div class="card product-item border-0">
                                <div
                                    class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                    <img class="img-fluid w-100" src="img/product-3.jpg" alt="">
                                </div>
                                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                    <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                                    <div class="d-flex justify-content-center">
                                        <h6>$123.00</h6>
                                        <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                                    </div>
                                </div>
                                <div class="card-footer d-flex justify-content-between bg-light border">
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                                </div>
                            </div>
                            <div class="card product-item border-0">
                                <div
                                    class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                    <img class="img-fluid w-100" src="img/product-4.jpg" alt="">
                                </div>
                                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                    <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                                    <div class="d-flex justify-content-center">
                                        <h6>$123.00</h6>
                                        <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                                    </div>
                                </div>
                                <div class="card-footer d-flex justify-content-between bg-light border">
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                                </div>
                            </div>
                            <div class="card product-item border-0">
                                <div
                                    class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                    <img class="img-fluid w-100" src="img/product-5.jpg" alt="">
                                </div>
                                <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                    <h6 class="text-truncate mb-3">Colorful Stylish Shirt</h6>
                                    <div class="d-flex justify-content-center">
                                        <h6>$123.00</h6>
                                        <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                                    </div>
                                </div>
                                <div class="card-footer d-flex justify-content-between bg-light border">
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                                    <a href="" class="btn btn-sm text-dark p-0"><i
                                            class="fas fa-shopping-cart text-primary mr-1"></i>Add To Cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Products End -->
        <script>
                 const quantityInput = document.getElementById('quantity');
                    const quantityHiddenInput = document.getElementById('quantity-hidden');

                    // Hàm cập nhật giá trị vào input ẩn
                    function updateHiddenQuantity() {
                        quantityHiddenInput.value = quantityInput.value;
                    }

                    // Gán sự kiện input cho trường quantity
                    quantityInput.addEventListener('input', updateHiddenQuantity);
                function increaseQuantity() {
                    let instockHidden = document.getElementById("inStock");
                    let instock =  parseInt(instockHidden.value);
                    let quantityInput = document.getElementById("quantity");
                    let currentQuantity = parseInt(quantityInput.value);
                    if(instock > currentQuantity    ){
                        currentQuantity += 1;
                        quantityInput.value = currentQuantity;
                    }
                    if(instock === currentQuantity){
                     document.getElementById("IncreaseQuantityBtn").disabled = true;
                    }


                    quantityHiddenInput.value = currentQuantity;
                }
                function decreaseQuantity() {

                    let quantityInput = document.getElementById("quantity");
                    let currentQuantity = parseInt(quantityInput.value);


                    if (currentQuantity > 1) {
                        currentQuantity -= 1;

                        quantityInput.value = currentQuantity;
                        quantityHiddenInput.value = currentQuantity;

                    } else {
                        quantityInput.value = 1;
                        quantityHiddenInput.value = currentQuantity;
                    }
                     document.getElementById("IncreaseQuantityBtn").disabled = false;
                }
                function handleQuantityChange() {
                    let quantityInput = document.getElementById("quantity");
                    let currentQuantity = parseInt(quantityInput.value);
                    let instockHidden = document.getElementById("inStock");
                    let instock =  parseInt(instockHidden.value);
                    // Kiểm tra giá trị nhập vào có phải là số hợp lệ không
                    if (!isNaN(currentQuantity) && currentQuantity > 0) {
                        // Nếu hợp lệ, cập nhật giá trị của input
                        quantityInput.value = currentQuantity;
                    } else {
                        // Nếu không hợp lệ, đặt lại giá trị mặc định là 1
                        quantityInput.value = 1;
                        alert("Vui lòng nhập một số hợp lệ lớn hơn 0.");
                        quantityHiddenInput.value = 1;
                    }
                    if(currentQuantity > instock){
                         alert(" Vui lòng nhập số lượng nhỏ hơn số hàng hóa trong kho");
                         quantityInput.value = 1;
                         quantityHiddenInput.value = 1;
                    }


                }
            </script>
        </body>

        </html>