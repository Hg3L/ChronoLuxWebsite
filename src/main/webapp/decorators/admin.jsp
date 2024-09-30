<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><dec:title default="Home" /></title>

     <dec:head />



</head>

 <body id="page-top">

            <!-- Page Wrapper -->
            <div id="wrapper">

                <%@ include file="/common/admin/menu.jsp" %>

                    <!-- Content Wrapper -->
                    <div id="content-wrapper" class="d-flex flex-column">

                        <!-- Main Content -->
                        <div id="content">
                            <%@ include file="/common/admin/header.jsp" %>
                                <dec:body />
                                <%@ include file="/common/admin/footer.jsp" %>
                        </div>

                    </div>
            </div>




    <!-- Bootstrap core JavaScript-->
    <script src="<c:url value='/template/admin/vendor/jquery/jquery.min.js'/>"></script>

    <script src= "<c:url value='/template/admin/vendor/bootstrap/js/bootstrap.bundle.min.js'/>"></script>

    <!-- Core plugin JavaScript-->
    <script src="<c:url value='/template/admin/vendor/jquery-easing/jquery.easing.min.js'/>"></script>

    <!-- Custom scripts for all pages-->
    <script src="<c:url value='/template/admin/js/sb-admin-2.min.js'/>"></script>

    <!-- Page level plugins -->
    <script src="<c:url value='/template/admin/vendor/chart.js/Chart.min.js'/>"></script>

    <!-- Page level custom scripts -->
    <script src="<c:url value='/template/admin/js/demo/chart-area-demo.js'/>"></script>
    <script src="<c:url value='/template/admin/js/demo/chart-pie-demo.js'/>"></script>

                <script src="  <c:url value='/template/admin/vendor/datatables/jquery.dataTables.min.js'/>"></script>
                <script src="   <c:url value='/template/admin/vendor/datatables/dataTables.bootstrap4.min.js'/>"></script>

                <!-- Page level custom scripts -->

                <script src="    <c:url value='/template/admin/js/demo/datatables-demo.js'/>"></script>
</body>

</html>