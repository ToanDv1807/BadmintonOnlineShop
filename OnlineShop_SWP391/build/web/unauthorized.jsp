<%-- 
    Document   : unauthorized
    Created on : 5 thg 10, 2024, 19:53:16
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Access denied</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                text-align: center;
                background-color: #fff;
                padding: 50px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
            }
            h1 {
                color: #e74c3c;
                font-size: 24px;
                margin-bottom: 20px;
            }
            p {
                font-size: 16px;
                margin-bottom: 30px;
            }
            a {
                text-decoration: none;
                color: #3498db;
                font-weight: bold;
                border: 2px solid #3498db;
                padding: 10px 20px;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            a:hover {
                background-color: #3498db;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Access Denied</h1>
            <p>You do not have permission to access this page.</p>
            <a href="employee_login.jsp">Are you an employee? Login here</a>
        </div>
    </body>
</html>
