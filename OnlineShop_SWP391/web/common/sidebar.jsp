<!DOCTYPE html>
<!-- sidebar.jsp -->
<div class="sidebar">
    <style>
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            position: fixed;
            height: 100%;
            color: white;
            padding-top: 20px;
        }

        .sidebar .profile {
            text-align: center;
            padding: 10px 0;
        }

        .sidebar .profile img {
            border-radius: 50%;
            width: 55px;
            height: 55px;
            margin-left: 10px;
        }

        .sidebar .profile h5 {
            margin: 10px 0 5px;
            font-size: 18px;
        }

        .sidebar .profile h6 {
            font-size: 14px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transitions */
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #ecf0f1; /* White text color */
            display: flex;
            align-items: center;
            width: 100%; /* Make the entire list item clickable */
            transition: color 0.3s ease; /* Smooth color transition */
        }

        .sidebar ul li:hover {
            background-color: #34495e; /* Hover background */
        }

        .sidebar ul li a:hover {
            color: #1abc9c; /* Hover text color */
        }

        .sidebar ul li i {
            margin-right: 10px;
            font-size: 18px; /* Icon size */
            transition: color 0.3s ease; /* Smooth transition for icons */
        }

        .sidebar ul li a:hover i {
            color: #1abc9c; /* Change icon color on hover */
        }
    </style>
    <div class="profile" style="display: flex; align-items: center; margin-bottom: 12px">
        <img alt="Profile Picture" src="https://cdn.icon-icons.com/icons2/2560/PNG/512/woman_user_avatar_account_female_icon_153149.png"/>
        <div style="display: flex; flex-direction: column; margin-left: 15px;">
            <h5 style="margin: 0;">
                ${sessionScope.employee.fullName}
            </h5>
            <div style="display: flex; align-items: center;">
                <span style="display: inline-block; width: 10px; height: 10px; background-color: #1abc9c; border-radius: 50%; margin-right: 5px;"></span>
                <h6 style="color: #1abc9c; margin: 0; margin-top: 5px;">
                    Online
                </h6>
            </div>
        </div>
    </div>
    <!--Sale manager menu-->
    <c:if test="${account.getRoleID() == 4}">
        <ul>
            <li><a href="SaleManagerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="SaleManagerOrderList"><i class="fas fa-th"></i> Order List</a></li>
            <li><a href="ChangePassword"><i class="fas fa-key"></i> Change Password</a></li>
            <li><a href="logout" onclick="return confirm('Are you sure you want to log out?')"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
        </ul>
    </c:if>
    <!--Saler menu-->
    <c:if test="${account.getRoleID() == 3}">
        <ul>
            <li>
                <a href="SellerDashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="SellerOrderList">
                    <i class="fas fa-th"></i> Order List
                </a>
            </li>
            <li>
                <a href="ChangePassword">
                    <i class="fas fa-key"></i> Change Password
                </a>
            </li>
            <li>
                <a href="logout" onclick="return confirm('Are you sure you want to log out?')">
                    <i class="fas fa-sign-out-alt"></i> Log Out
                </a>
            </li>
        </ul>
    </c:if>
    <!--Warehouse menu-->
    <c:if test="${account.getRoleID() == 6}">
        <ul>
            <li class="${sessionScope.activeSection == null || sessionScope.activeSection.equals('dashboard-content') ? 'active' : ''}" data-target="dashboard-content">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('product-list-content') ? 'active' : ''}" data-target="product-list-content">
                <i class="fas fa-box-open"></i> Product List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('view-order-content') ? 'active' : ''}" data-target="view-order-content">
                <i class="fas fa-key"></i> Order List
            </li>

            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('change-password-content') ? 'active' : ''}" data-target="change-password-content">
                <i class="fas fa-key"></i> Change Password
            </li>
            <li><a href="logout" onclick="return confirm('Are you sure you want to log out?')"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
        </ul>
    </c:if>
    <!--Marketer menu-->
    <c:if test="${account.getRoleID() == 2}">
        <ul>
            <li class="${sessionScope.activeSection == null || sessionScope.activeSection.equals('dashboard-content') ? 'active' : ''}" data-target="dashboard-content">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('product-list-content') ? 'active' : ''}" data-target="product-list-content">
                <i class="fas fa-box-open"></i> Product List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('post-list-content') ? 'active' : ''}" data-target="post-list-content">
                <i class="fas fa-file-alt"></i> Post List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('slider-list-content') ? 'active' : ''}" data-target="slider-list-content">
                <i class="fas fa-sliders-h"></i> Slider List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('customer-list-content') ? 'active' : ''}" data-target="customer-list-content">
                <i class="fas fa-users"></i> Customer List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('feedback-list-content') ? 'active' : ''}" data-target="feedback-list-content">
                <i class="fas fa-comment-dots"></i> Feedback List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('promotion-list-content') ? 'active' : ''}" data-target="promotion-list-content">
                <i class="fas fa-money-bill-wave"></i> Promotion List
            </li>
            <li class="${sessionScope.activeSection != null && sessionScope.activeSection.equals('change-password-content') ? 'active' : ''}" data-target="change-password-content">
                <i class="fas fa-key"></i> Change Password
            </li>
            <a href="#" onclick="return confirmLogout()">
                <li>
                    <i class="fas fa-sign-out-alt"></i> Log Out
                </li>
            </a>
        </ul>
    </c:if>
</div>
