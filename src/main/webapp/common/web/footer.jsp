<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- Footer Start -->
<div class="container-fluid text-dark" style="border-top: 2px solid;border-top-color: rgb(234,189,43) ">
    <div class="row px-xl-5 pt-5">
       <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
           <a href="#" class="text-decoration-none">
               <img id="corporation-img" src="" style="margin-bottom: 10px;" alt="ChronoLux Logo">
           </a>
           <p class="info-comp text-truncate" id="corporation-about"></p>
           <p class="mb-2"><i class="fa fa-map-marker-alt mr-4" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-address"></span></p>
           <p class="mb-2"><i class="fa fa-envelope mr-3" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-email"></span></p>
           <p class="mb-0"><i class="fa fa-phone-alt mr-3" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-phone"></span></p>
       </div>
        <div class="col-lg-8 col-md-12 py-1 ">
<%--            <div class="col-lg-8 col-md-12 py-1 d-flex justify-content-center align-items-center">--%>
<%--            <img class="image-footer flex-grow-1" src="<c:url value='/template/web/img/footer2.png'/>"style="height: 80%; max-width: 0%  ;width: fit-content">--%>
            <div class="row">
                <div class="col-md-4 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">Quick Links</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-dark mb-2" href="index.html"><i class="fa fa-angle-right mr-2"></i>Home</a>
                        <a class="text-dark mb-2" href="shop.html"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                        <a class="text-dark mb-2" href="cart.html"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        <a class="text-dark" href="contact.html"><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">Quick Links</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-dark mb-2" href="index.html"><i class="fa fa-angle-right mr-2"></i>Home</a>
                        <a class="text-dark mb-2" href="shop.html"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                        <a class="text-dark mb-2" href="cart.html"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        <a class="text-dark" href="contact.html"><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row border-top border-light mx-xl-5">
        <div class="col-md-6 px-xl-0">
            <p class="mb-md-0 text-center text-md-left text-dark">
                &copy; Copyright 2010-2024 <a class="text-dark font-weight-semi-bold" href="#">ChronoLux Company S.L. </a>  All rights reserved.
            </p>
        </div>
        <div class="col-md-6 px-xl-0 text-center text-md-right">
            <img class="img-fluid" src="img/payments.png" alt="">
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>
<script>
    $(document).ready(function() {
        $.ajax({
            url: "<c:url value='/coporation'/>",
            method: 'GET',
            success: function(data) {
                // Cập nhật nội dung của các phần tử HTML với dữ liệu từ API
                $("#corporation-img").attr("src", `<c:url value='/template/web/img/corporation/'/>` + data.img);
                $("#corporation-about").text(data.about);
                $("#corporation-address").text(data.address);
                $("#corporation-email").text(data.email);
                $("#corporation-phone").text(data.phone);
                console.log("sdsdd");
            },
            error: function(xhr, status, error) {

            }
        });
    });
 </script>