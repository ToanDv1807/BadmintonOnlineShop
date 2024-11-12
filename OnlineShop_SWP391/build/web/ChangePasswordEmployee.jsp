<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
    .message {
        position: absolute; /* Use absolute positioning */
        top: 100px; /* Adjust based on where you want the message to appear */
        left: 85%; /* Center horizontally */
        transform: translateX(-50%); /* Adjust the centering */
        margin: 0 auto; /* Center the message */
        padding: 10px;
        border: 1px solid transparent;
        border-radius: 4px;
        z-index: 1000; /* Ensure the message appears on top of other content */
        display: none; /* Initially hide the message */
    }

    .message.show {
        display: block; /* Show when the class 'show' is added */
    }

    .success {
        color: green;
        border-color: green;
        background-color: rgba(144, 238, 144, 0.2); /* Optional: light background for success */
    }

    .error {
        color: red;
        border-color: red;
        background-color: rgba(255, 99, 71, 0.2); /* Optional: light background for error */
    }
    .password-wrapper {
        position: relative; /* To position the icon */
    }

    .password-wrapper input {
        width: 100%; /* Full width for the input */
    }

    .toggle-password {
        position: absolute;
        right: 10px; /* Space from the right */
        top: 50%; /* Center vertically */
        transform: translateY(-50%); /* Adjust centering */
        cursor: pointer; /* Change cursor to pointer */
        font-size: 1.2em; /* Size of the icon */
    }
</style>
<!-- Message displays -->
<c:if test="${not empty sessionScope.messagePassWord}">
    <div id="messagePassWord" class="message success show">
        ${sessionScope.messagePassWord}
    </div>
    <script>
        setTimeout(function () {
            document.getElementById("messagePassWord").style.display = "none";
        }, 5000); // Hide after 5 seconds
    </script>
</c:if>
<c:if test="${not empty sessionScope.errorPassWord}">
    <div id="errorPassWord" class="message error show">
        ${sessionScope.errorPassWord}
    </div>
    <script>
        setTimeout(function () {
            document.getElementById("errorPassWord").style.display = "none";
        }, 5000); // Hide after 5 seconds
    </script>
</c:if>
<div class="change-password-form">
    <h3>Change Password</h3>
    <form action="change-password-employee" method="post">
        <div class="form-group-pass">
            <label for="old-password">Old Password</label>
            <div class="password-wrapper">
                <input type="password" id="old-password" name="oldPassword" placeholder="Enter old password" required>
                <span class="toggle-password" onclick="togglePassword('old-password')">
                    <i class="fas fa-eye"></i>
                </span>
            </div>
        </div>
        <div class="form-group-pass">
            <label for="new-password">New Password</label>
            <div class="password-wrapper">
                <input type="password" id="new-password" name="newPassword" placeholder="Enter new password" required>
                <span class="toggle-password" onclick="togglePassword('new-password')">
                    <i class="fas fa-eye"></i>
                </span>
            </div>
        </div>
        <div class="form-group-pass">
            <label for="confirm-password">Confirm New Password</label>
            <div class="password-wrapper">
                <input type="password" id="confirm-password" name="confirmPassword" placeholder="Confirm new password" required>
                <span class="toggle-password" onclick="togglePassword('confirm-password')">
                    <i class="fas fa-eye"></i>
                </span>
            </div>
        </div>
        <div class="form-group-pass">
            <button type="submit">Change Password</button>
        </div>
    </form>
</div>
<c:if test="${not empty sessionScope.messagePassWord || not empty sessionScope.errorPassWord}">
    <c:if test="${not empty sessionScope.messagePassWord}">
        <c:set var="tempMessage" value="${sessionScope.messagePassWord}" />
    </c:if>
    <c:if test="${not empty sessionScope.errorPassWord}">
        <c:set var="tempError" value="${sessionScope.errorPassWord}" />
    </c:if>
    <c:remove var="messagePassWord" />
    <c:remove var="errorPassWord" />
</c:if>
<script>
    function togglePassword(inputId) {
        const inputField = document.getElementById(inputId);
        const icon = inputField.nextElementSibling.querySelector('i');
        if (inputField.type === "password") {
            inputField.type = "text"; // Show password
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            inputField.type = "password"; // Hide password
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }
</script>
