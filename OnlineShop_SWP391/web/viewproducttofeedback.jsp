<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f7f7f7;
            }

            .edit-feedback-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                font-weight: bold;
                color: #333;
            }

            textarea, input[type="text"], input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }


            .form-group textarea {
                height: 150px;
            }

            .btn-submit {
                background-color: #3498db;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
                padding: 10px 20px;
                border-radius: 5px;
                margin-top: 10px;
            }

            .btn-submit:hover {
                background-color: #2980b9;
            }

            .btn-back {
                display: inline-block;
                background-color: #555;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                text-align: center;
                text-decoration: none;
                margin-top: 10px;
            }

            .btn-back:hover {
                background-color: #333;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 200px;
                margin-left: 200px;
            }

            .message {
                margin-top: 15px;
                color: green;
                text-align: center;
                font-weight: bold;
            }
            .btn-action {
                display: inline-block;
                padding: 8px 12px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                color: white;
                margin-right: 5px;
                transition: background-color 0.3s;
            }

            .feedback-btn {
                background-color: #3498db; /* Blue */
            }

            .feedback-btn:hover {
                background-color: #2980b9; /* Darker blue */
            }

            .view-btn {
                background-color: #2ecc71; /* Green */
            }

            .view-btn:hover {
                background-color: #27ae60; /* Darker green */
            }

            .edit-btn {
                background-color: #f39c12; /* Orange */
            }

            .edit-btn:hover {
                background-color: #e67e22; /* Darker orange */
            </style>
        </head>
        <body>
            <jsp:include page="common/header.jsp"></jsp:include>
                <div class="button-group">

                    <!-- Back to Product Detail Button -->
                    <a href="myOrder" class="btn-back">Back to Orders</a>
                </div>
                <div class="edit-feedback-container">
                    <h2>Select product to feedback</h2>
                    <table id="feedbackTable" class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Attribute Value</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Loop hiển thị danh sách feedback -->
                        <c:forEach items="${listP}" var="p">
                            <tr>
                                <td>${p.productID}</td>
                                <td>${p.productName}</td>
                                <td>${p.attributeValue}</td>
                                <td>
                                    <!-- Set default eligibility to false -->
                                    <c:set var="isEligibleForFeedback" value="true" />

                                    <!-- Check if product is eligible for feedback -->
                                    <c:forEach var="eligibleProduct" items="${feedbackEligibleProducts}">
                                        <c:if test="${p.productID == eligibleProduct.productID && p.attributeValue == eligibleProduct.attributeValue}">
                                            <c:set var="isEligibleForFeedback" value="false" />
                                        </c:if>
                                    </c:forEach>

                                    <!-- Conditionally show the Feedback button if eligible -->
                                    <c:if test="${isEligibleForFeedback}">
                                        <a href="submitFeedback?productID=${p.productID}&attributeValue=${p.attributeValue}" class="btn-action feedback-btn">Feedback</a>
                                    </c:if>

                                    <!-- Always show the View button -->
                                    <a href="viewFeedback?productID=${p.productID}&attributeValue=${p.attributeValue}&orderID=${sessionScope.orderID}" class="btn-action view-btn">View</a>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table

                <!-- Button group with Submit and Back buttons -->
                <a>${sessionScope.messReview}</a>

            </div>

            <jsp:include page="common/footer.jsp"></jsp:include>

                <!-- Plugins JS File -->
                <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

            <!-- Main JS File -->
            <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
        </body>
    </html>
