<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/common/taglib.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>ChronoLux - Shop</title>
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
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script type="text/javascript"
                    src="<c:url value='/template/paging/jquery.twbsPagination.js' />"></script>


        </head>

        <body>


            <!-- Page Header Start -->
            <div class="container-fluid bg-secondary mb-5">
                <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                    <h1 class="font-weight-semi-bold text-uppercase mb-3">Our Shop</h1>
                    <div class="d-inline-flex">
                        <p class="m-0"><a href="">Home</a></p>
                        <p class="m-0 px-2">-</p>
                        <p class="m-0">Shop</p>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->
            <div class="col-12 pb-1">
                <c:if test="${model.filter != null}">
                    <div class="row mb-4" style="margin-left: 20px;"> <!-- Dịch sang trái một chút -->
                        <div class="col-12">
                            <span class="font-weight-bold">Đã chọn:</span>
                            <button type="button" id="clearFilterByPrice" class="btn btn-primary ml-2">
                                <c:if test="${model.filter == 'duoi-1-trieu'}">
                                    Dưới 1 triệu
                                </c:if>
                                <c:if test="${model.filter == 'tu-1-3-trieu'}">
                                    Từ 1 - 3 triệu
                                </c:if>
                                <c:if test="${model.filter == 'tu-3-6-trieu'}">
                                    Từ 3 - 6 triệu
                                </c:if>
                                <c:if test="${model.filter == 'tu-6-9-trieu'}">
                                    Từ 6 - 9 triệu
                                </c:if>
                                <c:if test="${model.filter == 'tren-9-trieu'}">
                                    Trên 9 triệu
                                </c:if>
                                <span class="close" aria-label="Close" style="cursor: pointer;">&times;</span>
                            </button>


                            <button type="button" id="clearAllFilter" class="btn btn-primary ml-2">Xóa hết
                                <span class="close" aria-label="Close" style="cursor: pointer;">&times;</span>
                            </button>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="col-12 py-2" style="margin-left: 35px;"> <!-- Dịch sang phải khoảng 1cm -->
                <span class="font-weight-bold mr-2">Phổ biến:</span>
                <a href="<c:url value='/shopr?page=${model.page}&limit=${model.limit}&filter=nam'/>" class="btn btn-outline-primary btn-sm rounded-pill mx-1">Nam</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=nu'/>" class="btn btn-outline-primary btn-sm rounded-pill mx-1">Nữ</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=duoi-1-trieu'/>"
                    class="btn btn-outline-primary btn-sm rounded-pill mx-1">Dưới 1 triệu</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=tu-1-3-trieu'/>"
                    class="btn btn-outline-primary btn-sm rounded-pill mx-1">Từ 1 - 3 triệu</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=tu-3-6-trieu'/>"
                    class="btn btn-outline-primary btn-sm rounded-pill mx-1">Từ 3 - 6 triệu</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=tu-6-9-trieu'/>"
                    class="btn btn-outline-primary btn-sm rounded-pill mx-1">Từ 6 - 9 triệu</a>
                <a href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&filter=tren-9-trieu'/>"
                    class="btn btn-outline-primary btn-sm rounded-pill mx-1">Trên 9 triệu</a>
            </div>


            <!-- Shop Start -->
            <div class="container-fluid pt-5">
                <div class="col-12 pb-1">
                    <div class="row mb-4">
                        <!-- Search and Filter aligned to the right -->
                        <div class="col-12 d-flex justify-content-end">
                            <!-- Search -->
                            <form action="<c:url value='/shop'/>" method="get" class="d-flex w-auto">
                                <div class="input-group" style="width: 250px;"> <!-- Set width of the search bar -->
                                    <input type="text" class="form-control" placeholder="Search by name" name="keyword">
                                    <input type="hidden" value="1" name="page">
                                    <input type="hidden" value="8" name="limit">
                                    <div class="input-group-append">
                                        <span class="input-group-text bg-transparent text-primary">
                                            <i class="fa fa-search"></i>
                                        </span>
                                    </div>
                                </div>
                            </form>

                            <!-- Filter -->
                            <div class="dropdown ml-3">
                                <button class="btn border dropdown-toggle" type="button" id="triggerId"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Sort by
                                </button>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="triggerId">
                                    <a class="dropdown-item"
                                        href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&sortName=name&sortBy=asc&keyword=${model.keyword}'/>">
                                        Name
                                    </a>
                                    <a class="dropdown-item"
                                        href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&sortName=price&sortBy=asc&keyword=${model.keyword}'/>">
                                        Price
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <form action="<c:url value='/shop'/>" id="formSubmit" method="get">
                    <div class="row px-xl-5">
                        <!-- Shop Product Start -->
                        <div class="col-lg-12 col-md-12">
                            <div class="row pb-3">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-lg-3 col-md-4 col-sm-6 col-12 pb-1">
                                        <div class="card product-item border-0 mb-4">
                                            <div
                                                class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                <img class="img-fluid w-100"
                                                    src="<c:url value='/template/web/img/${product.imgUrl}'/>" alt="">
                                            </div>
                                            <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                                <h6 class="text-truncate mb-3">${product.name}</h6>
                                                <div class="d-flex justify-content-center">
                                                    <h6>$123.00</h6>
                                                    <h6 class="text-muted ml-2"><del>$123.00</del></h6>
                                                </div>
                                            </div>
                                            <div class="card-footer d-flex justify-content-between bg-light border">
                                                <a href="" class="btn btn-sm text-dark p-0"><i
                                                        class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                                                <a href="" class="btn btn-sm text-dark p-0"><i
                                                        class="fas fa-shopping-cart text-primary mr-1"></i>Add To
                                                    Cart</a>
                                            </div>
                                        </div>

                                    </div>
                                </c:forEach>
                            </div>
                            <div class="col-12 pb-1">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mb-3" id="pagination"> </ul>
                                    <input type="hidden" value="" id="page" name="page" />
                                    <input type="hidden" value="" id="limit" name="limit" />

                                    <c:if test="${model.sortName != null && model.sortBy != null}">
                                        <input type="hidden" id="sortName" name="sortName" value="${model.sortName}" />
                                        <input type="hidden" id="sortBy" name="sortBy" value="${model.sortBy}" />
                                    </c:if>
                                    <c:if test="${model.keyword != null}">
                                        <input type="hidden" id="keyword" name="keyword" value="${model.keyword}" />
                                    </c:if>
                                    <c:if test="${model.filter != null}">
                                        <input type="hidden" id="filter" name="filter" value="${model.filter}" />
                                    </c:if>

                                </nav>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- Shop Product End -->
            </div>

            </div>
            <!-- Shop End -->

            <script>
                var currentPage = ${ model.page };
                var limit = ${ model.limit };
                var sortBy = "${model.sortBy}";
                var sortName = "${model.sortName}";
                var keyword = "${model.keyword}";
                var filter = "${model.filter}"

                $('#pagination').twbsPagination({
                    totalPages: ${ model.totalPage },
                    visiblePages: 10,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        if (currentPage != page) {
                            $('#limit').val(limit);
                            $('#page').val(page);
                            if (sortBy && sortName) {
                                $('#sortName').val(sortName);
                                $('#sortBy').val(sortBy);
                            }
                            if (keyword) {
                                $('#keyword').val(keyword);
                            }
                            if (filter) {
                                $('#filter').val(filter);
                            }


                            $('#formSubmit').submit();
                        }
                    }
              });

                $(document).ready(function () {
                    $("#clearAllFilter").click(function () {
                        // Xóa các giá trị bộ lọc
                        $("#filter").val("");

                        // Tải lại trang hoặc thực hiện hành động khác
                        window.location.href = "<c:url value='/shop?page=1&limit=8'/>"; // Hoặc bất kỳ URL nào
                    });
                });


            </script>
        </body>

        </html>