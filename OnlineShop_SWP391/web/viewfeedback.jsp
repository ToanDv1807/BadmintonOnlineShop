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
        </style>
    </head>
    <body>
        <jsp:include page="common/header.jsp"></jsp:include>
            <div class="button-group">

                <!-- Back to Product Detail Button -->
                <a href="viewProductToFeedback?orderID=${sessionScope.orderID}" class="btn-back">Back to Select product</a>
        </div>
        <div class="edit-feedback-container">
            <h2>Your all feedback of this product</h2>
            <table id="feedbackTable" class="table table-bordered" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>RATED STAR</th>
                        <th>FEEDBACK CONTENT</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop hiển thị danh sách feedback -->
                    <c:forEach items="${list}" var="f">

                        <tr>
                            <td>${f.rated}</td>
                            <td>${f.content}</td>
                            <td>
                                <a href="editFeedback?feedbackID=${f.feedbackID}&attributeValue=${attributeValue}&orderID=${sessionScope.orderID}">Edit</a>
                            </td>
                        </c:forEach>
                    </tr>
                </tbody>
            </table

            <!-- Button group with Submit and Back buttons -->

                       <a>${sessionScope.messReviewUpdate}</a>

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
