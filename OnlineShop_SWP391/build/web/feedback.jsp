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

            .rating-stars {
                display: flex;
                gap: 5px;
            }

            .rating-stars input {
                display: none;
            }

            .rating-stars label {
                cursor: pointer;
                font-size: 24px;
                color: #ddd;
            }

            .rating-stars input:checked ~ label,
            .rating-stars label:hover,
            .rating-stars label:hover ~ label {
                color: #ffcc00;
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
            .rating-stars {
                display: flex;
                gap: 5px;
                direction: rtl; /* Display stars in reverse order */
            }

            .rating-stars input {
                display: none;
            }

            .rating-stars label {
                cursor: pointer;
                font-size: 24px;
                color: #ddd;
            }

            .rating-stars input:checked ~ label,
            .rating-stars label:hover,
            .rating-stars label:hover ~ label {
                color: #ffcc00;
            }

            /* Thêm CSS để áp dụng màu từ sao đã chọn trở về bên trái */
            .rating-stars input:checked ~ label,
            .rating-stars input:checked ~ label ~ label {
                color: #ffcc00;
            }
            rating-stars{
                margin-right: 40%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="common/header.jsp"></jsp:include>
            <div class="button-group">
                <a href="viewProductToFeedback?orderID=${sessionScope.orderID}" class="btn-back">Back to Feedback</a>
        </div>

        <div class="edit-feedback-container">
            <h2>Edit Feedback</h2>

            <form action="submitFeedback" method="POST">
                <!-- Hidden inputs to pass feedback ID and product ID -->
                <input type="hidden" name="productID" value="${productID}">
                <input type="hidden" name="attributeValue" value="${attributeValue}">

                <!-- Rating stars -->
                <div class="form-groupr">
                    <label for="rating">Your Rating</label>
                    <div class="rating-stars">
                        <input type="radio" name="rating" value="5" id="star5">
                        <label for="star5">★</label>

                        <input type="radio" name="rating" value="4" id="star4">
                        <label for="star4">★</label>

                        <input type="radio" name="rating" value="3" id="star3">
                        <label for="star3">★</label>

                        <input type="radio" name="rating" value="2" id="star2">
                        <label for="star2">★</label>

                        <input type="radio" name="rating" value="1" id="star1">
                        <label for="star1">★</label>
                    </div>
                </div>



                <!-- Comment section -->
                <div class="form-group">
                    <label for="comment">Your Comment</label>
                    <textarea name="comment" id="comment" required></textarea>
                </div>

                <!-- Button group with Submit and Back buttons -->

                <input type="submit" class="btn-submit" value="Add new Feedback">

            </form>

            <!-- Feedback message -->
            <div class="message">
                ${sessionScope.mess}
            </div>
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
