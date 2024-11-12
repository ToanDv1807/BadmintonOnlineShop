<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f4f7f6;
                margin: 0;
            }

            .content {
                margin: 20px auto;
                padding: 20px;
                max-width: 1200px;
                background-color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            h2 {
                color: #2c3e50;
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #2c3e50;
                color: white;
            }

            td {
                background-color: #f9f9f9;
            }

            .info-section {
                margin-bottom: 20px;
            }

            .info-section h3 {
                font-size: 20px;
                color: #2c3e50;
            }

            .info-section table {
                width: 100%;
                margin-bottom: 20px;
            }

            .form-inline {
                display: flex;
                gap: 10px;
            }

            .form-inline select,
            .form-inline button {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            button {
                background-color: #1abc9c;
                color: white;
                font-weight: bold;
                cursor: pointer;
                border: none;
                padding: 8px 15px;
            }

            button:hover {
                background-color: #16a085;
            }

            .total-cost {
                text-align: right;
                font-size: 18px;
                font-weight: bold;
                color: #2c3e50;
            }

            .back-button {
                margin-top: 20px;
                text-align: right;
            }

            .back-button button {
                background-color: #34495e;
            }

            .back-button button:hover {
                background-color: #2c3e50;
            }
        </style>
    </head>
    <body>

        <div class="content">
            <h2>Order Details</h2>

            <!-- Order Info Section -->
            <div class="info-section">
                <table>
                    <tr><th>Order ID</th><td>${order.orderID}</td></tr>
                    <tr><th>Customer Name</th><td>${order.customer.fullName}</td></tr>
                    <tr><th>Email</th><td>${order.customer.email}</td></tr>
                    <tr><th>Phone</th><td>${order.customer.phone}</td></tr>
                    <tr><th>Address</th><td>${order.customer.address}</td></tr>
                    <tr><th>Order Date</th><td>${order.orderDate}</td></tr>
                    <tr><th>Total Amount</th><td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/></td></tr>
                    <tr>
                        <th>Saler</th>
                        <td>
                            ${order.saleName}
                            <c:if test="${account.getRoleID() == 4}">
                                <form action="OrderDetail" method="POST" class="form-inline">
                                    <input type="hidden" name="orderId" value="${order.orderID}">
                                    <select name="employeeName">
                                        <c:forEach var="employee" items="${employees}">
                                            <option value="${employee.fullName}" ${employee.fullName == order.saleName ? 'selected' : ''}>
                                                ${employee.fullName} (Orders: ${employee.totalOrder})
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit">Change</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>
                            ${order.statusName}
                            <c:if test="${order.statusName ne 'Success'}">
                                <form action="OrderDetail" method="POST" class="form-inline">
                                    <input type="hidden" name="orderId" value="${order.orderID}">
                                    <select name="newStatus">
                                        <!-- Tìm trạng thái hiện tại của đơn hàng trong statusList -->
                                        <c:forEach var="status" items="${statusList}">
                                            <!-- Kiểm tra nếu status hiện tại trùng với orderStatus của order -->
                                            <c:if test="${status.statusID == order.orderStatus}">

                                                <!-- Hiển thị trạng thái trước (pre), nếu tồn tại -->
                                                <c:forEach var="s" items="${statusList}">
                                                    <c:if test="${s.statusID == status.pre}">
                                                        <option value="${s.statusID}">
                                                            ${s.statusName}
                                                        </option>
                                                    </c:if>
                                                </c:forEach>

                                                <!-- Hiển thị trạng thái hiện tại -->
                                                <option value="${status.statusID}" selected>
                                                    ${status.statusName}
                                                </option>

                                                <!-- Hiển thị trạng thái tiếp theo (post), nếu tồn tại -->
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
                                    <button type="submit">Change</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                    <tr><th>Note</th><td>${order.note}</td></tr>
                </table>
            </div>

            <!-- Ordered Products Section -->
            <div class="info-section">
                <h3>Ordered Products</h3>
                <table>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Total Cost</th>
                    </tr>
                    <c:forEach var="detail" items="${order.orderDetails}">
                        <tr>
                            <td>${detail.product.productID}</td>
                            <td>${detail.product.productName}</td>
                            <td>${detail.category}</td>
                            <td>${detail.quantity}</td>
                            <td><fmt:formatNumber value="${detail.product.price}" type="number" groupingUsed="true"/></td>
                            <td><fmt:formatNumber value="${detail.quantity * detail.product.price}" type="number" groupingUsed="true"/></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="total-cost">
                Total: <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
            </div>

            <div class="back-button">
                <button onclick="goBack()">Back</button>
            </div>
        </div>

        <script>
            function goBack() {
                window.history.back();
            }
        </script>

    </body>
</html>
