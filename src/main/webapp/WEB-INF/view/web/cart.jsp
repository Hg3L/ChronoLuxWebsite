<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Cart</title>
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
        </head>

        <body>

            <!-- Page Header Start -->
            <div class="container-fluid">
                <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 150px">
                    <h1 class="font-weight-semi-bold text-uppercase mb-3">Giỏ Hàng Của Bạn</h1>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Cart Start -->
            <div class="container-fluid pt-5">
                <div class="row px-xl-5">
                    <div class="col-lg-8 table-responsive mb-5">
                        <c:if test="${not empty cartItems}">
                            <table class="table table-bordered text-center mb-0">
                                <thead class="bg-dark text-light">
                                    <tr style="font-family: Arial">
                                        <th>Hình Ảnh</th>
                                        <th>Tên Sản Phẩm </th>
                                        <th>Giá Trị</th>
                                        <th>Số Lượng</th>
                                        <th>Tổng</th>
                                        <th>Loại Bỏ</th>
                                    </tr>
                                </thead>
                                <tbody class="align-middle">
                                    <c:forEach var="item" items="${cartItems}" varStatus="status">
                                        <tr>
                                            <td class="align-middle"><img
                                                    src="<c:url value='/template/web/img/products/${item.productImgUrl}'/>"
                                                    alt="" style="width: 50px;">
                                            </td>
                                            <td class="align-middle"> ${item.productName} </td>
                                            <td id = "price" class="align-middle">${item.productPrice}</td>
                                            <td class="align-middle">
                                                <div class="input-group quantity mx-auto" style="width: 100px;">
                                                    <div class="input-group-btn">
                                                        <form action="<c:url value='/cart/update'/>" method="get">
                                                            <input type="hidden" name="quantity" value=${item.quantity-1}>
                                                            <input type="hidden" name="productId" value=${item.productId}>

                                                            <button type="submit"
                                                                class="btn btn-sm btn-dark btn-minus"
                                                                onclick="decreaseQuantity(${status.index})"
                                                                id="DecreaseQuantityBtn">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </form>
                                                    </div>

                                                    <form action="<c:url value='/cart/update'/>" method="get">
                                                        <input type="text"
                                                               class="form-control form-control-sm bg-light text-center"
                                                               id="quantity-${status.index}" value="${item.quantity}"
                                                               onchange="updateHiddenQuantity(${status.index})"
                                                               style="width: 40px;border-bottom: black; border-top: black">
                                                        <input type = "hidden" id = "instock-${status.index}" value = "${item.productQuantity}" >

                                                        <input type="hidden" id="hiddenQuantity-${status.index}"
                                                            name="quantity" value=${item.quantity}>
                                                        <input type="hidden" name="productId" value=${item.productId}>

                                                    </form>
                                                    <form action="<c:url value='/cart/update'/>" method="get">
                                                     <c:if test="${item.quantity < item.productQuantity}">
                                                        <input type="hidden" name="quantity" value=${item.quantity+1}>
                                                      </c:if>
                                                        <c:if test="${item.quantity >= item.productQuantity}">
                                                         <input type="hidden" name="quantity" value=${item.quantity}>
                                                         <input type="hidden" id = "validQuantity-${status.index}" value="true">
                                                        </c:if>
                                                        <input type="hidden" name="productId" value=${item.productId}>

                                                        <button type="submit" class="btn btn-sm btn-dark btn-plus"
                                                            onclick="increaseQuantity(${status.index})"
                                                            id="IncreaseQuantityBtn">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                            <td id ="price" class="align-middle">${item.productPrice*item.quantity}</td>
                                            <td class="align-middle">
                                                <form action="<c:url value='/cart/del'/>" method="get">
                                                    <button class="btn btn-sm btn-dark"><i
                                                            class="fa fa-times"></i></button>
                                                    <input type="hidden" name="productId" value=${item.productId}>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty cartItems}">
                            <h3 style="font-family: Arial"> Giỏ hàng hiện tại của bạn chưa có sản phẩm. </h3>
                            Hiện không có sản phẩm nào được lưu. Bạn cần tư vấn có thể liên hệ qua Holine 093 189 2222 hoặc Zalo. <br> ChronoLux sẽ luôn sãn sàng hỗ trợ bạn!
                        </c:if>
                    </div>
                    <div class="col-lg-4">
                        <c:if test="${not empty cartItems}">

                            <form class="mb-5" action="<c:url value='/cart'/>" method="get">
                                <div class="input-group">
                                    <input type="text" name="code" class="form-control p-4" style="border-color: black" placeholder="Mã Giảm Giá">
                                    <div class="input-group-append">
                                        <button class="btn btn-dark">Kiểm Tra</button>
                                    </div>
                                    <div id="coupon-error" class="text-danger mt-2" >
                                            ${InvalidVoucher}
                                    </div>
                                </div>
                            </form>
                            <div class="card border-dark mb-5">
                                <div class="card-header bg-dark border-0">
                                    <h4 class="font-weight-semi-bold m-0" style="color: whitesmoke">Thông Tin Giỏ Hàng</h4>
                                </div>
                                <div class="card-body border-dark">
                                    <div class="d-flex justify-content-between mb-3 pt-1">
                                        <h6 class="font-weight-medium" style="font-family: Arial"> Tổng Giá Trị</h6>
                                        <h6 id = "price" class="font-weight-medium">${totalPrice}</h6>
                                    </div>
                                    <c:if test="${not empty voucher}">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium" style="font-family: Arial">Giảm Giá</h6>
                                            <h6 id = "price" class="font-weight-medium">-${voucher.discount}</h6>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-footer border-dark bg-transparent">
                                    <div class="d-flex justify-content-between mt-2">
                                        <h5 class="font-weight-bold" style="font-family: Arial">Thành Tiền</h5>
                                        <h5 id = "price" class="font-weight-bold" style="color: green">${(totalPrice - voucher.discount) > 0 ? (totalPrice - voucher.discount) : 0}</h5>
                                    </div>
                                   <form action="<c:url value='/checkout'/>" method="get">
                                    <button  class="btn btn-block btn-dark my-3 py-3">Tiến Hành Thanh Toán</button>
                                    <input  type="hidden" name = "subtotal" value = "${totalPrice}">
                                    <c:if test="${not empty voucher}">
                                    <input type="hidden" name = "voucherCode" value = "${voucher.code}">
                                     </c:if>
                                      <input type="hidden" name = "total" value = "${(totalPrice - voucher.discount) > 0 ? (totalPrice - voucher.discount) : 0}">
                                   </form>
                                </div>
                            </div>
                            <input type="hidden" id="cartItems" value='${fn:escapeXml(cartItemsJson)}'>
                            <c:if test = "${not empty error}">
                            <input type= "hidden" id = "error" value ="${error}">;
                             </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Cart End -->
            <script>

                function increaseQuantity(index) {

                    let quantityInputs = document.querySelectorAll("[id^='quantity-']");
                    let validQuantity =  document.getElementById("validQuantity-" + index);

                    let quantityInput = quantityInputs[index];

                    if(validQuantity.value === "true"){
                          alert("Bạn đã nhập quá số lượng hàng trong kho, vui lòng nhập lại.");

                    }
                    else{
                     let currentQuantity = parseInt(quantityInput.value) || 0;

                     currentQuantity += 1;


                     quantityInput.value = currentQuantity;
                    }



                }
                function decreaseQuantity(index) {
                    let quantityInputs = document.querySelectorAll("[id^='quantity-']");
                    let quantityInput = quantityInputs[index];

                    let currentQuantity = parseInt(quantityInput.value);


                    if (currentQuantity > 1) {
                        currentQuantity -= 1;

                        quantityInput.value = currentQuantity;

                    } else {
                        quantityInput.value = 1;
                    }
                }
                function updateHiddenQuantity(index) {

                    let quantityInput = document.getElementById("quantity-" + index);
                    let instock = document.getElementById("instock-" + index);
                    let hiddenQuantityInput = document.getElementById("hiddenQuantity-" + index);


                    if (quantityInput && hiddenQuantityInput) {

                        let instockValue = parseInt(instock.value, 10);
                        let quantityValue = parseInt(quantityInput.value, 10);

                        if (instockValue < quantityValue) {
                            alert("Bạn đã nhập quá số lượng hàng trong kho, vui lòng nhập lại.");
                            quantityInput.value = hiddenQuantityInput.value;
                        } else {
                            hiddenQuantityInput.value = quantityInput.value;
                        }
                    }
                }


            </script>
            <script>
                    document.querySelectorAll('#price').forEach(element => {
                            let price = parseInt(element.innerText.replace("đ", ""), 10);
                            element.innerText = price.toLocaleString("vi-VN") + "đ";
                        });

            </script>
        </body>

        </html>