<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Warehouse order list - Menu</title>
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

            /*            .sidebar {
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
            
                        .sidebar ul {
                            list-style: none;
                            padding: 0;
                        }
            
                        .sidebar ul li {
                            padding: 15px 20px;
                            cursor: pointer;
                            display: flex;
                            align-items: center;
                            color: #ecf0f1;  Text color 
                            transition: background-color 0.3s ease, color 0.3s ease;  Smooth transitions 
                            border-left: 4px solid transparent;  Border indicator 
                        }
            
                        .sidebar ul li:hover {
                            background-color: #34495e;  Hover background 
                            color: #1abc9c;  Hover text color 
                            border-left: 4px solid #1abc9c;  Highlighted left border 
                        }
            
                        .sidebar ul li i {
                            margin-right: 10px;
                            font-size: 18px;  Icon size 
                            transition: color 0.3s ease;  Smooth transition for icons 
                        }
            
                        .sidebar ul li:hover i {
                            color: #1abc9c;  Change icon color on hover 
                        }
            
                        .sidebar ul li.active {
                            background-color: #e74c3c;  Active background color 
                            color: white;  Active text color 
                            border-left: 4px solid #e74c3c;  Active left border 
                        }
            
                        .sidebar ul li.active i {
                            color: white;  Icon color in active state 
                        }
            
                        .sidebar ul li.logout {
                            background-color: #c0392b;  Logout button default color 
                            transition: background-color 0.3s ease;
                        }
            
                        .sidebar ul li.logout:hover {
                            background-color: darkred;  Darker red on hover 
                        }*/


            /* Fix header and search form positioning */
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                /*                margin-left: 250px;  Fixed margin to avoid sidebar overlap */
            }

            /*            .header .logo {
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
                        }*/

            /* Content alignment */
            .content {
                /*                margin-left: 250px;*/
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            /* Additional styling for the search section */
            .filter-section {
                display: flex;
                /*                                justify-content: flex-start;*/
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
                /*                max-width: 1200px;*/
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
        <!--        <div class="sidebar">
                    <div class="profile" style="display: flex; align-items: center; margin-bottom: 12px">
                        <img alt="Profile Picture" src="https://cdn.icon-icons.com/icons2/2560/PNG/512/woman_user_avatar_account_female_icon_153149.png"/>
                        <div style="display: flex; flex-direction: column; margin-left: 15px;">
                            <h5 style="margin: 0;">User Name</h5>
                            <div style="display: flex; align-items: center;">
                                <span style="display: inline-block; width: 10px; height: 10px; background-color: #1abc9c; border-radius: 50%; margin-right: 5px;"></span>
                                <h6 style="color: #1abc9c; margin: 0; margin-top: 5px;">Online</h6>
                            </div>
                        </div>
                    </div>
                    <ul>
                        <li class="active">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </li>
                        <li class="active"><a href="warehouseOrderList"><i class="fas fa-th"></i> Order List</a></li>
                        <li>
                            <i class="fas fa-key"></i> Change Password
                        </li>
                        <a href="logout" onclick="return confirm('Are you sure you want to log out?')">
                            <li class="logout">
                                <i class="fas fa-sign-out-alt"></i> Log Out
                            </li>
                        </a>
                    </ul>
                </div>-->

        <!--        <div class="header">
                    <div class="logo">
                        <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                        <h2>Badminton Online Shop</h2>
                    </div>
                    <div class="current-time">
                        <span id="currentDateTime"></span>
                    </div>
                </div>-->

        <!-- Bo loc va tim kiem -->
        <div class="filter-section">
            <form action="WarehouseServlet" method="GET" style="margin-left: 23%">
                <input style="width: 300px ; padding: 5px;" type="text" name="query" placeholder="Search by Order ID or Customer Name" value="${param.query}">

                <label style="margin-top: 5px" for="fromDate">From Date:</label>
                <input  type="date" name="fromDate" value="${param.fromDate}" style="width: 200px; padding: 5px;">

                <label style="margin-top: 5px" for="toDate">To Date:</label>
                <input  type="date" name="toDate" value="${param.toDate}" style="width: 200px; padding: 5px;">

                <button type="submit">Search</button>
            </form>
        </div>


        <!-- Content Section -->
        <div class="content">
            <div class="orders">
                <h2 style="text-align:center">Orders list</h2>
                <!-- Nút b?m Status -->
                <div class="status-buttons" style="text-align: center; margin-top: 20px;">
                    <a href="WarehouseServlet" class="status-button"> All </a>
                    <c:forEach var="status" items="${sessionScope.statusOrderList}">
                        <c:if test="${status.status eq 1}">
                            <a href="WarehouseServlet?status=${status.statusID}&query=${param.query}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="status-button ${param.status == status.statusID ? 'active' : ''}">
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="orderTableBody">
                        <c:forEach items="${sessionScope.listOrderList}" var="listOrder">
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

                                <!--                                <td>
                                                                    <form action="WarehouseServlet" method="POST" style="display: flex; align-items: center; gap: 10px;">
                                                                        <input type="hidden" name="orderID" value="${listOrder.orderID}">
                                                                        <div class="custom-select-wrapper">
                                                                            <select name="newStatus" class="custom-select">
                                <c:forEach var="status" items="${sessionScope.statusOrderList}">
                                    <c:if test="${status.status eq 1}">
                                        <option value="${status.statusID}" ${listOrder.statusName == status.statusName ? 'selected' : ''}>
                                        ${status.statusName}
                                    </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="change-btn">Change</button>
                    </form>

                </td>-->

                                <c:if test="${listOrder.statusName eq 'Success'}">
                                    <td>Success</td>
                                </c:if>
                                <c:if test="${listOrder.statusName eq 'Canceled'}">
                                    <td>Canceled</td>
                                </c:if>
                                <c:if test="${listOrder.statusName ne 'Success' && listOrder.statusName ne 'Canceled'}">
                                    <td>
                                        <form action="WarehouseServlet" method="POST" style="display: flex; align-items: center; gap: 10px;">
                                            <input type="hidden" name="orderID" value="${listOrder.orderID}">
                                            <div class="custom-select-wrapper">
                                                <select name="newStatus" class="custom-select">
                                                    <c:forEach var="status" items="${sessionScope.statusOrderList}">
                                                        <!-- Ki?m tra n?u tr?ng thái hi?n t?i c?a listOrder kh?p -->
                                                        <c:if test="${status.statusID == listOrder.orderStatus}">
                                                            <c:forEach var="s" items="${sessionScope.statusOrderList}">
                                                                <!-- Tr??ng h?p ??c bi?t khi statusID là 6 -->
                                                                <c:if test="${status.statusID == 6}">
                                                                    <c:if test="${s.statusID == 7 || s.statusID == 8}">
                                                                        <option value="${s.statusID}" ${listOrder.orderStatus == s.statusID ? 'selected' : ''}>
                                                                            ${s.statusName}
                                                                        </option>
                                                                    </c:if>
                                                                </c:if>
                                                                <!-- V?i các tr?ng thái khác, hi?n th? tr?ng thái pre, post và tr?ng thái hi?n t?i nh? bình th??ng -->
                                                                <c:if test="${status.statusID != 6}">
                                                                    <c:if test="${s.statusID == status.pre || s.statusID == status.post || s.statusID == status.statusID}">
                                                                        <option value="${s.statusID}" ${listOrder.orderStatus == s.statusID ? 'selected' : ''}>
                                                                            ${s.statusName}
                                                                        </option>
                                                                    </c:if>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit" class="change-btn">Change</button>
                                        </form>
                                    </td>
                                </c:if>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="pagination">
                    <c:forEach begin="1" end="${sessionScope.endOrderList}" var="i">
                        <c:choose>
                            <c:when test="${not empty param.query or not empty param.fromDate or not empty param.toDate or not empty param.status}">
                                <a href="WarehouseServlet?page=${i}&query=${param.query}&fromDate=${param.fromDate}&toDate=${param.toDate}&status=${param.status}" class="${i == sessionScope.currentPageOrderList ? 'page-link active' : 'page-link'}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="WarehouseServlet?page=${i}" class="${i == sessionScope.currentPageOrderList ? 'page-link active' : 'page-link'}">${i}</a>
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
