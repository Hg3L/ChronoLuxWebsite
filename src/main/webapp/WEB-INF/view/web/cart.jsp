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
            <div class="container-fluid bg-secondary mb-5">
                <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                    <h1 class="font-weight-semi-bold text-uppercase mb-3">Shopping Cart</h1>
                    <div class="d-inline-flex">
                        <p class="m-0"><a href="">Home</a></p>
                        <p class="m-0 px-2">-</p>
                        <p class="m-0">Shopping Cart</p>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Cart Start -->
            <div class="container-fluid pt-5">
                <div class="row px-xl-5">
                    <div class="col-lg-8 table-responsive mb-5">
                        <c:if test="${not empty cartItems}">
                            <table class="table table-bordered text-center mb-0">
                                <thead class="bg-secondary text-dark">
                                    <tr>
                                        <th>Img</th>
                                        <th>Product </th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th>Remove</th>
                                    </tr>
                                </thead>
                                <tbody class="align-middle">
                                    <c:forEach var="item" items="${cartItems}" varStatus="status">
                                        <tr>
                                            <td class="align-middle"><img
                                                    src="<c:url value='/template/web/img/user-logos/images.png'/>"
                                                    alt="" style="width: 50px;">
                                            </td>
                                            <td class="align-middle"> ${item.productName} </td>
                                            <td class="align-middle">$${item.productPrice}</td>
                                            <td class="align-middle">
                                                <div class="input-group quantity mx-auto" style="width: 100px;">
                                                    <div class="input-group-btn">
                                                        <form action="<c:url value='/cart/update' />" method="get">
                                                            <input type="hidden" name="quantity"
                                                                value=${item.quantity-1}>
                                                            <input type="hidden" name="productId"
                                                                value=${item.productId}>

                                                            <button type="submit"
                                                                class="btn btn-sm btn-primary btn-minus"
                                                                onclick="decreaseQuantity(${status.index})"
                                                                id="DecreaseQuantityBtn">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </form>
                                                    </div>

                                                    <form action="<c:url value='/cart/update'/>" method="get">
                                                        <input type="text"
                                                            class="form-control form-control-sm bg-secondary text-center"
                                                            id="quantity-${status.index}" value="${item.quantity}"
                                                            oninput="updateHiddenQuantity(${status.index})"
                                                            style="width: 40px;">

                                                        <input type="hidden" id="hiddenQuantity-${status.index}"
                                                            name="quantity" value=${item.quantity}>
                                                        <input type="hidden" name="productId" value=${item.productId}>

                                                    </form>
                                                    <form action="<c:url value='/cart/update' />" method="get">
                                                        <input type="hidden" name="quantity" value=${item.quantity+1}>
                                                        <input type="hidden" name="productId" value=${item.productId}>
                                                        <button type="submit" class="btn btn-sm btn-primary btn-plus"
                                                            onclick="increaseQuantity(${status.index})"
                                                            id="IncreaseQuantityBtn">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                            <td class="align-middle">$${item.productPrice*item.quantity}</td>
                                            <td class="align-middle">
                                                <form action="<c:url value='/cart/del'/>" method="get">
                                                    <button class="btn btn-sm btn-primary"><i
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
                            <h3> You have not chosen any product yet </h3>
                        </c:if>
                    </div>
                    <div class="col-lg-4">
                        <c:if test="${not empty cartItems}">

                            <form class="mb-5" action="<c:url value='/cart'/>" method="get">
                                <div class="input-group">
                                    <input type="text" name="code" class="form-control p-4" placeholder="Coupon Code">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">Apply Coupon</button>
                                    </div>
                                </div>
                            </form>
                            <div class="card border-secondary mb-5">
                                <div class="card-header bg-secondary border-0">
                                    <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-3 pt-1">
                                        <h6 class="font-weight-medium">Subtotal</h6>
                                        <h6 class="font-weight-medium">$${totalPrice}</h6>
                                    </div>
                                    <c:if test="${not empty voucher}">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Discount</h6>
                                            <h6 class="font-weight-medium">$${voucher.discount}</h6>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-footer border-secondary bg-transparent">
                                    <div class="d-flex justify-content-between mt-2">
                                        <h5 class="font-weight-bold">Total</h5>
                                        <h5 class="font-weight-bold">$${(totalPrice - voucher.discount) > 0 ? (totalPrice - voucher.discount) : 0}</h5>
                                    </div>
                                   <form action="<c:url value='/checkout'/>" method="get">
                                    <button  class="btn btn-block btn-primary my-3 py-3">Proceed To Checkout</button>
                                    <input type="hidden" name = "subtotal" value = "${totalPrice}">
                                    <c:if test="${not empty voucher}">
                                    <input type="hidden" name = "voucherCode" value = "${voucher.code}">
                                     </c:if>
                                      <input type="hidden" name = "total" value = "${(totalPrice - voucher.discount) > 0 ? (totalPrice - voucher.discount) : 0}">
                                   </form>
                                </div>
                            </div>

                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Cart End -->
            <script>
                function increaseQuantity(index) {

                    let quantityInputs = document.querySelectorAll("[id^='quantity-']");


                    let quantityInput = quantityInputs[index];




                    let currentQuantity = parseInt(quantityInput.value) || 0;

                    currentQuantity += 1;


                    quantityInput.value = currentQuantity;

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
                    let hiddenQuantityInput = document.getElementById("hiddenQuantity-" + index);

                    if (quantityInput && hiddenQuantityInput) {

                        hiddenQuantityInput.value = quantityInput.value;
                    }
                }
            </script>
        </body>

        </html>