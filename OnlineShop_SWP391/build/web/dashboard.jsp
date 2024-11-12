<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Badminton Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/  vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">

    </head>

    <body id="page-top">

        <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

            <a class="navbar-brand mr-1" href="home">HOME</a>

            <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Navbar Search -->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for..." aria-label="Search"
                           aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>

            <!-- Navbar -->

        </nav>

        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="sidebar navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="dashboard">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="chart">
                        <i class="fas fa-fw fa-chart-area"></i>
                        <span>Charts</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="table">
                        <i class="fas fa-fw fa-table"></i>
                        <span>Tables</span></a>

                </li>
            </ul>

            <div id="content-wrapper">

                <div class="container-fluid">

                    <!-- Breadcrumbs-->
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="dashboard">Dashboard</a>
                        </li>
                        <li class="breadcrumb-item active">Overview</li>
                    </ol>

                    <!-- Icon Cards-->
                    <div class="row">
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-primary o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-comments"></i>
                                    </div>
                                    <div style="font-size: 40px" class="mr-5">${requestScope.totalAccounts} ACCOUNT</div>
                                </div>
                                <a class="card-footer text-white clearfix small z-1" href="accountManage">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right">
                                        <i class="fas fa-angle-right"></i>
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-warning o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-list"></i>
                                    </div>
                                    <div style="font-size: 30px" class="mr-5">
                                        ${totalOrders} ORDERS<br>
                                        REVENUE: ${totalRevenue}$</div>
                                </div>
                                <a class="card-footer text-white clearfix small z-1" href="orderManage">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right">
                                        <i class="fas fa-angle-right"></i>
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-success o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-shopping-cart"></i>
                                    </div>
                                    <div style="font-size: 40px" class="mr-5">${totalProducts} PRODUCTS</div>
                                </div>
                                <a class="card-footer text-white clearfix small z-1" href="productmanage">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right">
                                        <i class="fas fa-angle-right"></i>
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-danger o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-life-ring"></i>
                                    </div>
                                    <div style="font-size: 40px" class="mr-5"> DISTRIBUTION</div>
                                </div>
                                <a class="card-footer text-white clearfix small z-1" href="chart">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right">
                                        <i class="fas fa-angle-right"></i>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Area Chart Example-->

                    <!-- DataTables Example -->
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Top 5 Account With Order
                        </div>
                        <h3 style="color: green">${requestScope.success}</h3>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>ACCOUNT ID</th>
                                            <th>ACCOUNT NAME</th>
                                            <th>AMOUNT OF ORDER</th>
                                            <th>AMOUNT OF CASH</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ACCOUNT ID</th>
                                            <th>ACCOUNT NAME</th>
                                            <th>AMOUNT OF ORDER</th>
                                            <th>AMOUNT OF CASH</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${accounts}" var="a">
                                            <tr>
                                                <td>${a.accountID}</td>
                                                <td>${a.accountUsername}</td>
                                                <c:forEach var="summary" items="${accountSummaries}">
                                                    <c:if test="${a.accountID == summary.key}">
                                                        <td>${summary.value.totalOrders}</td>
                                                        <td>${summary.value.totalAmount}</td>
                                                    </c:if>
                                                </c:forEach>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                    </div>


                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Top 5 Most Purchased Products
                        </div>
                        <h3 style="color: green">${requestScope.success}</h3>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>PRODUCT ID</th>
                                            <th>PRODUCT NAME</th>
                                            <th>IMAGE</th>
                                            <th>TOTAL QUANTITY PURCHASED</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>PRODUCT ID</th>
                                            <th>PRODUCT NAME</th>
                                            <th>IMAGE</th>
                                            <th>TOTAL QUANTITY PURCHASED</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${topProducts}" var="product">
                                            <tr>
                                                <td>${product.productID}</td>
                                                <td>${product.name}</td>
                                                <td><img  style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/assets/images/demoes/demo18/products/${product.image}" alt="product"></td>
                                                <td>${product.totalQuantity}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                    </div>

                </div>
                <!-- /.container-fluid -->

                <!-- Sticky Footer -->
                <footer class="sticky-footer">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright © Your Website 2019</span>
                        </div>
                    </div>
                </footer>

            </div>
            <!-- /.content-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Logout Modal-->
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-primary" href="login.html">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/chart.js/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendor/datatables/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendor/datatables/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-dataTables-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/demo/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/demo/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-dataTables-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/colReorder-bootstrap4-min.js"></script>

        <script type="text/javascript">
            function doDelete(id) {
                if (confirm('Are you sure about deleting id: ' + id + '?')) {
                    window.location = 'delete?id=' + id;
                }
            }
        </script>
    </body>

</html>