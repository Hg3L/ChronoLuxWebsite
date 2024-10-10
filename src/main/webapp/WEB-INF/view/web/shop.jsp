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
                <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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


            <!-- Shop Start -->
            <div class="container-fluid pt-5">
                <form action="<c:url value='/shop'/>" id="formSubmit" method="get">
                    <div class="row px-xl-5">
                        <!-- Shop Sidebar Start -->
                        <div class="col-lg-3 col-md-12">
                            <!-- Price Start -->
                            <div class="border-bottom mb-4 pb-4">
                                <h5 class="font-weight-semi-bold mb-4">Filter by price</h5>
                                <form>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" checked id="price-all">
                                        <label class="custom-control-label" for="price-all">All Price</label>
                                        <span class="badge border font-weight-normal">1000</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="price-1">
                                        <label class="custom-control-label" for="price-1">$0 - $100</label>
                                        <span class="badge border font-weight-normal">150</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="price-2">
                                        <label class="custom-control-label" for="price-2">$100 - $200</label>
                                        <span class="badge border font-weight-normal">295</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="price-3">
                                        <label class="custom-control-label" for="price-3">$200 - $300</label>
                                        <span class="badge border font-weight-normal">246</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="price-4">
                                        <label class="custom-control-label" for="price-4">$300 - $400</label>
                                        <span class="badge border font-weight-normal">145</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between">
                                        <input type="checkbox" class="custom-control-input" id="price-5">
                                        <label class="custom-control-label" for="price-5">$400 - $500</label>
                                        <span class="badge border font-weight-normal">168</span>
                                    </div>
                                </form>
                            </div>
                            <!-- Price End -->

                            <!-- Color Start -->
                            <div class="border-bottom mb-4 pb-4">
                                <h5 class="font-weight-semi-bold mb-4">Filter by color</h5>
                                <form>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" checked id="color-all">
                                        <label class="custom-control-label" for="price-all">All Color</label>
                                        <span class="badge border font-weight-normal">1000</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="color-1">
                                        <label class="custom-control-label" for="color-1">Black</label>
                                        <span class="badge border font-weight-normal">150</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="color-2">
                                        <label class="custom-control-label" for="color-2">White</label>
                                        <span class="badge border font-weight-normal">295</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="color-3">
                                        <label class="custom-control-label" for="color-3">Red</label>
                                        <span class="badge border font-weight-normal">246</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="color-4">
                                        <label class="custom-control-label" for="color-4">Blue</label>
                                        <span class="badge border font-weight-normal">145</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between">
                                        <input type="checkbox" class="custom-control-input" id="color-5">
                                        <label class="custom-control-label" for="color-5">Green</label>
                                        <span class="badge border font-weight-normal">168</span>
                                    </div>
                                </form>
                            </div>
                            <!-- Color End -->

                            <!-- Size Start -->
                            <div class="mb-5">
                                <h5 class="font-weight-semi-bold mb-4">Filter by size</h5>
                                <form>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" checked id="size-all">
                                        <label class="custom-control-label" for="size-all">All Size</label>
                                        <span class="badge border font-weight-normal">1000</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="size-1">
                                        <label class="custom-control-label" for="size-1">XS</label>
                                        <span class="badge border font-weight-normal">150</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="size-2">
                                        <label class="custom-control-label" for="size-2">S</label>
                                        <span class="badge border font-weight-normal">295</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="size-3">
                                        <label class="custom-control-label" for="size-3">M</label>
                                        <span class="badge border font-weight-normal">246</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                        <input type="checkbox" class="custom-control-input" id="size-4">
                                        <label class="custom-control-label" for="size-4">L</label>
                                        <span class="badge border font-weight-normal">145</span>
                                    </div>
                                    <div
                                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between">
                                        <input type="checkbox" class="custom-control-input" id="size-5">
                                        <label class="custom-control-label" for="size-5">XL</label>
                                        <span class="badge border font-weight-normal">168</span>
                                    </div>
                                </form>
                            </div>
                            <!-- Size End -->
                        </div>
                        <!-- Shop Sidebar End -->


                        <!-- Shop Product Start -->

                        <div class="col-lg-9 col-md-12">
                            <div class="row pb-3">
                                <div class="col-12 pb-1">
                                    <div class="d-flex align-items-center justify-content-between mb-4">
                                        <form action="">
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="Search by name">
                                                <div class="input-group-append">
                                                    <span class="input-group-text bg-transparent text-primary">
                                                        <i class="fa fa-search"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </form>
                                        <div class="dropdown ml-4">
                                            <button class="btn border dropdown-toggle" type="button" id="triggerId"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Sort by
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="triggerId">
                                                <a class="dropdown-item" href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&sortName=name&sortBy=asc'/>">Name</a>
                                                <a class="dropdown-item" href="<c:url value='/shop?page=${model.page}&limit=${model.limit}&sortName=price&sortBy=asc'/>">Price</a>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <c:forEach var="product" items="${products}">
                                    <div class="col-lg-4 col-md-6 col-sm-12 pb-1">
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
              var currentPage = ${model.page};
              var totalPages = ${model.totalPage};
              var limit = ${model.limit};
              var sortBy = "${model.sortBy}";
              var sortName = "${model.sortName}";

              $('#pagination').twbsPagination({
                  totalPages: totalPages,
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

                          $('#formSubmit').submit();
                      }
                  }
              });
          </script>
        </body>

        </html>