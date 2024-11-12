<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Error Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .error-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .error-container h1 {
                color: #d9534f;
                font-size: 48px;
                margin-bottom: 10px;
            }

            .error-container p {
                color: #5a5a5a;
                font-size: 18px;
                margin-bottom: 20px;
            }

            .error-container a {
                text-decoration: none;
                color: #fff;
                background-color: #5bc0de;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 16px;
            }

            .error-container a:hover {
                background-color: #31b0d5;
            }
        </style>
    </head>
    <body>

        <div class="error-container">
            <h1>Error Occurred</h1>
            <p>${errorMessage}</p>
            <a href="EditProduct">Go Back</a>
        </div>

    </body>
</html>

