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

    .button-container {
        display: flex;
        justify-content: space-around;
        align-items: center;
        height: 100%;
    }

    .button {
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
        color: #fff;
        transition: background-color 0.3s ease, transform 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .button i {
        margin-right: 6px;
    }

    .view-btn {
        background-color: #17a2b8; /* Màu xanh dương cho nút "View" */
    }

    .btn-success {
        background-color: #28a745; /* Màu xanh lá cho nút "Import" */
    }

    .edit-btn {
        background-color: #ffc107; /* Màu vàng cho nút "Edit" */
    }

    .delete-btn {
        background-color: #dc3545; /* Màu đỏ cho nút "Delete" */
    }

    .button:hover {
        transform: scale(1.05);
        filter: brightness(1.1);
    }

    .button:active {
        transform: scale(0.95);
    }

    .button-container .button {
        margin: 0 5px;
        min-width: 90px;
    }

    .import-btn {
        background-color: #28a745; /* Màu xanh lá cho nút Import */
    }

    .import-btn:hover {
        background-color: #218838; /* Màu khi hover cho Import */
    }


    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
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


                            </br></br>
                            <!-- Filters for Category, Status, and Search -->
                            <form id="filterProductForm" action="WarehouseServlet" method="GET">
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


                                </div>
                            </form>




                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>NAME</th>
                                        <th>IMAGE</th>
                                        <th>Import Price</th>
                                        <th>QUANTITY</th>
                                        <th>Hold</th>

                                        <th>Available</th>


                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>NAME</th>
                                        <th>IMAGE</th>
                                        <th>Import Price</th>
                                        <th>QUANTITY</th> 
                                        <th>Hold</th>

                                        <th>Available</th>


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

                                                    <td>
                                                        <c:set var="minImportPrice" value="0" />
                                                        <c:forEach items="${minSizeWarehouse}" var="min">
                                                            <c:if test="${min.productID == p.productID}">
                                                                <c:set var="minImportPrice" value="${min.importPrice} (${min.sizeName})" />
                                                            </c:if>
                                                        </c:forEach>

                                                        ${minImportPrice}
                                                    </td>
                                                    <td>${p.quantity}</td>

                                                    <td>
                                                        <c:set var="totalHold" value="0" />
                                                        <c:forEach items="${sessionScope.productAttributesWarehouse}" var="attribute">
                                                            <c:if test="${p.productID == attribute.productID}">
                                                                <c:set var="totalHold" value="${totalHold + attribute.hold}" />
                                                            </c:if>
                                                        </c:forEach>
                                                        ${totalHold}
                                                    </td>

                                                    <td>
                                                        <c:set var="available" value="${p.quantity - totalHold}" />
                                                        ${available}
                                                    </td>


                                                    <td style="height: 60px; width: 120px">
                                                        <div class="button-container d-flex justify-content-center align-items-center" style="height: 100%;">
                                                            <a href="EditProduct?productID=${p.productID}" class="edit-btn button">
                                                                <i class="fas fa-edit"></i> Edit
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

<script>
    function openDetailModal(productId) {
        document.getElementById('detailModal' + productId).style.display = 'block';
    }

    function closeDetailModal(productId) {
        document.getElementById('detailModal' + productId).style.display = 'none';
    }

// Close modal when clicking outside of it
    window.onclick = function (event) {
        const modals = document.getElementsByClassName('modal');
        for (let i = 0; i < modals.length; i++) {
            if (event.target == modals[i]) {
                modals[i].style.display = 'none';
            }
        }
    }
</script>



