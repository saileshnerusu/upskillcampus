<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order History - GroceryPro</title>
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
        <span class="hero-badge">My Orders</span>
        <h1>Track Your Grocery Orders</h1>
        <p>
            View your previous orders, payment details, delivery slot,
            and current order status in one organized page.
        </p>

        <div class="hero-buttons">
            <a href="dashboard.jsp" class="secondary-btn">Continue Shopping</a>
            <a href="cart.jsp" class="primary-btn">Go to Cart</a>
        </div>
    </div>

    <div class="premium-hero-right">
        <div class="hero-image-wrap">
            <img src="images/secure-shopping.jpg" alt="Order History" class="hero-main-image" onerror="this.src='images/default.jpg'">
        </div>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Order History</h2>
    <p class="section-subtitle">Track all your placed orders and their status.</p>

    <div class="table-card">
        <table class="cart-table">
            <tr>
                <th>ID</th>
                <th>City</th>
                <th>Delivery Slot</th>
                <th>Payment</th>
                <th>Total</th>
                <th>Status</th>
            </tr>

            <%
                boolean found = false;

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

                    while(rs.next()) {
                        found = true;
                        String status = rs.getString("order_status");
                        String color = "#555";

                        if("Placed".equals(status)) color = "#ff9800";
                        else if("Processing".equals(status)) color = "#2196f3";
                        else if("Shipped".equals(status)) color = "#9c27b0";
                        else if("Delivered".equals(status)) color = "#2e7d32";
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("city") %></td>
                <td><%= rs.getString("delivery_slot") %></td>
                <td><%= rs.getString("payment_method") %></td>
                <td>&#8377;<%= rs.getInt("total_amount") %></td>
                <td>
                    <span style="color:<%= color %>; font-weight:bold;">
                        <%= status %>
                    </span>
                </td>
            </tr>
            <%
                    }

                    con.close();

                    if(!found){
            %>
            <tr>
                <td colspan="6" style="text-align:center;">No orders found yet.</td>
            </tr>
            <%
                    }

                } catch(Exception e) {
            %>
            <tr>
                <td colspan="6">Error: <%= e.getMessage() %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Premium Order History
</div>

</body>
</html>