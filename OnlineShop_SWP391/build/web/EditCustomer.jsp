<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Customer</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            /* Improved color scheme */
            body {
                background-color: #f8f9fa;
                font-family: 'Roboto', sans-serif;
                color: #333;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                background-color: #ffffff;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            header {
                background-color: #34495e;
                padding: 15px;
                border-radius: 10px 10px 0 0;
                color: #fff;
                text-align: center;
            }

            .profile-img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                display: block;
                margin: 20px auto;
                object-fit: cover;
                border: 3px solid #34495e;
            }

            .info-group {
                margin-bottom: 15px;
                font-size: 16px;
            }

            .info-group strong {
                display: inline-block;
                min-width: 130px;
                font-weight: 600;
            }

            .fa-icon {
                margin-right: 10px;
                color: #0056b3;
            }

            .btn-custom {
                padding: 10px 20px;
                margin: 10px 5px;
                text-decoration: none;
                color: #fff;
                border-radius: 5px;
                transition: background-color 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-save {
                background-color: #28a745;
            }

            .btn-save:hover {
                background-color: #218838;
            }

            .btn-back {
                background-color: #6c757d;
            }

            .btn-back:hover {
                background-color: #565e64;
            }

            .address-list {
                padding-left: 0;
                margin-top: 10px;
                margin-left: 30px;
            }
            /* Change history table */
            .change-history {
                margin-top: 30px;
                border-top: 1px solid #ddd;
                padding-top: 20px;
            }

            .change-history table {
                width: 100%;
                margin-top: 15px;
                border-collapse: collapse;
            }

            .change-history th, .change-history td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .change-history th {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <header>
                <h2>Edit Customer</h2>
            </header>
            <h3>${requestScope.message}</h3>
            <!-- Customer Image -->
            <div class="profile-info">
                <img src="assets/images/clients/client-1.jpg" class="profile-img" alt="Customer Image"/>
            </div>

            <form action="updated-customer" method="post">
                <input type="hidden" name="cid" value="${sessionScope.customerToEdit.customerID}"/>

                <div class="info-group">
                    <strong><i class="fas fa-user fa-icon"></i>Full Name:</strong> 
                    <span>${sessionScope.customerToEdit.fullName}</span>
                </div>

                <div class="info-group">
                    <strong><i class="fas fa-envelope fa-icon"></i>Email:</strong> 
                    <span>${sessionScope.customerToEdit.email}</span>
                </div>

                <div class="info-group">
                    <strong><i class="fas fa-venus-mars fa-icon"></i>Gender:</strong>
                    <span>
                        <c:choose>
                            <c:when test="${sessionScope.customerToEdit.gender == 1}">Male</c:when>
                            <c:otherwise>Female</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="info-group">
                    <strong><i class="fas fa-phone fa-icon"></i>Mobile:</strong> 
                    <span>${sessionScope.customerToEdit.phone}</span>
                </div>

                <div class="info-group">
                    <strong><i class="fas fa-home fa-icon"></i>Addresses:</strong>
                    <ol class="address-list">
                        <li>${sessionScope.customerToEdit.address}</li>
                            <c:forEach items="${sessionScope.addresses}" var="a">
                            <li>${a.addressName}</li>
                            </c:forEach>
                    </ol>
                </div>

                <div class="info-group">
                    <strong><i class="fas fa-info-circle fa-icon"></i>Status:</strong>
                    <select name="status" class="form-select">
                        <option value="1" <c:if test="${sessionScope.customerToEdit.status == 1}">selected</c:if>>Contact</option>
                        <option value="2" <c:if test="${sessionScope.customerToEdit.status == 2}">selected</c:if>>Potential</option>
                        <option value="3" <c:if test="${sessionScope.customerToEdit.status == 3}">selected</c:if>>Customer</option>
                        </select>
                    </div>

                    <div class="info-group">
                        <strong><i class="fas fa-sticky-note fa-icon"></i>Note:</strong>
                        <textarea name="note" class="form-control" rows="4">${sessionScope.customerToEdit.note}</textarea>
                </div>
                <!-- Change History Section -->
                <div class="change-history">
                    <h3>Change History</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Email</th>
                                <th>Full Name</th>
                                <th>Gender</th>
                                <th>Mobile</th>
                                <th>Address</th>
                                <th>Updated By</th>
                                <th>Updated Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty sessionScope.historyChanges}">
                                <c:forEach items="${sessionScope.historyChanges}" var="change">
                                    <tr>
                                        <td>${change.email}</td>
                                        <td>${change.full_name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${change.gender == 1}">Male</c:when>
                                                <c:otherwise>Female</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${change.mobile}</td>
                                        <td>${change.address}</td>
                                        <td>${change.updated_by}</td>
                                        <td>${change.updated_date}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty sessionScope.historyChanges}">
                                <tr>
                                    <td colspan="7" class="text-center">No changes available.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- Actions -->
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn-custom btn-save">
                        <i class="fas fa-save fa-icon"></i>Save Changes
                    </button>
                    <a href="MarketerDashboard" class="btn-custom btn-back">
                        <i class="fas fa-arrow-left fa-icon"></i>Back to Customer List
                    </a>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
