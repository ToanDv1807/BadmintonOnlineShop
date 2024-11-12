<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Slider</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 60%;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            }
            input[type="text"], input[type="file"], select, textarea {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            textarea {
                resize: vertical;
            }
            .buttons {
                margin-top: 30px;
                display: flex;
                justify-content: space-between;
            }
            button {
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
            .save-btn {
                background-color: #28a745;
                color: white;
            }
            .save-btn:hover {
                background-color: #218838;
            }
            .back-btn {
                background-color: #6c757d;
                color: white;
                text-decoration: none;
                padding: 12px 20px;
                display: inline-block;
                text-align: center;
                border-radius: 5px;
            }
            .back-btn:hover {
                background-color: #5a6268;
            }
            .message {
                color: green;
                margin-bottom: 15px;
                font-size: 18px;
                border: 1px solid green;
                padding: 10px;
                background-color: #e6ffe6;
                border-radius: 4px;
                transition: opacity 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Edit Slider</h2>
            <c:if test="${not empty sessionScope.message}">
                <h3 id="messageDiv" class="message">${sessionScope.message}</h3>
                <script>
                    // Remove the message from session after it's displayed
                    window.onload = function () {
                        setTimeout(function () {
                            document.getElementById('messageDiv').style.display = 'none';
                            // Clear the message from the session
                    <%
                                session.removeAttribute("message");
                    %>
                        }, 3000);
                    };
                </script>
            </c:if>

            <form action="edit-slider" method="POST" enctype="multipart/form-data">
                <!-- Slider ID (hidden) -->
                <input type="hidden" name="sliderID" value="${slider.sliderID}">

                <!-- Title -->
                <div class="form-group">
                    <label for="title">Slider Title:</label>
                    <input type="text" id="title" name="title" value="${slider.title}" required>
                </div>

                <!-- Image File Upload -->
                <div class="form-group">
                    <label for="image">Current Slider Image:</label>
                    <div>
                        <img src="assets/images/product-section-slider/${slider.sliderImgUrl}" alt="Slider Image" style="max-width: 100%; height: auto; margin-bottom: 10px;">
                    </div>
                </div>

                <div class="form-group">
                    <label for="image">Upload New Image:</label>
                    <input type="file" id="image" name="image" accept="image/*">
                </div>

                <!-- Backlink -->
                <div class="form-group">
                    <label for="backlink">Backlink URL:</label>
                    <input type="text" id="backlink" name="backlink" value="${slider.backlink}">
                </div>

                <!-- Status -->
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="1" ${slider.status == 1 ? 'selected' : ''}>Show</option>
                        <option value="0" ${slider.status == 0 ? 'selected' : ''}>Hide</option>
                    </select>
                </div>

                <!-- Note -->
                <div class="form-group">
                    <label for="note">Note:</label>
                    <textarea id="note" name="note" rows="4">${slider.notes}</textarea>
                </div>

                <!-- Buttons -->
                <div class="buttons">
                    <button type="submit" class="save-btn">Save Changes</button>
                    <a href="MarketerDashboard" class="back-btn">Back to Dashboard</a>
                </div>
            </form>
        </div>
    </body>
</html>
