<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Checkout</title>
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

            <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
            <%----------------------------%>
                <style>
                    .cart-item {
                        display: flex;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        margin-bottom: 15px;
                        padding: 10px;
                        align-items: center;
                    }

                    .cart-item-content {
                        display: flex;
                        align-items: center;
                        width: 100%;
                    }

                    .remove-btn {
                        background: none;
                        border: none;
                        font-size: 18px;
                        cursor: pointer;
                        color: #999;
                        margin-right: 10px;
                    }

                    .product-image {
                        width: 60px;
                        height: 60px;
                        border-radius: 8px;
                        margin-right: 15px;
                    }

                    .product-details {
                        flex: 1;
                    }

                    .product-name {
                        font-weight: bold;
                    }

                    .product-price {
                        color: red;
                    }

                    .current-price {
                        font-size: 18px;
                        font-weight: bold;
                        color: red;
                        margin-right: 10px;
                    }

                    .old-price {
                        font-size: 14px;
                        text-decoration: line-through;
                        color: #999;
                    }

                    .quantity-control {
                        display: flex;
                        align-items: center;
                    }

                    .decrease-btn,
                    .increase-btn {
                        background-color: #f0f0f0;
                        border: none;
                        width: 30px;
                        height: 30px;
                        font-size: 18px;
                        cursor: pointer;
                    }

                    .quantity-input {
                        width: 40px;
                        text-align: center;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        margin: 0 5px;
                    }

                    .form-group {
                        display: flex;
                        gap: 15px;
                        margin-bottom: 15px;
                        flex-wrap: wrap;
                    }

                    .form-control {
                        flex: 1;
                        min-width: 200px;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        height: 45px;
                    }

                    select.form-control {
                        cursor: pointer;
                    }
                </style>
        </head>

        <body>
            <!-- Page Header Start -->
            <div class="container-fluid bg-secondary mb-5">
                <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                    <h1 class="font-weight-semi-bold text-uppercase mb-3">Checkout</h1>
                    <div class="d-inline-flex">
                        <p class="m-0"><a href="">Home</a></p>
                        <p class="m-0 px-2">-</p>
                        <p class="m-0">Checkout</p>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Checkout Start -->
            <div class="container-fluid pt-5">
                <div class="row px-xl-5">
                    <div class="col-lg-7">
                        <div class="mb-4">
                            <h4 class="font-weight-semi-bold mb-4">Billing Address</h4>
                            <!-- HTML -->
                            <form class="order-form p-4 border rounded">
                                <div class="mb-3">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" id="male" value="Anh"
                                            checked>
                                        <label class="form-check-label" for="male">Anh</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" id="female"
                                            value="Chị">
                                        <label class="form-check-label" for="female">Chị</label>
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" placeholder="Họ và Tên">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" placeholder="Số điện thoại">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="Email">
                                </div>

                                <p class="small text-muted mb-3">
                                    Nếu bạn không có Email, vui lòng nhắn tin
                                    <a href="https://www.messenger.com" target="_blank"><b>Messenger</b></a>
                                    hoặc
                                    <a href="https://zalo.me" target="_blank"><b>Chat Zalo</b></a>
                                    để đặt hàng
                                </p>

                                <div class="form-group">
                                    <select class="form-control" id="city">
                                        <option>Chọn Thành Phố</option>
                                        <!-- Thêm các tỉnh/thành khác tại đây -->
                                    </select>
                                    <select class="form-control" id="district">
                                        <option>Chọn Quận huyện</option>
                                        <!-- Thêm các quận/huyện khác tại đây -->
                                    </select>
                                    <select class="form-control" id="ward">
                                        <option>Phường/Xã</option>
                                        <!-- Thêm các phường/xã khác tại đây -->
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Số nhà, tên đường...">
                                </div>

                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Ghi chú thêm (nếu có)...">
                                </div>

                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="otherReceiver"
                                        onchange="toggleReceiverInfo()">
                                    <label class="form-check-label" for="otherReceiver">
                                        Gọi người khác nhận hàng (nếu có)
                                    </label>
                                </div>

                                <div id="receiverInfo" class="mb-3" style="display: none;">
                                    <div class="mb-3">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="receiverGender"
                                                id="maleReceiver" value="Anh" checked>
                                            <label class="form-check-label" for="maleReceiver">Anh</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="receiverGender"
                                                id="femaleReceiver" value="Chị">
                                            <label class="form-check-label" for="femaleReceiver">Chị</label>
                                        </div>
                                    </div>

                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <input type="text" class="form-control" placeholder="Họ và Tên người nhận">
                                        </div>
                                        <div class="col-md-6">
                                            <input type="text" class="form-control"
                                                placeholder="Số điện thoại người nhận">
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                        <div class="collapse mb-4" id="shipping-address">
                            <h4 class="font-weight-semi-bold mb-4">Shipping Address</h4>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>First Name</label>
                                    <input class="form-control" type="text" placeholder="John">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Last Name</label>
                                    <input class="form-control" type="text" placeholder="Doe">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>E-mail</label>
                                    <input class="form-control" type="text" placeholder="example@email.com">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Mobile No</label>
                                    <input class="form-control" type="text" placeholder="+123 456 789">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Address Line 1</label>
                                    <input class="form-control" type="text" placeholder="123 Street">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Address Line 2</label>
                                    <input class="form-control" type="text" placeholder="123 Street">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Country</label>
                                    <select class="custom-select">
                                        <option selected>United States</option>
                                        <option>Afghanistan</option>
                                        <option>Albania</option>
                                        <option>Algeria</option>
                                    </select>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>City</label>
                                    <input class="form-control" type="text" placeholder="New York">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>State</label>
                                    <input class="form-control" type="text" placeholder="New York">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>ZIP Code</label>
                                    <input class="form-control" type="text" placeholder="123">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="card border-secondary mb-5">
                            <div class="card-header bg-secondary border-0">
                                <h4 class="font-weight-semi-bold m-0">Order Total</h4>
                            </div>
                            <div class="card-body">
                                <h5 class="font-weight-medium mb-3">Products</h5>
                                <c:forEach var="item" items="${cartItems}" varStatus="status">
                                    <div class="cart-item">
                                        <div class="cart-item-content">
                                            <button class="remove-btn">×</button>
                                            <img src="https://www.watchstore.vn/images/products/2024/06/14/small/mtp-vt01l-1budf_1718332985.webp"
                                                alt="Product Image" class="product-image">
                                            <div class="product-details">
                                                <p class="product-name">${item.productName}</p>
                                                <p class="product-price">
                                                    <span class="current-price">$${item.productPrice}</span>
                                                    <span class="old-price">1.182.000₫</span>
                                                </p>
                                            </div>
                                            <div class="quantity-control">
                                                <label class="quantity-label">x ${item.quantity}</label>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <hr class="mt-0">
                                <div class="d-flex justify-content-between mb-3 pt-1">
                                    <h6 class="font-weight-medium">Subtotal</h6>
                                    <h6 class="font-weight-medium">$${subtotal}</h6>

                                </div>
                                <c:if test="${not empty discount}">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="font-weight-medium">Discount</h6>
                                        <h6 class="font-weight-medium">$${discount}</h6>
                                    </div>
                                </c:if>
                            </div>
                            <div class="card-footer border-secondary bg-transparent">
                                <div class="d-flex justify-content-between mt-2">
                                    <h5 class="font-weight-bold">Total</h5>
                                    <h5 class="font-weight-bold">$${total}</h5>

                                </div>
                            </div>
                        </div>
                        <form action = "<c:url value='/authorize_payment'/>" method = "post">
                            <input type="hidden" name="subtotal" value="${subtotal}">
                            <input type="hidden" name="total" value="${total}">
                              <input type="hidden" name="quantity" value="1">
                            <div class="card border-secondary mb-5">
                                <div class="card-header bg-secondary border-0">
                                    <h4 class="font-weight-semi-bold m-0">Payment</h4>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" class="custom-control-input" name="payment" id="paypal">
                                            <label class="custom-control-label" for="paypal">Paypal</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" class="custom-control-input" name="payment"
                                                id="directcheck">
                                            <label class="custom-control-label" for="directcheck">Direct Check</label>
                                        </div>
                                    </div>
                                    <div class="">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" class="custom-control-input" name="payment"
                                                id="banktransfer">
                                            <label class="custom-control-label" for="banktransfer">Bank Transfer</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer border-secondary bg-transparent">
                                    <button class="btn btn-lg btn-block btn-primary font-weight-bold my-3 py-3">Place
                                        Order</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Checkout End -->
            <script>
                var citis = document.getElementById("city");
                var districts = document.getElementById("district");
                var wards = document.getElementById("ward");
                var Parameter = {
                    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                    method: "GET",
                    responseType: "application/json",
                };
                var promise = axios(Parameter);
                promise.then(function (result) {
                    renderCity(result.data);
                });

                function renderCity(data) {
                    for (const x of data) {
                        citis.options[citis.options.length] = new Option(x.Name, x.Id);
                    }
                    citis.onchange = function () {
                        district.length = 1;
                        ward.length = 1;
                        if (this.value != "") {
                            const result = data.filter(n => n.Id === this.value);

                            for (const k of result[0].Districts) {
                                district.options[district.options.length] = new Option(k.Name, k.Id);
                            }
                        }
                    };
                    district.onchange = function () {
                        ward.length = 1;
                        const dataCity = data.filter((n) => n.Id === citis.value);
                        if (this.value != "") {
                            const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

                            for (const w of dataWards) {
                                wards.options[wards.options.length] = new Option(w.Name, w.Id);
                            }
                        }
                    };
                }
                function toggleReceiverInfo() {
                    var receiverInfo = document.getElementById("receiverInfo");
                    var checkbox = document.getElementById("otherReceiver");
                    if (checkbox.checked) {
                        receiverInfo.style.display = "block";
                    } else {
                        receiverInfo.style.display = "none";
                    }
                }
            </script>
        </body>

        </html>