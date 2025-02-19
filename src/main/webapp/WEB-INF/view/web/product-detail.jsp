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
                   .owl-prev,
                   .owl-next {
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

                   .owl-prev {
                       left: 10px; /* Vị trí nút trước */
                   }

                   .owl-next {
                       right: 10px; /* Vị trí nút tiếp theo */
                   }
                    .try-on-label {
                        position: absolute;
                        top: 15px;
                        left: 15px;
                        background-color: white;
                        font-size: 14px;
                        padding: 3px 7px;
                        border-radius: 5px;
                        border: 1px solid #ddd;
                    }
                 .rating {
                            display: flex;
                            flex-direction: row-reverse;
                            font-size: 30px;
                            cursor: pointer;
                        }

                        .rating i {
                            color: #ccc;
                            transition: color 0.2s;
                        }

                        .rating i.active,
                        .rating i.hover {
                            color: #FFD700; /* Màu vàng khi chọn */
                        }
                        /* Tùy chỉnh container */
                                .custom-file-container {
                                    position: relative;
                                    display: inline-block;
                                    font-family: Arial, sans-serif;

                                }
                /* Ẩn input file gốc */
                input[type="file"] {
                    display: none;
                }

                /* Tùy chỉnh nhãn (label) cho input file */
                .upload-label {
                    display: inline-block;
                    padding: 10px 90px;
                    background-color: #E5BE52;
                    color: black;
                    font-size: 16px;

                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s ease;
                }

                /* Hiệu ứng hover */
                .upload-label:hover {
                    background-color: #C7972A;
                }

                /* Hiệu ứng focus (khi chọn bằng bàn phím) */
                .upload-label:focus {
                    outline: 2px solid #0056b3;
                    outline-offset: 2px;
                }
                /* Modal nền mờ */
                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.8);
                    justify-content: center;
                    align-items: center;
                }

                /* Nút đóng */
                .close {
                    position: absolute;
                    top: 20px;
                    right: 30px;
                    color: white;
                    font-size: 30px;
                    cursor: pointer;
                }

               /* Ảnh lớn giữ nguyên độ nét */
               .modal-content {
                   max-width: 90%;
                   max-height: 90%;
                   border-radius: 10px;
                   object-fit: contain; /* Giữ nguyên tỉ lệ ảnh */
                   image-rendering: high-quality; /* Giúp trình duyệt ưu tiên hiển thị nét */
               }
                </style>

        </head>

        <body>

            <!-- Page Header Start -->

            <!-- Page Header End -->


            <!-- Shop Detail Start -->
            <div class="container-fluid py-5">
                <div class="row px-xl-5">
                    <div class="col-lg-5 pb-5">
                        <div id="product-carousel" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner w-60 h-60">
                                <div class="carousel-item active d-flex justify-content-center align-items-center flex-wrap">
                                    <img class="w-60 h-60" style="max-height: 450px; max-width: 300px "
                                        src="<c:url value='/template/web/img/products/${model.imgUrl}'/>"
                                        alt="Image">
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7 pb-5">
                        <h3 class="font-weight-semi-bold">${model.name}</h3>
                        <div class="d-flex mb-3">

                            <div class="text-primary mr-2">
                                    <!-- Hiển thị số sao đầy -->
                                 <fmt:formatNumber value="${rating}" type="number" minFractionDigits="1" maxFractionDigits="1" />
                                    <c:forEach var="i" begin="1" end="${Math.floor(rating)}">
                                        <small class="fas fa-star"></small>
                                    </c:forEach>

                                    <!-- Hiển thị sao nửa nếu có -->
                                    <c:if test="${rating % 1 >= 0.5}">
                                        <small class="fas fa-star-half-alt"></small>
                                    </c:if>

                                    <!-- Hiển thị sao rỗng -->
                                    <c:forEach var="i" begin="1" end="${5 - Math.floor(rating) - (rating % 1 >= 0.5 ? 1 : 0)}">
                                        <small class="far fa-star"></small>
                                    </c:forEach>
                            </div>

                        </div>
                        <h3 id="price" class="font-weight-semi-bold mb-4">${model.price}</h3>
                        <p class="mb-4">Thương Hiệu: ${model.brandName} - Quốc Gia: ${model.country}</p>
                        <c:if test="${model.stock < 10 && model.stock != 0}">
                                <p class="mb-4">
                                    <span class="badge p-0" style="color: red; font-family: Arial; font-size: 18px">Chỉ Còn ${model.stock} Sản Phẩm!</span>
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
                            <form action="<c:url value='/cart/add'/>" method="get" id ="AddToCartForm">
                                <input type="hidden" name = "quantity" id="quantity-hidden" value="1">
                                  <input type="hidden" name = "productId"  value="${model.id}">
                            <button class="btn btn-primary px-3"><i class="fa fa-shopping-cart mr-1"></i> Thêm Vào Giỏ</button>
                            </form>
                                 <style>
                                     /* Button Styling */
                                     .sparkle-button {
                                         position: relative;
                                         border: 2px solid transparent;
                                         transition: 0.3s;
                                         overflow: hidden;
                                     }

                                     /* Sparkling Effect on Hover */
                                     .sparkle-button:hover {
                                         border-color: rgb(139, 116, 211);
                                         box-shadow: 0 0 10px rgba(139, 116, 211, 0.8);
                                     }

                                     .sparkle-button::before {
                                         content: "";
                                         position: absolute;
                                         top: -5px;
                                         left: -5px;
                                         width: calc(100% + 10px);
                                         height: calc(100% + 10px);
                                         border-radius: 5px;
                                         border: 2px solid rgb(139, 116, 211);
                                         opacity: 0;
                                         box-shadow: 0 0 10px rgba(139, 116, 211, 0.8);
                                         animation: sparkle 1.5s infinite linear;
                                     }

                                     /* Keyframes for Sparkling Animation */
                                     @keyframes sparkle {
                                         0% {
                                             opacity: 0.3;
                                             transform: scale(1);
                                         }
                                         50% {
                                             opacity: 0.7;
                                             transform: scale(1.1);
                                         }
                                         100% {
                                             opacity: 0.3;
                                             transform: scale(1);
                                         }
                                     }

                                     /* Show Sparkle Animation on Hover */
                                     .sparkle-button:hover::before {
                                         opacity: 1;
                                     }
                                 </style>
                                 <button class="btn px-3 ml-2 sparkle-button" onclick="scrollToBottom()" style="color: rgb(139,116,211)">
                                     <i class="fa-brands fa-slack"></i> Gợi ý của AI
                                 </button>
                                 <script>
                                     function scrollToBottom() {
                                         window.scrollTo({ top: 1150, behavior: 'smooth' });
                                     }
                                 </script>
                             </c:if>
                           <c:if test="${model.stock <= 0}">
                               <button class="btn btn-primary px-3 sold-out-btn" disabled>
                                   <i class="fa fa-shopping-cart mr-1"></i> Hết Hàng
                               </button>
                               <style>
                                   /* Button Styling */
                                   .sparkle-button {
                                       position: relative;
                                       border: 2px solid transparent;
                                       transition: 0.3s;
                                       overflow: hidden;
                                   }

                                   /* Sparkling Effect on Hover */
                                   .sparkle-button:hover {
                                       border-color: rgb(139, 116, 211);
                                       box-shadow: 0 0 10px rgba(139, 116, 211, 0.8);
                                   }

                                   .sparkle-button::before {
                                       content: "";
                                       position: absolute;
                                       top: -5px;
                                       left: -5px;
                                       width: calc(100% + 10px);
                                       height: calc(100% + 10px);
                                       border-radius: 5px;
                                       border: 2px solid rgb(139, 116, 211);
                                       opacity: 0;
                                       box-shadow: 0 0 10px rgba(139, 116, 211, 0.8);
                                       animation: sparkle 1.5s infinite linear;
                                   }

                                   /* Keyframes for Sparkling Animation */
                                   @keyframes sparkle {
                                       0% {
                                           opacity: 0.3;
                                           transform: scale(1);
                                       }
                                       50% {
                                           opacity: 0.7;
                                           transform: scale(1.1);
                                       }
                                       100% {
                                           opacity: 0.3;
                                           transform: scale(1);
                                       }
                                   }

                                   /* Show Sparkle Animation on Hover */
                                   .sparkle-button:hover::before {
                                       opacity: 1;
                                   }
                               </style>
                               <button class="btn px-3 ml-2 sparkle-button" onclick="scrollToBottom()" style="color: rgb(139,116,211)">
                                   <i class="fa-brands fa-slack"></i> Gợi ý của AI
                               </button>
                               <script>
                                   function scrollToBottom() {
                                       window.scrollTo({ top: 1150, behavior: 'smooth' });
                                   }
                               </script>
                           </c:if>
                        </div>


                        <div class="commitment-container">
                            <div class="commitment-title">CAM KẾT CỦA CHRONOLUX.COM</div>
                            <div class="commitment-list">
                                <div class="commitment-item">
                                    <i style="font-style: normal">🔒</i>
                                    <div class="commitment-text">Bảo hành máy 5 năm toàn quốc, thủ tục nhanh gọn</div>
                                </div>
                                <div class="commitment-item">
                                    <i style="font-style: normal">🔄</i>
                                    <div class="commitment-text">Không bán hàng fake, chỉ bán hàng chính hãng</div>
                                </div>
                                <div class="commitment-item">
                                    <i style="font-style: normal">📦</i>
                                    <div class="commitment-text">Sẵn hàng - quay chụp hình thực tế gửi khách xem</div>
                                </div>
                                <div class="commitment-item">
                                    <i style="font-style: normal">🚚</i>
                                    <div class="commitment-text">Freeship toàn quốc, thanh toán khi nhận hàng</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row px-xl-5">
                    <div class="col">
                        <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                            <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Thông Số</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Chính Sách Bảo Hành</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Hướng Dẫn Chọn Kích Cỡ</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-4">Đánh giá</a>
                     

                        </div>
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="tab-pane-1">
                                <h4 class="mb-3 text-center" style="font-family: Arial">Thông Tin Sản Phẩm</h4>
                                <div class="info-container d-flex justify-content-center">
                                    <div class="product-specs-container flex-grow-1">
                                        <div class="product-specs-title text-center">Thông số sản phẩm - ${model.name}</div>
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
                                </div>
                            <div class="tab-pane fade" id="tab-pane-2">
                                <h4 class="mb-3 text-center" style="font-family: Arial">Thông Tin Bảo Hành</h4>
                                <div class="warranty" style="font-family: Arial">${model.warrantyContent}</div>
                            </div>
                            <div class="tab-pane fade" id="tab-pane-3">
                                <h4 class="mb-3 text-center" style="font-family: Arial">Hướng Dẫn Tìm Size Đồng Hồ</h4>
                              <p>Sở th&iacute;ch của mỗi người l&agrave; kh&aacute;c nhau, c&oacute; người tay nhỏ nhưng lại th&iacute;ch đeo đồng hồ size to, c&oacute; người tay to nhưng lại th&iacute;ch đeo đồng hồ size nhỏ, nhưng để đeo 1 chiếc đồng hồ mang t&iacute;nh thẩm mỹ nhất th&igrave; bạn cũng n&ecirc;n tham khảo c&aacute;ch lựa size đồng hồ dưới đ&acirc;y nh&eacute;:<br />
                               <br />
                               <strong>Bước 1:</strong>&nbsp;Đo size cổ tay (chu vi cổ tay)<br />
                               &nbsp;<br />
                               &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img alt="Chọn size mặt đồng hồ phù hợp nhất với tay - Ảnh 1" src="https://i.imgur.com/Q9lydDN.png" /><br />
                               <br />
                               <strong>Bước 2:</strong>&nbsp;Tham chiếu size cổ tay của bạn để chọn size mặt đồng hồ ph&ugrave; hợp dưới đ&acirc;y<br />
                                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img alt="Chọn size mặt đồng hồ phù hợp nhất với tay - Ảnh 2" src="https://i.imgur.com/VAOlz7D.png" /></p>

                            </div>
                            <div class="tab-pane fade" id="tab-pane-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <c:choose>
                                            <c:when test="${commentList != null and fn:length(commentList) > 0}">
                                                <h4 class="mb-4">${totalComment} đánh giá cho "${model.name}"</h4>
                                                <div class="media mb-4">
                                                    <div class="media-body overflow-auto px-3 py-3" style="max-height: 500px">
                                                        <c:forEach var="item" items="${commentList}">
                                                            <div class="d-flex align-items-center mb-2 mt-3">
                                                                <c:choose>
                                                                    <c:when test="${not empty item.imgUrl}">
                                                                        <img src="<c:url value='/template/web/img/user-logos/${item.imgUrl}'/>"
                                                                             alt="Ảnh người dùng" class="rounded-circle mr-3" style="width: 45px;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="<c:url value='/template/web/img/user-logos/user.png'/>"
                                                                             alt="Ảnh mặc định" class="rounded-circle mr-3" style="width: 45px;">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <div>
                                                                    <h6 class="mb-1">${item.name} <small class="text-muted"> - ${item.createdDate}</small></h6>
                                                                    <div class="text-warning mb-2">
                                                                        <c:forEach begin="1" end="${item.rating}">
                                                                            <i class="fas fa-star"></i>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <p>${item.review}</p>
                                                            <img class="review-image mb-2" src="<c:url value='/comment/image/${item.id}'/>"
                                                                 alt="Ảnh đánh giá" onclick="openImageModal(this.src)"
                                                                 style="max-width: 150px; cursor: pointer;">
                                                            <br>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <h4>Chưa có đánh giá nào.</h4>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <h4 class="mb-4">Viết đánh giá</h4>
                                        <small>Email của bạn sẽ không được công khai. Các trường bắt buộc được đánh dấu *</small>
                                        <div class="d-flex my-3">
                                            <p class="mb-0 mr-2">Đánh giá của bạn * :</p>
                                            <div class="rating">
                                                <i class="fas fa-star" data-value="5"></i>
                                                <i class="fas fa-star" data-value="4"></i>
                                                <i class="fas fa-star" data-value="3"></i>
                                                <i class="fas fa-star" data-value="2"></i>
                                                <i class="fas fa-star" data-value="1"></i>
                                            </div>
                                        </div>
                                        <form action="<c:url value='/comment'/>" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
                                            <div class="form-group">
                                                <label for="message">Nội dung đánh giá *</label>
                                                <textarea id="message" name="review" cols="30" rows="5" class="form-control" required></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Họ và tên *</label>
                                                <input type="text" id="name" name="name" value="${user.fullName}" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="img_chosen" class="btn btn-primary px-3">Hình ảnh thực tế sản phẩm</label>
                                                <input type="file" name="img" id="img_chosen" accept="image/*" onchange="displayImg(this)" class="form-control-file">
                                                <img id="img_display" class="mt-2 d-block" style="max-width: 550px; max-height: 350px; display: none;">
                                                <span id="error-msg" class="text-danger d-none">Vui lòng chọn ảnh!</span>
                                            </div>
                                            <div class="form-group mb-0">
                                                <input type="submit" value="Gửi đánh giá" class="btn btn-primary px-3">
                                            </div>
                                            <input type="hidden" name="productId" value="${model.id}">
                                            <input type="hidden" id="ratingValue" name="rating" value="">
                                        </form>
                                    </div>
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
                    <h2 class="section-title px-5"><span class="px-2" style="font-family: Arial"> Sản Phẩm Tương Tự</span></h2>
                </div>
                <div class="row px-xl-5">
                    <div class="col">
                        <div class="owl-carousel related-carousel">
                            <c:forEach var="item" items="${productByBrands}">
                                <div class="product-card p-2 bg-white shadow mx-3 my-3 " style="border-radius: 1rem; max-width: 300px">
                                    <style>
                                        /* Button Styling */
                                        .sparkle-label {
                                            position: relative;
                                            border: 2px solid transparent;
                                            transition: 0.3s;
                                            overflow: hidden;
                                        }

                                        /* Sparkling Effect on Hover */
                                        .sparkle-label:hover {
                                            border-color: rgba(139, 116, 211, 0);
                                            box-shadow: 0 0 10px rgba(139, 116, 211, 0);
                                        }

                                        .sparkle-label::before {
                                            content: "";
                                            position: absolute;
                                            top: -5px;
                                            left: -5px;
                                            width: calc(100% + 10px);
                                            height: calc(100% + 10px);
                                            border-radius: 5px;
                                            border: 2px solid rgb(139, 116, 211);
                                            opacity: 0;
                                            box-shadow: 0 0 10px rgba(139, 116, 211, 0.8);
                                            animation: sparkle 1.5s infinite linear;
                                        }

                                        /* Keyframes for Sparkling Animation */
                                        @keyframes sparkle {
                                            0% {
                                                opacity: 0.3;
                                                transform: scale(1);
                                            }
                                            50% {
                                                opacity: 0.7;
                                                transform: scale(1.1);
                                            }
                                            100% {
                                                opacity: 0.3;
                                                transform: scale(1);
                                            }
                                        }
                                    </style>
                                    <span class="try-on-label sparkle-label" style="color: rgba(160,148,255,1);"><i class="fa-brands fa-slack" style="padding-right: 10px"></i>Gợi ý bởi AI</span>
                                    <img class="img-fluid p-5" style="width: fit-content;" src="<c:url value='/template/web/img/products/${item.imgUrl}'/>" alt="">
                                    <div class="card-body text-center p-0 pt-4 pb-3">
                                        <h6 class="text-truncate mb-3">${item.name}</h6>
                                        <div class="d-flex justify-content-center">
                                            <h6 id="price" style="color: green"><del>${item.price}</del></h6>
                                        </div>
                                    </div>
                                    <div class="button-container p-0 my-1 mx-2 d-flex ">
                                        <a href="<c:url value='/product-detail?id=${item.id}'/>"
                                           class="btn bg-dark text-light p-2 flex-grow-1" style="border-radius: 1rem">Chi Tiết</a>
                                    </div>
                                    <div class="button-container p-0 my-1 mx-2 d-flex">
                                        <c:if test="${item.stock <= 0}">
                                            <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>"
                                               class="btn btn-sm text-light p-2 flex-grow-1 disabled-link"
                                               style="border-radius: 1rem; background-color: gray;">
                                                Tạm Hết Hàng
                                            </a>
                                        </c:if>
                                        <c:if test="${item.stock > 0}">
                                            <a href="<c:url value='/cart/add?productId=${item.id}&quantity=1'/>"
                                               class="btn bg-dark text-light p-2 flex-grow-1" style="border-radius: 1rem">Thêm Vào Giỏ</a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <button class="owl-prev">❮</button>
                        <button class="owl-next">❯</button>
                    </div>
                </div>
            </div>
            <!-- Products End -->
            <script>
            function openImageModal(src) {
                let modal = document.getElementById("imageModal");
                let modalImg = document.getElementById("modalImage");

                modal.style.display = "flex"; // Hiển thị modal
                modalImg.src = src; // Gán ảnh vào modal
            }

            function closeImageModal() {
                document.getElementById("imageModal").style.display = "none";
            }
            </script>
<script>
    const stars = document.querySelectorAll(".rating i");
    const rating = document.getElementById('ratingValue')
    let selectedRating = 5;
    rating.value =  selectedRating;

        // Thiết lập sao mặc định khi tải trang
        function setDefaultRating(rating) {
            stars.forEach(star => {
                if (star.getAttribute("data-value") <= rating) {
                    star.classList.add("active");
                }
            });
        }
         setDefaultRating(selectedRating); // Gọi hàm khi trang tải
    stars.forEach(star => {
        star.addEventListener("mouseover", function () {
            let value = this.getAttribute("data-value");
            stars.forEach(s => {
                s.classList.remove("hover");
                if (s.getAttribute("data-value") <= value) {
                    s.classList.add("hover");
                }
            });
        });

        star.addEventListener("click", function () {
            selectedRating = this.getAttribute("data-value");
            stars.forEach(s => {
                s.classList.remove("active");
                if (s.getAttribute("data-value") <= selectedRating) {
                    s.classList.add("active");
                }
            });
           rating.value =  selectedRating;

            console.log("Bạn đã chọn:", rating.value);
        });

        star.addEventListener("mouseleave", function () {
            stars.forEach(s => s.classList.remove("hover"));
        });
    });
</script>
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
               $(document).ready(function() {
                   // Khởi tạo Owl Carousel
                   var owl = $('.related-carousel').owlCarousel({
                       items: 3, // Số lượng sản phẩm hiển thị
                       loop: true,
                       nav: true, // Bật nút điều hướng
                       navText: ["<div class='owl-prev'>❮</div>", "<div class='owl-next'>❯</div>"],
                       responsive: {
                           0: {
                               items: 1 // Hiển thị 1 sản phẩm khi màn hình nhỏ hơn 600px
                           },
                           600: {
                               items: 2 // Hiển thị 2 sản phẩm khi màn hình từ 600px đến 999px
                           },
                           1000: {
                               items: 3 // Hiển thị 3 sản phẩm khi màn hình lớn hơn 1000px
                           }
                       }
                   });

                   // Bổ sung sự kiện cho nút điều hướng tùy chỉnh (nếu cần)
                   $('.owl-prev').click(function() {
                       owl.trigger('prev.owl.carousel');
                   });

                   $('.owl-next').click(function() {
                       owl.trigger('next.owl.carousel');
                   });

                });

            </script>
            <script>
                document.querySelectorAll('#price').forEach(element => {
                    let price = parseInt(element.innerText.replace("đ", ""), 10);
                    element.innerText = price.toLocaleString("vi-VN") + "đ";
                });

            </script>
            <script>
                let errorMsg = document.getElementById("error-msg");
                function displayImg(fileInput) {
                    const file = fileInput.files[0];
                    const imgPreview = $('#img_display');
                    const imgChosen = $('#img_chosen');

                    if(file){
                        const reader = new FileReader();
                        reader.onload = function (e){
                            imgPreview.attr('src',e.target.result);
                            imgPreview.css('display','block');
                        }
                        reader.readAsDataURL(file);
                    }
                    else{
                        imgPreview.css('display','none');
                        errorMsg.style.display = "inline"; // Hiện thông báo lỗi
                    }
                }
                function validateForm() {
                    let fileInput = document.getElementById("img_chosen");
                    let errorMsg = document.getElementById("error-msg");

                    if (!fileInput.files.length) {
                        errorMsg.style.display = "inline"; // Hiện thông báo lỗi
                        return false; // Ngăn form submit
                    }

                    errorMsg.style.display = "none"; // Ẩn thông báo lỗi nếu đã chọn ảnh
                    return true;
                }
            </script>
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
        </body>

        </html>
