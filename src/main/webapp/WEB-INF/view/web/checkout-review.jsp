<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Review Payment</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="Free HTML Templates" name="keywords">
            <meta content="Free HTML Templates" name="description">

            <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">

            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
                rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"
                rel="stylesheet">
             <!-- Thêm FontAwesome để hiện icon dấu tích -->
                <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
                <!-- Thêm Bootstrap JS (tùy chọn) -->
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <!-- Customized Bootstrap Stylesheet -->
            <link href=" <c:url value='/template/web/cssviewprofile/style.css'/>" rel="stylesheet">
            <link href=" <c:url value='/template/web/css/style.css'/>" rel="stylesheet">
            <style>
                    .review-container {
                        border: 1px solid #dee2e6;
                        border-radius: 10px;
                        padding: 30px;
                        background-color: #f8f9fa;
                    }
                    .section-title {
                        font-weight: bold;
                        color: #343a40;
                        border-bottom: 2px solid #007bff;
                        padding-bottom: 5px;
                        margin-bottom: 15px;
                    }
                    .details-row {
                        margin-bottom: 10px;
                    }
                    .details-label {
                        font-weight: bold;
                        color: #495057;
                    }
                </style>
            <%----------------------------%>
        </head>

        <body>
<div class="container text-center mt-5">
        <div class="container mt-5">
               <div class="text-center mb-4">
                   <h2 class="text-danger">Please Review Before Paying</h2>
               </div>
            <form action = "<c:url value='/execute_payment'/>" method = "post">
                <input type ="hidden" name = "paymentId" value = "${paymentId}">
                <input type ="hidden" name = "payerId" value = "${payerId}">
               <div class="review-container">
                   <!-- Transaction Details -->
                   <div class="section-title">Transaction Details:</div>
                   <div class="details-row">
                       <span class="details-label">Description:</span> ${transaction.description}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Subtotal:</span> ${transaction.amount.details.subtotal}
                   </div>


                   <div class="details-row">
                       <span class="details-label">Total:</span> <span class="text-success">${transaction.amount.total}</span>
                   </div>

                   <!-- Payer Information -->
                   <div class="section-title mt-4">Payer Information:</div>
                   <div class="details-row">
                       <span class="details-label">First Name:</span>${payer.firstName}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Last Name:</span>${payer.lastName}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Email:</span> ${payer.email}
                   </div>

                   <!-- Shipping Address -->
                   <div class="section-title mt-4">Shipping Address:</div>
                   <div class="details-row">
                       <span class="details-label">Recipient Name:</span> ${shippingAddress.recipientName}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Line 1:</span> ${shippingAddress.line1}
                   </div>
                   <div class="details-row">
                       <span class="details-label">City:</span> ${shippingAddress.city}
                   </div>
                   <div class="details-row">
                       <span class="details-label">State:</span> ${shippingAddress.state}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Country Code:</span> ${shippingAddress.countryCode}
                   </div>
                   <div class="details-row">
                       <span class="details-label">Postal Code:</span> ${shippingAddress.postalCode}
                   </div>

                   <!-- Pay Now Button -->
                   <div class="text-center mt-4">
                       <button class="btn btn-primary btn-lg">Pay Now</button>
                   </div>
               </div>
                  </form>
           </div>

    </div>

        </body>

        </html>