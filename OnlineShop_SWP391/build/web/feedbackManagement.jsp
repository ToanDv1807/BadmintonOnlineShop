<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Management</title>
        <style>
            .pagination {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
                padding: 0;
                list-style: none;
            }

            .pagination a {
                color: black;
                background-color: white;
                border: 1px solid #ddd;
                padding: 8px 16px;
                text-decoration: none;
                margin: 0 5px;
                border-radius: 5px;
                font-weight: 500;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .pagination a:hover {
                background-color: #f0f0f0;
            }

            .pagination a.active {
                background-color: white;
                color: black;
                border: 1px solid black;
            }

            form input[type="checkbox"] {
                width: 20px;
                height: 20px;
                cursor: pointer;
                accent-color: #4CAF50;
                margin-right: 10px;
            }

            th a {
                cursor: pointer;
                text-decoration: none;
                color: black;
            }

            th a:hover {
                color: #4CAF50;
            }

            a.table-action-link {
                display: inline-block;
                padding: 5px 10px;
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
                font-size: 13px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            a.table-action-link:hover {
                background-color: #0056b3;
            }

            /* Widen productFilter input for responsiveness */
            #productFilter {
                width: 185%; /* Flexible width for responsiveness */
                max-width: 300%;
            }
            .form-group select {
                width: 104%; /* Full width for responsiveness */
                max-width: 300px; /* Optional: limit max width */
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
                background-color: #fff;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            /* Style focus state for better accessibility */
            .form-group select:focus {
                border-color: #4CAF50; /* Change color to highlight */
                outline: none;
            }

            /* Optional: spacing between form-group elements */
            .form-group {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <h1>Feedback Management</h1>
        <div class="container">
            <div class="card-body">
                <div class="table-responsive">
                    <!-- Search and Filter Form -->
                    <form method="get" action="MarketerDashboard" class="search-container">
                        <div class="form-group">
                            <label for="productFilter">FullName or Feedback's Content:</label>
                            <input type="text" name="productFilter" id="productFilter" 
                                   placeholder="Search by name or feedback content" 
                                   value="${param.productFilter}">
                        </div>

                        <div class="form-group">
                            <label for="filterfp">Filter by Product Name:</label>
                            <select name="filterfp" id="filterfp" class="form-control">
                                <option value="" ${param.filterfp == '' ? 'selected' : ''}>Select a product</option>
                                <c:forEach items="${sessionScope.listp}" var="p">
                                    <option value="${p}" ${param.filterfp == p ? 'selected' : ''}>${p}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="filterfr">Filter by Rated Star:</label>
                            <select name="filterfr" id="filterfr" class="form-control">
                                <option value="" ${param.filterfr == '' ? 'selected' : ''}>Select a rating</option>
                                <option value="1" ${param.filterfr == '1' ? 'selected' : ''}>1</option>
                                <option value="2" ${param.filterfr == '2' ? 'selected' : ''}>2</option>
                                <option value="3" ${param.filterfr == '3' ? 'selected' : ''}>3</option>
                                <option value="4" ${param.filterfr == '4' ? 'selected' : ''}>4</option>
                                <option value="5" ${param.filterfr == '5' ? 'selected' : ''}>5</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Search & Filter</button>
                    </form>

                    <!-- Bảng dữ liệu -->
                    <table id="feedbackTable" class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th><a href="#" onclick="sortTable(0)">ID</a></th>
                                <th><a href="#" onclick="sortTable(1)">CUSTOMER'S NAME</a></th>
                                <th><a href="#" onclick="sortTable(2)">PRODUCT'S NAME</a></th>
                                <th><a href="#" onclick="sortTable(3)">RATED STAR</a></th>
                                <th>FEEDBACK CONTENT</th>
                                <th>FEEDBACK DATE</th>
                                <th>STATUS</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Loop hiển thị danh sách feedback -->
                            <c:forEach items="${sessionScope.listFeedback}" var="f">
                                <tr>
                                    <td>${f.feedbackID}</td>
                                    <td>${f.customerName}</td>
                                    <td>${f.productName}</td>
                                    <td>${f.rated}</td>
                                    <td>${f.content}</td>
                                    <td>${f.feedbackDate}</td>
                                    <td>
                                        <form action="MarketerDashboard" method="post">
                                            <!-- Hidden inputs để lưu trữ thông tin cần thiết -->
                                            <input type="hidden" name="feedbackID" value="${f.feedbackID}">
                                            <input type="hidden" name="currentPagef" value="${sessionScope.currentPagef}">
                                            <input type="hidden" id="fbstatus-${f.feedbackID}" name="fbstatus" value="${f.status}">

                                            <!-- Checkbox để chọn trạng thái và gửi khi thay đổi -->
                                            <input type="checkbox"
                                                   name="statusf"
                                                   value="${f.status}"
                                                   ${f.status == 1 ? 'checked' : ''}
                                                   onchange="document.getElementById('fbstatus-${f.feedbackID}').value = this.checked ? 1 : 2; this.form.submit();">
                                        </form>
                                    </td>
                                    <td>
                                        <a href="feedbackDetail?feedbackID=${f.feedbackID}">View</a>
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Phân trang -->
                    <div class="pagination">
                        <c:forEach begin="1" end="${sessionScope.endPf}" var="i">
                            <a href="MarketerDashboard?pagef=${i}&filterfr=${sessionScope.filterfr}&filterfp=${sessionScope.filterfp}&productFilter=${sessionScope.productFilter}" 
                               class="${i == sessionScope.currentPagef ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <!-- Script sắp xếp bảng -->
    <script>
        function sortTable(columnIndex) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchCount = 0;
            table = document.getElementById("feedbackTable");
            switching = true;
            dir = "asc"; // Thiết lập hướng sắp xếp ban đầu là tăng dần (ascending)

            while (switching) {
                switching = false;
                rows = table.rows;
                // Lặp qua tất cả các hàng (trừ hàng đầu tiên là header)
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    // Lấy hai phần tử cần so sánh từ cột hiện tại
                    x = rows[i].getElementsByTagName("TD")[columnIndex];
                    y = rows[i + 1].getElementsByTagName("TD")[columnIndex];

                    // Kiểm tra xem có cần đổi chỗ không, tùy vào hướng sắp xếp
                    if (dir === "asc") {
                        if (columnIndex === 0 || columnIndex === 3) {
                            // Nếu cột là số (ID hoặc RATED STAR), so sánh số
                            if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
                                shouldSwitch = true;
                                break;
                            }
                        } else {
                            // Nếu là cột chữ (CUSTOMER'S NAME hoặc PRODUCT'S NAME), so sánh chuỗi
                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        }
                    } else if (dir === "desc") {
                        if (columnIndex === 0 || columnIndex === 3) {
                            // So sánh số cho các cột là số
                            if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
                                shouldSwitch = true;
                                break;
                            }
                        } else {
                            // So sánh chữ cho các cột là chuỗi
                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        }
                    }
                }
                if (shouldSwitch) {
                    // Nếu cần đổi chỗ, thực hiện việc đổi chỗ và đánh dấu đã có sự thay đổi
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchCount++;
                } else {
                    // Nếu không có đổi chỗ nào và hướng đang là "asc", đổi sang "desc"
                    if (switchCount === 0 && dir === "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
    </script>
</html>
