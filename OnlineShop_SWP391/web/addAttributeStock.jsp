



<!-- updateProduct.jsp -->









<%@ page import="model.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List, java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    // Get data for line chart
    // Get the newCustomersMap from the request
    Map<String, Integer> newCustomersMap = (Map<String, Integer>) session.getAttribute("newCustomersMap");
    List<String> newCustomersDates = new ArrayList<>();
    List<Integer> newCustomersCounts = new ArrayList<>();

    // Utility to get the last 7 days
    java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
    java.time.LocalDate today = java.time.LocalDate.now();
    
    // Generate last 7 days list
    for (int i = 6; i >= 0; i--) {
        java.time.LocalDate date = today.minusDays(i);
        String dateString = date.format(formatter);
        
        // If the date exists in the map, add its count, otherwise add 0
        newCustomersDates.add(dateString);
        if (newCustomersMap != null && newCustomersMap.containsKey(dateString)) {
            newCustomersCounts.add(newCustomersMap.get(dateString));
        } else {
            newCustomersCounts.add(0); // If date not present, add count 0
        }
    }
    
    // Get data for pie chart
   Map<String, Integer> productCountMap = (Map<String, Integer>) session.getAttribute("productCountMap");
   String[] categories;
   Integer[] productCounts;
   if (productCountMap != null) {
       categories = productCountMap.keySet().toArray(new String[0]);
       productCounts = productCountMap.values().toArray(new Integer[0]);
   } else {
       categories = new String[] {};
       productCounts = new Integer[] {};
   }
%>
<style>
    /* Styling for the update product form */
    .updateProductForm {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin: 20px 0;
    }

    /* Style for input fields and buttons */
    .updateProductForm input, .updateProductForm select, .updateProductForm button {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    /* Button style */
    .updateProductForm button {
        background-color: #28a745;
        color: #fff;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    /* Button hover effect */
    .updateProductForm button:hover {
        background-color: #218838;
    }

    /* General layout for the page */
    .update-container {
        margin-top: 30px;
    }
</style>
<!DOCTYPE html>
<html>
    <head>
        <title>Marketer Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">   
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/assets/  vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/assets/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/assets/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/colReorder-bootstrap4.css">

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }
            .sidebar {
                width: 220px; /* Giảm kích thước sidebar */
                background-color: #2c3e50;
                position: fixed;
                height: 100%;
                color: white;
                padding-top: 20px;
            }
            .sidebar .profile {
                text-align: center;
                padding: 10px 0;
            }
            .sidebar .profile img {
                border-radius: 50%;
                width: 55px;
                height: 55px;
                margin-left: 10px;
            }
            .sidebar .profile h3 {
                margin: 10px 0 5px;
            }
            .sidebar .profile p {
                color: #1abc9c;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar ul li {
                padding: 15px 20px;
                cursor: pointer;
            }
            .sidebar ul li:hover {
                background-color: #34495e;
            }
            .sidebar ul li i {
                margin-right: 10px;
            }
            .sidebar ul li.active {
                background-color: #e74c3c;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px;
            }
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .header .logo {
                display: flex;
                align-items: center;
            }
            .header .logo img {
                width: 40px;
                margin-right: 10px;
            }
            .dashboard-cards {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* Change to 3 columns */
                gap: 20px; /* Maintain gap between cards */
            }
            .card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex; /* Maintain flex layout */
                align-items: center;
                flex-direction: row; /* Ensure horizontal layout */
            }
            .card-icon {
                width: 80px; /* Đặt chiều rộng cố định */
                height: 120px; /* Đặt chiều cao cố định */
                display: flex; /* Sử dụng flexbox để căn giữa icon */
                align-items: center; /* Căn giữa theo chiều dọc */
                justify-content: center; /* Căn giữa theo chiều ngang */
                font-size: 30px; /* Kích thước chữ cho icon */
                margin-right: 20px;
                padding: 20px;
                border-radius: 8px;
            }
            .card-content {
                flex: 1; /* Make sure it expands */
            }
            .card-title {
                font-size: 18px; /* Increase title size for better visibility */
                font-weight: bold;
                color: #d32f2f;
                margin: 0;
            }
            .card-value {
                font-size: 28px; /* Increase value size for better visibility */
                margin: 10px 0;
            }
            .card-description {
                font-size: 14px;
                color: #757575;
            }
            .green {
                background-color: #a5d6a7;
            }
            .blue {
                background-color: #90caf9;
            }
            .orange {
                background-color: #ffcc80;
            }
            .chart {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            a {
                text-decoration: none;
                color: inherit; /* Ensure links inherit color */
            }

            a:hover{
                text-decoration: none;
                color: inherit; /* Ensure links inherit color */
            }
            .header-form {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 35px;
                margin-bottom: 16px;
            }

            .date-form{
                display: flex;
            }
            h2 {
                margin: 0;
            }
            .form-group {
                margin-right: 10px;
                width: 150px; /* Adjust this width to your preference */
            }

            input[type="date"] {
                width: 100%; /* Ensure the input takes full width of the form-group */
                padding: 7px 10px; /* Increase padding for larger fields */
                border-radius: 6px; /* Make input corners more rounded */
                border: 1px solid #ccc;
                font-size: 14px; /* Increase font size for larger text */
                box-sizing: border-box; /* Ensure padding doesn't affect the width */
            }

            button {
                padding: 7px 10px; /* Bigger button padding */
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px; /* Larger font size for the button */
            }

            button:hover {
                background-color: #45a049;
            }
            @media (max-width: 600px) {
                .header-form {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .date-form {
                    margin-top: 10px;
                    display: flex;
                    flex-wrap: wrap;
                    gap: 10px;
                }
                .change-password-form {
                    padding: 15px;
                    width: 90%;
                }
            }
            .content-section {
                display: none;
            }

            .content-section.active {
                display: block;
            }

            .change-password-form {
                width: 100%;
                max-width: 400px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background-color: #f9f9f9;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            /* Tiêu đề chính */
            .change-password-form h3 {
                text-align: center;
                margin-bottom: 20px;
                font-family: Arial, sans-serif;
                color: #333;
            }

            /* Kiểu dáng form group */
            .form-group-pass {
                margin-bottom: 15px;
            }

            /* Kiểu dáng cho nhãn (label) */
            .form-group-pass label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #555;
            }

            /* Kiểu dáng cho ô nhập liệu */
            .form-group-pass input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                box-sizing: border-box;
                transition: border-color 0.3s ease-in-out;
            }

            /* Thay đổi viền khi ô nhập liệu được focus */
            .form-group-pass input:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.25);
            }

            /* Kiểu dáng cho nút submit */
            .form-group-pass button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease-in-out;
            }

            /* Thay đổi màu khi hover vào nút */
            .form-group-pass button:hover {
                background-color: #0056b3;
            }

            /* Đặt khoảng cách và làm cho form dễ đọc hơn */
            .change-password-form {
                font-family: Arial, sans-serif;
                line-height: 1.6;
            }
            /* Style cho thanh bật/tắt */
            .switch {
                position: relative;
                display: inline-block;
                width: 60px; /* Độ rộng của thanh */
                height: 34px; /* Chiều cao của thanh */
            }

            .switch input {
                opacity: 0; /* Ẩn checkbox thực tế */
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc; /* Màu nền khi Off */
                transition: .4s; /* Hiệu ứng chuyển tiếp */
                border-radius: 34px; /* Bo tròn góc */
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px; /* Chiều cao của vòng tròn */
                width: 26px; /* Độ rộng của vòng tròn */
                left: 4px; /* Khoảng cách bên trái */
                bottom: 4px; /* Khoảng cách bên dưới */
                background-color: white; /* Màu nền của vòng tròn */
                border-radius: 50%; /* Bo tròn vòng tròn */
                transition: .4s; /* Hiệu ứng chuyển tiếp */
            }

            /* Khi checkbox được checked */
            input:checked + .slider {
                background-color: #2196F3; /* Màu nền khi On */
            }

            input:checked + .slider:before {
                transform: translateX(26px); /* Di chuyển vòng tròn sang phải */
            }
            .chart-container {
                display: flex;                /* Use flexbox layout */
                justify-content: space-between; /* Align both charts evenly */
                align-items: center;           /* Align items vertically in the center */
                gap: 20px;                     /* Optional: Add space between charts */
            }

            .chart {
                flex: 2;
            }

            .pie-chart {
                flex: 1;                       /* Set a smaller flex value for the pie chart */
            }

            canvas {
                width: 100%;        /* Ensure the canvas scales with the container */
                height: 300px;      /* Set a uniform height for all charts */
            }
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .main-content {
                    margin-left: 0;
                }

                /* Điều chỉnh header */
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .header .logo {
                    margin-bottom: 10px;
                }

                .header .logo img {
                    width: 30px; /* Giảm kích thước logo */
                }

                /* Điều chỉnh kích thước bảng và nội dung trong bảng */
                .table-responsive {
                    overflow-x: auto;
                }

                .card {
                    flex-direction: column; /* Chuyển sang bố cục dọc */
                    align-items: flex-start;
                }

                .card-icon {
                    margin-right: 0; /* Loại bỏ khoảng cách giữa icon và nội dung */
                    margin-bottom: 10px;
                }

                .card-content {
                    width: 100%; /* Đảm bảo nội dung mở rộng toàn bộ chiều rộng */
                }

                /* Điều chỉnh layout của các thẻ */
                .dashboard-cards {
                    grid-template-columns: 1fr; /* Chuyển sang 1 cột */
                }

                /* Điều chỉnh layout của các biểu đồ */
                .chart-container {
                    flex-direction: column; /* Biểu đồ xếp chồng thay vì cạnh nhau */
                    gap: 15px;
                }

                .chart, .pie-chart {
                    width: 100%;
                    height: auto;
                }
            }

            .container {
                max-width: 1200px; /* Width of the container */
                margin: 20px auto; /* Center the container */
                padding: 20px; /* Padding inside the container */
                background: white; /* Background color of the container */
                border-radius: 8px; /* Rounded corners */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Shadow for depth */
            }

            header {
                display: flex; /* Flexbox layout for the header */
                justify-content: space-between; /* Space between elements */
                align-items: center; /* Center items vertically */
            }

            h1 {
                font-size: 24px; /* Font size for the heading */
                margin: 0; /* Remove default margin */
            }

            .add-post {
                padding: 10px 20px; /* Padding for the button */
                background-color: #4CAF50; /* Background color for the button */
                color: white; /* Text color for the button */
                border: none; /* Remove border */
                border-radius: 5px; /* Rounded corners */
                text-decoration: none; /* Remove underline */
            }

            .filters {
                margin: 20px 0; /* Margin above and below the filters */
                display: flex; /* Flexbox layout for filters */
                gap: 10px; /* Space between filter elements */
            }

            .filters select, .filters input {
                padding: 10px; /* Padding for input elements */
                border: 1px solid #ccc; /* Border color */
                border-radius: 5px; /* Rounded corners */
            }

            table {
                width: 100%; /* Full width for the table */
                border-collapse: collapse; /* Collapse borders */
            }

            thead {
                background-color: #34495e; /* Background color for the table header */
                color: white; /* Text color for the header */
            }

            th, td {
                padding: 10px; /* Padding for table cells */
                text-align: left; /* Align text to the left */
            }

            .thumbnail {
                width: 50px; /* Width for thumbnail images */
                height: 50px; /* Height for thumbnail images */
                object-fit: cover; /* Crop images to fit */
            }

            .btn {
                padding: 5px 10px; /* Padding for buttons */
                border: none; /* Remove border */
                border-radius: 5px; /* Rounded corners */
                background-color: #3498db; /* Background color for buttons */
                color: white; /* Text color for buttons */
                cursor: pointer; /* Change cursor on hover */
                margin: 2px; /* Margin between buttons */
            }

            .btn:hover {
                background-color: #2980b9; /* Darken background color on hover */
            }

            .pagination {
                display: flex; /* Flexbox layout for pagination */
                justify-content: center; /* Center pagination items */
                margin-top: 20px; /* Margin above pagination */
            }

            .pagination .btn {
                margin: 0 5px; /* Margin for pagination buttons */
            }
            /* Tăng kích thước container và làm cho nó responsive */
            /* Tăng kích thước container và làm cho nó responsive với % */
            .container {
                max-width: 100%; /* Đặt giới hạn chiều rộng là 90% của màn hình */
                width: 100%; /* Đảm bảo nó luôn chiếm toàn bộ chiều rộng có thể */
                margin: 0 auto; /* Canh giữa container */
                padding: 0 2%; /* Thêm khoảng cách hai bên bằng phần trăm */
            }

            /* Điều chỉnh kích thước của .card và khoảng cách */
            .card.mb-3 {
                margin-bottom: 2%; /* Sử dụng % cho khoảng cách phía dưới */
                border-radius: 1.5%; /* Tạo góc bo mềm mại theo tỷ lệ phần trăm */
                padding: 2%; /* Khoảng cách bên trong card theo phần trăm */
                box-shadow: 0 2% 4% rgba(0, 0, 0, 0.1); /* Sử dụng % cho bóng đổ để duy trì tỷ lệ */
            }

            /* Responsive cho các màn hình nhỏ */
            @media (max-width: 768px) {
                .container {
                    padding: 0 5%; /* Giảm padding hai bên cho màn hình nhỏ */
                }

                .card.mb-3 {
                    padding: 3%; /* Tăng padding bên trong cho màn hình nhỏ */
                    margin-bottom: 5%; /* Tăng khoảng cách dưới cho card */
                }
                table img {
                    max-width: 80px; /* Giảm kích thước ảnh trên màn hình nhỏ */
                }
            }



            /* Container chính bao quanh form */
            .update-container {
                display: flex;
                justify-content: space-between; /* Sắp xếp khoảng cách giữa các phần */
                gap: 5%; /* Khoảng cách giữa phần trái và phải theo tỷ lệ phần trăm */
                margin-top: 30px;
                flex-wrap: wrap; /* Cho phép phần tử wrap khi màn hình nhỏ */
            }

            /* Phần bên trái chứa ảnh và cập nhật ảnh */
            .left-section {
                flex-basis: 40%; /* Chiếm 40% không gian của container */
                padding-left: 2%; /* Padding theo phần trăm để dễ dàng thích ứng với các kích thước khác nhau */
            }

            /* Phần bên phải chứa thông tin sản phẩm */
            .right-section {
                flex-basis: 55%; /* Chiếm 55% không gian của container */
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            /* Ảnh sản phẩm */
            .product-image {
                width: 100%;
                max-width: 100%; /* Đảm bảo ảnh không vượt quá kích thước của container */
                height: auto;
                margin-bottom: 20px;
            }

            /* Styling cho input và select */
            .updateProductForm input, .updateProductForm select {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 100%; /* Chiếm toàn bộ chiều rộng của container */
            }

            /* Styling cho button */
            .updateProductForm button {
                background-color: #28a745;
                color: #fff;
                padding: 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            .updateProductForm button:hover {
                background-color: #218838;
            }


            /* Responsive Design: Điều chỉnh cho màn hình nhỏ hơn */
            @media (max-width: 768px) {
                .left-section, .right-section {
                    flex-basis: 100%; /* Trên màn hình nhỏ, cả hai phần sẽ chiếm 100% không gian */
                    margin-left: 0;
                    padding-left: 0;
                }

                .update-container {
                    gap: 20px; /* Tăng khoảng cách giữa hai phần */
                }

                .product-image {
                    max-width: 100%; /* Ảnh chiếm toàn bộ chiều rộng trên màn hình nhỏ */
                }
                .custom-file-label {
                    padding: 10px;
                    font-size: 14px;
                }
            }
            .sub-images-section {
                margin-bottom: 20px; /* Space below the whole section */
            }

            .sub-images {
                display: flex;
                flex-wrap: wrap;
                gap: 20px; /* Space between each sub-image and input */
            }

            .sub-image-container {
                text-align: center; /* Center-align the label and image */
                width: 120px; /* Set width for each sub-image container */
            }

            .sub-product-image {
                width: 100px;  /* Set the width of the thumbnail */
                height: auto;  /* Maintain aspect ratio */
                border: 1px solid #ddd;
                padding: 5px;
                margin-top: 10px; /* Space between the input and image */
            }

            .sub-image-container input[type="file"] {
                display: block;
                margin: 10px auto; /* Center input and give it space */
                width: 90%; /* Make the input field smaller */
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
                width: 80px;
                height: 40px;
            }

            .delete-btn:hover {
                background-color: #c82333; /* Tối màu khi hover */
            }

            .delete-btn i {
                margin-right: 4px; /* Khoảng cách giữa biểu tượng và văn bản */
            }
            .left-section {
                display: flex;
                flex-direction: column;
                align-items: center; /* Căn giữa nội dung theo chiều ngang */
                justify-content: flex-end; /* Căn nội dung xuống dưới */
            }

            .product-image {
                width: 100%; /* Đảm bảo ảnh chiếm hết chiều ngang */
                height: auto;
                object-fit: cover; /* Đảm bảo ảnh không bị méo */
                margin-bottom: 10px; /* Khoảng cách giữa ảnh và chữ */
            }

            .left-section label {
                text-align: center; /* Căn chữ giữa theo chiều ngang */
                font-weight: bold;
            }

            .import-btn {
                display: inline-block;
                padding: 10px 20px; /* Điều chỉnh kích thước nút */
                background-color: #007bff; /* Màu nền của nút */
                color: white; /* Màu chữ */
                font-size: 16px; /* Kích thước chữ */
                text-align: center;
                border: none; /* Loại bỏ viền mặc định */
                border-radius: 5px; /* Làm tròn các góc */
                cursor: pointer; /* Con trỏ chuột thành hình tay khi di chuột qua */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển đổi màu khi hover */
                text-decoration: none; /* Loại bỏ gạch chân */
            }

            .import-btn i {
                margin-right: 8px; /* Khoảng cách giữa biểu tượng và chữ */
            }

            .import-btn:hover {
                background-color: #0056b3; /* Màu nền khi hover */
            }

            .import-btn:active {
                background-color: #004080; /* Màu nền khi nhấn nút */
            }

            .import-btn:focus {
                outline: none; /* Loại bỏ viền khi được focus */
            }


        </style>
    </head>
    <body>
<%@ include file="common/sidebar.jsp" %>
        <div class="main-content">
            <% 
    String successMessage = (String) session.getAttribute("deleteSuccessMessage");
    String errorMessage = (String) session.getAttribute("deleteErrorMessage");
    
    if (successMessage != null) {
            %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
            <%
                    session.removeAttribute("deleteSuccessMessage"); // Clear the message after displaying
                }
    
                if (errorMessage != null) {
            %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
            <%
                    session.removeAttribute("deleteErrorMessage"); // Clear the message after displaying
                }
            %>
            <div id="dashboard-content" class="content-section">
                <!-- Nội dung dashboard -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>
                <div class="header-form">
                    <h2>Dashboard</h2>
                    <form action="MarketerDashboard" method="GET" class="date-form">
                        <div class="form-group">
                            <input type="date" id="startdate" name="startdate" value="${sessionScope.startDate}">
                        </div>

                        <div class="form-group">
                            <input type="date" id="enddate" name="enddate" value="${sessionScope.endDate}">
                        </div>

                        <div>
                            <button type="submit">Submit</button>
                        </div>
                    </form>
                </div>
                <div class="dashboard-cards">
                    <div class="card">
                        <div class="card-icon green">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Customers</div>
                            <div class="card-value">${sessionScope.totalCustomers}</div>
                            <div class="card-description">Total Customers for the last 7 days</div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon blue">
                            <i class="fas fa-box-open"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Products</div>
                            <div class="card-value">${sessionScope.totalProducts}</div>
                            <div class="card-description">Total Products for the last 7 days</div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon orange">
                            <i class="fas fa-file-alt"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Posts</div>
                            <div class="card-value">${sessionScope.totalBlogs}</div>
                            <div class="card-description">Total Posts for the last 7 days</div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon green">
                            <i class="fas fa-comments"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Feedbacks</div>
                            <div class="card-value">65</div>
                            <div class="card-description">Total Feedbacks for the last 7 days</div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon blue">
                            <i class="fas fa-sliders-h"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Sliders</div>
                            <div class="card-value">${sessionScope.totalSliders}</div>
                            <div class="card-description">Total Sliders for the last 7 days</div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon orange">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <div class="card-content">
                            <div class="card-title">Total Income</div>
                            <div class="card-value">72459000vnđ</div>
                            <div class="card-description">Total Income for the last 7 days</div>
                        </div>
                    </div>
                </div>

                <div class="chart-container">
                    <div class="chart">
                        <h3>New Customers for the Last 7 Days</h3>
                        <canvas id="newCustomersChart"></canvas>
                    </div>
                    <div class="chart pie-chart">
                        <h3>Product Distribution</h3>
                        <canvas id="productPieChart"></canvas>
                    </div>
                </div>
            </div>





            <!-- Nội dung product list -->
            <div id="product-list-content" class="content-section">

                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>                      
                <!-- Viết Code Vào Đây  --> 
                <div id="wrapper">
                    <div id="content-wrapper">
                        <div class="container-fluid">
                            <!-- Breadcrumbs -->
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="MarketerDashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Add Product</li>
                            </ol>
                            <%-- Hiển thị thông báo thành công nếu có --%>
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success">
                                    ${successMessage}
                                </div>
                            </c:if>

                            <!-- Add Product Card -->
                            <div class="card mb-3">

                                <form class="updateProductForm" action="EditProductServlet" method="POST" enctype="multipart/form-data">
                                    <div class="update-container">
                                        <!-- Phần bên trái: ảnh sản phẩm và cập nhật ảnh -->


                                        <!-- Phần bên phải: thông tin sản phẩm -->

                                        <!-- Bảng kích thước và tồn kho -->
                                        <table class="product-size-stock-table">
                                            <thead>
                                                <tr>
                                                    <th>Size</th>
                                                    <th>Stock</th>
                                                    <th>Hold</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.productAttributes}" var="size">
                                                    <c:if test="${size.productID == product.productID}">
                                                        <tr>
                                                            <td>${size.attributeValue}</td> <!-- Tên size -->
                                                            <td>
                                                                <input type="number" id="stock" name="stock" value="${size.stock}" class="form-control"  />


                                                            </td> <!-- Số lượng stock -->
                                                            <td>${size.hold}</td> <!-- Số lượng stock -->
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <!-- Product ID (hidden) -->
                                        <input type="hidden" id="productID1" name="productID1" value="${product.productID}" />



                                        <!-- Submit Button -->
                                        <button type="submit" name="action" value="update">Update Product</button>
                                    </div>

                                </form>


                            </div>

                        </div>
                        <!-- /.container-fluid -->

                    </div>
                    <!-- /.content-wrapper -->

                </div>

            </div>

            <a class="scroll-to-top rounded" href="#page-top">
                <i class="fas fa-angle-up"></i>
            </a>
            <div id="post-list-content" class="content-section">
                <!-- Nội dung post list -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>
                <jsp:include page="postManagement.jsp"/>
            </div>


            <div id="slider-list-content" class="content-section">
                <!-- Nội dung slider list -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>             
                </div>
                <jsp:include page="sliderManagement.jsp"/>
            </div>
            <div id="customer-list-content" class="content-section">
                <!-- Nội dung customer list -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>
                <jsp:include page="customerManagement.jsp"/>   
            </div>

            <div id="feedback-list-content" class="content-section">
                <!-- Nội dung feedback list -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>
                <jsp:include page="feedbackManagement.jsp"/>
            </div>

            <div id="change-password-content" class="content-section">  
                <!-- Nội dung change password -->
                <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>

                <!-- Form đổi mật khẩu -->
                <div class="change-password-form">
                    <h3>Change Password</h3>
                    <form action="${pageContext.request.contextPath}/changePassword" method="post">
                        <div class="form-group-pass">
                            <label for="old-password">Old Password</label>
                            <input type="password" id="old-password" name="oldPassword" placeholder="Enter old password" required>
                        </div>
                        <div class="form-group-pass">
                            <label for="new-password">New Password</label>
                            <input type="password" id="new-password" name="newPassword" placeholder="Enter new password" required>
                        </div>
                        <div class="form-group-pass">
                            <label for="confirm-password">Confirm New Password</label>
                            <input type="password" id="confirm-password" name="confirmPassword" placeholder="Confirm new password" required>
                        </div>
                        <div class="form-group-pass">
                            <button type="submit">Change Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
        <script>
                    function updateTime() {
                        var now = new Date();
                        var dateTimeString = now.toLocaleString('en-GB', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                            second: '2-digit'
                        });

                        // Update all elements with class 'current-time'
                        document.querySelectorAll('.current-time').forEach(function (element) {
                            element.innerText = dateTimeString;
                        });
                    }

                    setInterval(updateTime, 1000);
                    updateTime();
                    // Set up click event listeners for sidebar items
                    document.querySelectorAll('.sidebar ul li').forEach(item => {
                        item.addEventListener('click', function () {
                            // Remove active class from all items
                            document.querySelectorAll('.sidebar ul li').forEach(li => li.classList.remove('active'));

                            // Hide all content sections
                            document.querySelectorAll('.content-section').forEach(section => section.style.display = 'none');

                            // Add active class to clicked item
                            this.classList.add('active');

                            // Show corresponding content
                            const targetContent = document.getElementById(this.getAttribute('data-target'));
                            if (targetContent) {
                                targetContent.style.display = 'block';
                            }

                            // Store the active section in session storage
                            const activeSection = this.getAttribute('data-target');
                            sessionStorage.setItem('activeSection', activeSection);
                            console.log('Active section set to:', activeSection); // Debugging log

                            // Send the active section to the servlet
                            fetch('MarketerDashboard?activeSection=' + encodeURIComponent(activeSection))
                                    .then(response => {
                                        if (!response.ok) {
                                            throw new Error('Network response was not ok');
                                        }
                                        return response.text(); // hoặc response.json() nếu servlet trả về JSON
                                    })
                                    .then(data => {
                                        console.log("Response from servlet:", data); // In phản hồi từ servlet
                                    })
                                    .catch(error => console.error('Error:', error));
                        });
                    });

                    // Check if there's a saved active section and display it
                    const activeSection = sessionStorage.getItem('activeSection');
                    if (activeSection) {
                        // Hide all sections
                        document.querySelectorAll('.content-section').forEach(section => section.style.display = 'none');

                        // Show the saved section
                        const targetContent = document.getElementById(activeSection);
                        if (targetContent) {
                            targetContent.style.display = 'block';
                            // Set the corresponding sidebar item as active
                            const activeItem = document.querySelector(`.sidebar ul li[data-target="${activeSection}"]`);
                            if (activeItem) {
                                activeItem.classList.add('active');
                            }
                        }
                    } else {
                        // Default to displaying dashboard content
                        document.getElementById('dashboard-content').style.display = 'block';
                        document.querySelector('.sidebar ul li[data-target="dashboard-content"]').classList.add('active');
                    }

                    // confirm log out
                    function confirmLogout() {
                        return confirm("Are you sure you want to log out?");
                    }
                    //draw line chart
                    document.addEventListener('DOMContentLoaded', function () {
                        const last7Days = <%= new Gson().toJson(newCustomersDates) %>; // Dates for the last 7 days
                        const newCustomersData = <%= new Gson().toJson(newCustomersCounts) %>; // New customers count
                        // Initialize the chart
                        const ctx = document.getElementById('newCustomersChart').getContext('2d');
                        const newCustomersChart = new Chart(ctx, {
                            type: 'line', //type line chart
                            data: {
                                labels: last7Days,
                                datasets: [{
                                        label: 'New Customers',
                                        data: newCustomersData,
                                        fill: false,
                                        backgroundColor: 'rgba(231, 76, 60, 0.2)',
                                        borderColor: 'rgba(231, 76, 60, 1)',
                                        borderWidth: 2,
                                        tension: 0.4,
                                        pointRadius: 3
                                    }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        suggestedMin: 0,
                                        suggestedMax: 5,
                                        ticks: {
                                            stepSize: 1,
                                            callback: function (value) {
                                                return Number.isInteger(value) ? value : '';
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    });
                    // draw pie chart
                    document.addEventListener('DOMContentLoaded', function () {
                        // Get categories and product counts from JSP
                        const categories = <%= new Gson().toJson(categories) %>;
                        const productCounts = <%= new Gson().toJson(productCounts) %>;

                        // Initialize the pie chart
                        const ctx = document.getElementById('productPieChart').getContext('2d');
                        const productPieChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: categories, // Categories on the pie chart
                                datasets: [{
                                        label: 'Product Count by Category',
                                        data: productCounts, // Count of products per category
                                        backgroundColor: [
                                            'rgba(255, 99 , 132, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(255, 206, 86, 0.2)',
                                            'rgba(75, 192, 192, 0.2)',
                                            'rgba(153, 102, 255, 0.2)',
                                            'rgba(255, 159, 64, 0.2)'
                                        ],
                                        borderColor: [
                                            'rgba(255, 99, 132, 1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)',
                                            'rgba(75, 192, 192, 1)',
                                            'rgba(153, 102, 255, 1)',
                                            'rgba(255, 159, 64, 1)'
                                        ],
                                        borderWidth: 1
                                    }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        position: 'top',
                                    },
                                    // Data Labels plugin to show percentage
                                    datalabels: {
                                        formatter: (value, ctx) => {
                                            let sum = ctx.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                            let percentage = (value * 100 / sum).toFixed(2) + "%";
                                            return percentage;
                                        },
                                        color: 'black', // Change text color if needed
                                    }
                                }
                            },
                            plugins: [ChartDataLabels] // Enable the Data Labels plugin
                        });
                    });
        </script>
        <!-- Bootstrap core JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/assets/vendor/datatables/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendor/datatables/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/assets/js/sb-admin.min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/assets/js/demo/datatables-demo.js"></script>
        <script type="text/javascript">
                    function doDelete(id) {
                        if (confirm('Are you sure about deleting id: ' + id + '?')) {
                            window.location = 'delete?id=' + id;
                        }
                    }

        </script>


    </body>
</html>
