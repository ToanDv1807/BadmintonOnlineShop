<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("account");
%>
<html>
    <head>
        <title>Sale Manager OrderList - Menu</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">   
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }

            .sidebar {
                width: 250px;
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

            .sidebar .profile h5 {
                margin: 10px 0 5px;
                font-size: 18px;
            }

            .sidebar .profile h6 {
                font-size: 14px;
            }

            .sidebar ul li {
                padding: 15px 20px;
                display: flex;
                align-items: center;
                transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transitions */
            }

            .sidebar ul li a {
                text-decoration: none;
                color: #ecf0f1; /* White text color */
                display: flex;
                align-items: center;
                width: 100%; /* Make the entire list item clickable */
                transition: color 0.3s ease; /* Smooth color transition */
            }

            .sidebar ul li:hover {
                background-color: #34495e; /* Hover background */
            }

            .sidebar ul li a:hover {
                color: #1abc9c; /* Hover text color */
            }

            .sidebar ul li i {
                margin-right: 10px;
                font-size: 18px; /* Icon size */
                transition: color 0.3s ease; /* Smooth transition for icons */
            }

            .sidebar ul li a:hover i {
                color: #1abc9c; /* Change icon color on hover */
            }

            /* Fix header and search form positioning */
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-left: 250px; /* Fixed margin to avoid sidebar overlap */
            }

            .header .logo {
                display: flex;
                align-items: center;
            }

            .header .logo img {
                width: 40px;
                margin-right: 10px;
            }

            .header form {
                margin: 0;
            }

            .header input[type="text"] {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
                width: 200px;
            }

            .header button {
                padding: 8px 15px;
                background-color: #1abc9c;
                border: none;
                border-radius: 5px;
                color: white;
                font-weight: bold;
                cursor: pointer;
            }

            .header button:hover {
                background-color: #16a085;
            }

            /* Content alignment */
            .content {
                margin-left: 250px;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            /* Additional styling for the search section */
            .filter-section {
                display: flex;
                justify-content: flex-start;
                align-items: center;
                gap: 10px;
                margin: 20px 0;
                padding-bottom: 10px;
                border-bottom: 1px solid #ddd;
            }

            .filter-section form {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            /* Orders table styling */
            .orders {
                width: 100%;
                max-width: 1200px;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0e0e0;
                margin: 0 auto; /* Canh gi?a */
                overflow-x: auto; /* ?? có thanh cu?n khi c?n */
            }

            .order-table {
                width: 100%;
                border-collapse: collapse;
            }

            .order-table th {
                background-color: #333;
                color: #ffffff;
                font-weight: bold;
                padding: 12px;
                text-align: left; /* C?n trái cho tiêu ?? */
            }

            .order-table td {
                padding: 12px;
                color: #333;
                border-bottom: 1px solid #e0e0e0;
                text-align: left; /* C?n trái cho các ô */
            }

            .order-table tr:hover {
                background-color: #f1f1f1;
            }

            .pagination {
                display: flex;
                justify-content: center;
                padding: 10px 0;
            }

            .pagination a {
                margin: 0 5px;
                padding: 8px 16px;
                border: 1px solid #e0e0e0;
                color: #333;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .pagination a.active {
                background-color: #333;
                color: #ffffff;
                border: 1px solid #333;
            }

            .pagination a:hover {
                background-color: #e0e0e0;
                color: #333;
            }

            .custom-select-wrapper {
                position: relative;
                width: 150px;
            }

            .custom-select {
                width: 100%;
                padding: 5px 10px;
                font-size: 14px;
                border: 1px solid #e0e0e0;
                border-radius: 5px;
                cursor: pointer;
            }

            .change-btn {
                padding: 5px 10px;
                background-color: #1abc9c;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .change-btn:hover {
                background-color: #16a085;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .order-table th, .order-table td {
                    padding: 8px;
                }

                .custom-select-wrapper {
                    width: 100px;
                }

                .change-btn {
                    font-size: 14px;
                    padding: 4px 8px;
                }
            }
            .status-buttons {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .status-button {
                padding: 8px 16px;
                background-color: #1abc9c;
                color: white;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 2%;
            }

            .status-button:hover {
                background-color: #16a085;
            }

            .status-button.active {
                background-color: #333;
                color: white;
            }


        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="common/sidebar.jsp" %>

        <div class="header">
            <div class="logo">
                <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                <h2>Badminton Online Shop</h2>
            </div>
            <div class="current-time">
                <span id="currentDateTime"></span>
            </div>
        </div>

        <!-- Bo loc va tim kiem -->
        <div class="filter-section">
            <form action="SaleManagerOrderList" method="GET" style="margin-left: 23%">
                <input type="text" name="query" placeholder="Search" value="${param.query}">
                <label for="fromDate">From Date:</label>
                <input type="date" name="fromDate" value="${param.fromDate}">

                <label for="toDate">To Date:</label>
                <input type="date" name="toDate" value="${param.toDate}">

                <button type="submit">Search</button>
            </form>
        </div>

        <!-- Content Section -->
        <div class="content">
            <div class="orders">
                <h2 style="text-align:center">Orders list</h2>
                <!-- Nút b?m Status -->
                <div class="status-buttons" style="text-align: center; margin-top: 20px;">
                    <a href="SaleManagerOrderList" class="status-button"> All </a>
                    <c:forEach var="status" items="${statusList}">
                        <c:if test="${status.status eq 1}">
                            <a href="SaleManagerOrderList?status=${status.statusID}&query=${param.query}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="status-button ${param.status == status.statusID ? 'active' : ''}">
                                ${status.statusName}
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th class="sortable" onclick="sortTable(0)">Order ID</th>
                            <th class="sortable" onclick="sortTable(1)">Customer name</th>
                            <th class="sortable" onclick="sortTable(2)">Ordered Date</th>
                            <th class="sortable" onclick="sortTable(3)">Product</th>
                            <th class="sortable" onclick="sortTable(5)">Total Cost (vnd)</th>
                            <th class="sortable" onclick="sortTable(6)">Status</th>
                            <th class="sortable" >Saler</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="orderTableBody">
                        <c:forEach items="${list}" var="listOrder">
                            <tr class="order-row">
                                <td><a href="OrderDetail?orderId=${listOrder.orderID}">${listOrder.orderID}</a></td>
                                <td>${listOrder.fullName}</td>
                                <td>${listOrder.orderDate}</td>
                                <td>${listOrder.productName}</td>
                                <td><fmt:formatNumber value="${listOrder.totalAmount}" type="number" groupingUsed="true"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty listOrder.statusName}">
                                            ${listOrder.statusName}
                                        </c:when>
                                        <c:otherwise>Unknown Status</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${listOrder.saleName}</td>
                                <td>

                                    <c:if test="${listOrder.statusName ne 'Success'}">
                                        <form action="SaleManagerOrderList" method="POST" style="display: flex; align-items: center; gap: 10px;">
                                            <input type="hidden" name="orderID" value="${listOrder.orderID}">
                                            <div class="custom-select-wrapper">
                                                <select name="newStatus" class="custom-select">
                                                    <!-- Iterate over statusList to find the current status of the order -->
                                                    <!-- Tìm tr?ng thái hi?n t?i c?a ??n hàng trong statusList -->
                                                    <c:forEach var="status" items="${statusList}">
                                                        <!-- Ki?m tra n?u status hi?n t?i trùng v?i orderStatus c?a listOrder -->
                                                        <c:if test="${status.statusID == listOrder.orderStatus}">

                                                            <!-- Hi?n th? tr?ng thái tr??c (pre), n?u t?n t?i -->
                                                            <c:forEach var="s" items="${statusList}">
                                                                <c:if test="${s.statusID == status.pre}">
                                                                    <option value="${s.statusID}">
                                                                        ${s.statusName}
                                                                    </option>
                                                                </c:if>
                                                            </c:forEach>

                                                            <!-- Hi?n th? tr?ng thái hi?n t?i -->
                                                            <option value="${status.statusID}" selected>
                                                                ${status.statusName}
                                                            </option>

                                                            <!-- Hi?n th? tr?ng thái ti?p theo (post), n?u t?n t?i -->
                                                            <c:forEach var="s" items="${statusList}">
                                                                <c:if test="${s.statusID == status.post}">
                                                                    <option value="${s.statusID}">
                                                                        ${s.statusName}
                                                                    </option>
                                                                </c:if>
                                                            </c:forEach>

                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit" class="change-btn">Change</button>
                                        </form>
                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="pagination">
                    <c:forEach begin="1" end="${endP}" var="i">
                        <c:choose>
                            <c:when test="${not empty param.query or not empty param.fromDate or not empty param.toDate or not empty param.status}">
                                <a href="SaleManagerOrderList?page=${i}&query=${param.query}&fromDate=${param.fromDate}&toDate=${param.toDate}&status=${param.status}" class="${i == currentPage ? 'page-link active' : 'page-link'}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="SaleManagerOrderList?page=${i}" class="${i == currentPage ? 'page-link active' : 'page-link'}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
        </div>


        <!-- Time Update Script -->
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
                document.querySelector('.current-time').innerText = dateTimeString;
            }

            setInterval(updateTime, 1000);
            updateTime();
        </script>
        <!-- JavaScript to sort the table -->
        <script>
            function sortTable(n) {
                var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                table = document.querySelector(".order-table");
                switching = true;
                // Set the sorting direction to ascending:
                dir = "asc";

                /* Make a loop that will continue until no switching has been done: */
                while (switching) {
                    // Start by saying: no switching is done:
                    switching = false;
                    rows = table.rows;
                    /* Loop through all table rows (except the first, which contains table headers): */
                    for (i = 1; i < (rows.length - 1); i++) {
                        // Start by saying there should be no switching:
                        shouldSwitch = false;
                        /* Get the two elements you want to compare, one from current row and one from the next: */
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];
                        /* Check if the two rows should switch place, based on the direction, asc or desc: */
                        if (dir == "asc") {
                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                // If so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        } else if (dir == "desc") {
                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                // If so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        }
                    }
                    if (shouldSwitch) {
                        /* If a switch has been marked, make the switch and mark that a switch has been done: */
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                        // Each time a switch is done, increase this count by 1:
                        switchcount++;
                    } else {
                        /* If no switching has been done AND the direction is "asc", set the direction to "desc" and run the while loop again. */
                        if (switchcount == 0 && dir == "asc") {
                            dir = "desc";
                            switching = true;
                        }
                    }
                }
            }
        </script>
    </body>
</html>
