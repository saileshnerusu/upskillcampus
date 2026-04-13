<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String user = (String) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.html");
        return;
    }

    int totalOrders = 0;
    String lastStatus = "No Orders";
    int totalSpent = 0;

    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

    	Connection con = DriverManager.getConnection(
    	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
    	    "root",
    	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
    	);

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM orders WHERE customer_email=? ORDER BY id DESC"
        );
        ps.setString(1, user);

        ResultSet rs = ps.executeQuery();

        boolean first = true;

        while(rs.next()){
            totalOrders++;
            totalSpent += rs.getInt("total_amount");

            if(first){
                lastStatus = rs.getString("order_status");
                first = false;
            }
        }

        con.close();

    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile - GroceryPro</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar premium-navbar">
    <div class="logo">GroceryPro</div>
    <div class="nav-links">
        <a href="dashboard.jsp">Home</a>
        <a href="cart.jsp">Cart</a>
        <a href="orderhistory.jsp">Orders</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="premium-hero premium-home-hero">
    <div class="premium-hero-left">
        <span class="hero-badge">My Profile</span>
        <h1>Welcome, <%= user %></h1>
        <p>
            View your account summary, recent activity, total orders,
            and overall shopping information in one place.
        </p>

        <div class="hero-buttons">
            <a href="orderhistory.jsp" class="primary-btn">View Orders</a>
            <a href="dashboard.jsp" class="secondary-btn">Continue Shopping</a>
        </div>
    </div>

    <div class="premium-hero-right">
        <div class="hero-image-wrap">
            <img src="images/customer-satisfaction.jpg" alt="Profile Hero" class="hero-main-image" onerror="this.src='images/default.jpg'">
        </div>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Account Summary</h2>
    <p class="section-subtitle">A quick view of your profile and shopping activity.</p>

    <div class="products">
        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Email</h3>
                <p class="product-desc"><%= user %></p>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Total Orders</h3>
                <div class="price"><%= totalOrders %></div>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Last Order Status</h3>
                <div class="price"><%= lastStatus %></div>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Total Spent</h3>
                <div class="price">&#8377;<%= totalSpent %></div>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Quick Actions</h2>
    <p class="section-subtitle">Move quickly through your account pages.</p>

    <div class="features-row">
        <div class="feature-box">
            <div class="feature-icon">Cart</div>
            <h3>Open Cart</h3>
            <p>Review items currently selected and continue to checkout.</p>
            <a href="cart.jsp" class="mini-btn">Go to Cart</a>
        </div>

        <div class="feature-box">
            <div class="feature-icon">Orders</div>
            <h3>Order History</h3>
            <p>Track your previous orders and view current order status.</p>
            <a href="orderhistory.jsp" class="mini-btn">View Orders</a>
        </div>

        <div class="feature-box">
            <div class="feature-icon">Shop</div>
            <h3>Continue Shopping</h3>
            <p>Go back to your dashboard and explore more grocery items.</p>
            <a href="dashboard.jsp" class="mini-btn">Browse Products</a>
        </div>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Premium Profile
</div>

</body>
</html>