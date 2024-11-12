<%@ page import="model.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List, java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<style>
    /* Basic styling for the filter form */
    .filtersProduct {
        display: flex;
        gap: 20px; /* Space between select elements */
        margin: 20px 0; /* Space above and below the filters */
    }

    /* Style for the select elements */
    .filtersProduct select {
        padding: 10px 15px; /* Add some padding for comfort */
        border: 1px solid #ccc; /* Light gray border */
        border-radius: 5px; /* Rounded corners */
        font-size: 16px; /* Font size for better readability */
        background-color: #fff; /* White background */
        cursor: pointer; /* Cursor changes to pointer on hover */
        transition: border-color 0.3s; /* Smooth transition for border color */
    }

    /* Change border color on focus */
    .filtersProduct select:focus {
        border-color: #007BFF; /* Change border color to blue when focused */
        outline: none; /* Remove default outline */
    }

    /* Style for option elements (if needed) */
    .filtersProduct select option {
        padding: 10px; /* Add padding for options */
    }
    .delete-btn {
        display: inline-flex; /* Để căn giữa biểu tượng và văn bản */
        align-items: center; /* Căn giữa theo chiều dọc */
        justify-content: center; /* Căn giữa theo chiều ngang */
        padding: 6px 10px; /* Giảm kích thước padding để nút nhỏ hơn */
        background-color: #dc3545; /* Màu nền đỏ */
        color: white; /* Màu chữ trắng */
        font-size: 14px; /* Kích thước chữ */
        border: none; /* Không có viền */
        border-radius: 4px; /* Bo tròn góc */
        text-decoration: none; /* Không có gạch chân */
        transition: background-color 0.3s; /* Hiệu ứng chuyển đổi cho màu nền */
    }

    .delete-btn:hover {
        background-color: #c82333; /* Tối màu khi hover */
    }

    .delete-btn i {
        margin-right: 4px; /* Khoảng cách giữa biểu tượng và văn bản */
    }

    .btn-success {
        display: inline-block; /* Để căn giữa văn bản */
        padding: 5px 10px; /* Padding nhỏ gọn để nút nhỏ hơn */
        background-color: #28a745; /* Màu nền xanh lá cây tươi sáng */
        color: white; /* Màu chữ trắng */
        font-size: 14px; /* Kích thước chữ */
        font-weight: bold; /* Làm chữ đậm hơn */
        border: none; /* Không có viền */
        border-radius: 4px; /* Bo tròn góc */
        text-decoration: none; /* Không có gạch chân */
        text-align: center; /* Căn giữa văn bản */
        transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng chuyển đổi cho màu nền và kích thước */
        cursor: pointer; /* Hiển thị con trỏ khi hover */
    }

    .btn-success:hover {
        background-color: #218838; /* Tối màu khi hover */
        transform: scale(1.05); /* Tăng kích thước nhẹ khi hover */
    }

    .btn-success:active {
        transform: scale(0.95); /* Giảm kích thước khi nhấn */
    }

    .price {
        margin-bottom: 10px; /* Tạo khoảng cách giữa giá và nút */
    }




</style>

<!-- postManagement.jsp -->


<div id="wrapper">

    <!-- Sidebar -->



    <div id="content-wrapper">

        <div class="container-fluid">

            <!-- Breadcrumbs-->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="#">Dashboard</a>
                </li>
                <li class="breadcrumb-item active">Product Management</li>

            </ol>

            <!-- DataTables Example -->


            <div class="card mb-3">

                <h3 style="color: green">${requestScope.success}</h3>
                <div class="container">
                    <div class="card-body">
                        <div class="table-responsive">

                            <a href="AddProductServlet" class="btn btn-success">ADD</a>

                            </br></br>
                            <!-- Filters for Category, Status, and Search -->
                            <form id="filterProductForm" action="MarketerDashboard" method="GET">
                                <div class="filtersProduct">
                                    <select id="categoryProductFilter" name="categoryProduct" onchange="document.getElementById('filterProductForm').submit();">
                                        <option value="">All Categories</option>
                                        <c:forEach items="${sessionScope.categories}" var="sc">
                                            <option value="${sc.catID}" 
                                                    ${sessionScope.categoryProductTag == sc.catID ? 'selected' : ''}>
                                                ${sc.catName}
                                            </option>                
                                        </c:forEach>
                                    </select>

                                    <select id="brandProductFilter" name="brandProduct" onchange="document.getElementById('filterProductForm').submit();">
                                        <option value="">All Brands</option>
                                        <c:forEach items="${sessionScope.brands}" var="b">
                                            <option value="${b.brandID}" ${sessionScope.brandProductTag == b.brandID ? 'selected' : ''}>
                                                ${b.brandName}
                                            </option>
                                        </c:forEach>
                                    </select>

                                    <select id="statusProductFilter" name="statusProduct" onchange="document.getElementById('filterProductForm').submit();">
                                        <option value="">All Statuses</option>
                                        <option value="1" ${sessionScope.statusProductTag == "1" ? 'selected' : ''}>Active</option>
                                        <option value="0" ${sessionScope.statusProductTag == "0" ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </form>



                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>NAME</th>
                                        <th>IMAGE</th>
                                        <th>QUANTITY</th>
                                        <th>Hold</th> 
                                        <th>Price</th> 

                                        <th>CATEGORY</th>
                                        <th>BRAND</th>

                                        <th>Created At</th>
                                        <th>Status</th>
                                        <th>Featured</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>NAME</th>
                                        <th>IMAGE</th>
                                        <th>QUANTITY</th> 
                                        <th>Hold</th> 
                                        <th>Price</th> 

                                        <th>CATEGORY</th>
                                        <th>BRAND</th>

                                        <th>Created At</th>
                                        <th>Status</th>
                                        <th>Featured</th>
                                        <th>Action</th>
                                    </tr>
                                </tfoot>
                                <tbody>


                                    <c:forEach items="${sessionScope.filterProduct}" var="p">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID == p.productID}">
                                                <tr>
                                                    <td>${p.productID}</td>
                                                    <td>${p.productName}</td>
                                                    <td><img src="${i.productImgUrl}" width="205" height="205" alt="product"></td>
                                                    <td>${p.quantity}</td>
                                                    <td>
                                                        <c:set var="totalHold" value="0" />
                                                        <c:forEach items="${sessionScope.productAttributes}" var="attribute">
                                                            <c:if test="${p.productID == attribute.productID}">
                                                                <c:set var="totalHold" value="${totalHold + attribute.hold}" />
                                                            </c:if>
                                                        </c:forEach>
                                                        ${totalHold}
                                                    </td>
                                                    <td>
                                                        <c:set var="minPrice" value="0" />

                                                        <c:forEach items="${minSize}" var="min">
                                                            <c:if test="${min.productID == p.productID}">
                                                                <c:set var="minPrice" value="${min.price} (${min.sizeName})" />
                                                            </c:if>


                                                        </c:forEach>

                                                        ${minPrice}
                                                    </td>



                                                    <c:forEach items="${sessionScope.categories}" var="c">
                                                        <c:if test="${c.catID == p.catID}">
                                                            <td>${c.catName}</td>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:forEach items="${sessionScope.brands}" var="b">
                                                        <c:if test="${b.brandID == p.brandID}">
                                                            <td>${b.brandName}</td>
                                                        </c:if>
                                                    </c:forEach>

                                                    <td>${p.createdAt}</td>
                                                    <td>
                                                        ${p.status == 1 ? 'Active' : 'Inactive'} </br>
                                                        <a href="SetStatusProduct?setStatus=${p.status == 1 ? 0 : 1}&productID=${p.productID}" class="status-btn button">
                                                            <i class="fas fa-eye-slash"></i> ${p.status == 1 ? 'Inactive' : 'Active'}
                                                        </a>
                                                    </td>
                                                    <td>${p.featureStatus == 1 ? 'Yes' : 'No'}</td>

                                                    <td style="height: 60px; width: 120px">
                                                        <div class="button-container d-flex justify-content-center align-items-center" style="height: 100%;">
                                                            <a href="product-detail?productID=${p.productID}" class="view-btn button">
                                                                <i class="fas fa-eye"></i> View
                                                            </a>
                                                            <a href="EditProductServlet?productID=${p.productID}" class="edit-btn button">
                                                                <i class="fas fa-edit"></i> Edit
                                                            </a>

                                                            <a href="#" onclick="doDeleteProduct('${p.productID}')" class="delete-btn button">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </a>
                                                        </div>
                                                    </td>


                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>





                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


            </div>
            <p class="small text-center text-muted my-5">
                <em>More table examples coming soon...</em>
            </p>


        </div>
        <!-- /.container-fluid -->


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

