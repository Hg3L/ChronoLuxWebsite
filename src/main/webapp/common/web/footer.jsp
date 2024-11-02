<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- Footer Start -->
<div class="container-fluid text-dark" style="border-top: 2px solid;border-top-color: rgb(234,189,43) ">
    <div class="row px-xl-5 pt-3">
       <div class="col-lg-4 col-md-12 pr-3 pr-xl-5v d-flex justify-content-center align-items-center">
           <a href="#" class="text-decoration-none">
               <img id="corporation-img" src="" style="margin-bottom: 10px;" alt="ChronoLux Logo">
           </a>
       </div>
        <div class="col-lg-8 col-md-12 py-1" style="max-width: 60%">
<%--            <img class="image-footer flex-grow-1" src="<c:url value='/template/web/img/footer2.png'/>"style="height: 80%; max-width: 0%  ;width: fit-content">--%>
    <div class="info-part d-flex justify-content-end ">
        <div class="info-container">
            <p class="mb-2"><i class="fa fa-map-marker-alt mr-4" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-address"></span></p>
            <p class="mb-2"><i class="fa fa-envelope mr-3" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-email"></span></p>
            <p class="mb-0"><i class="fa fa-phone-alt mr-3" style="font-size: 30px;color: rgb(234,189,43)"></i><span id="corporation-phone"></span></p>
        </div>
    </div>
        </div>
        <p class="info-comp text-truncate text-center mt-2" id="corporation-about" style="width: 100%"></p>
    </div>
    <div class="row border-top border-dark mx-xl-5 mt-1">
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