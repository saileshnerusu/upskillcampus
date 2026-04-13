<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.html");
        return;
    }

    int total = 0;
    boolean hasItems = false;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart - GroceryPro</title>
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
        <span class="hero-badge">Your Shopping Cart</span>
        <h1>Review Your Selected Products</h1>
        <p>
            Check your cart items, remove products if needed, and continue
            to checkout for a smooth grocery ordering experience.
        </p>

        <div class="hero-buttons">
            <a href="dashboard.jsp" class="secondary-btn">Continue Shopping</a>
            <a href="delivery.jsp" class="primary-btn">Proceed to Checkout</a>
        </div>
    </div>

    <div class="premium-hero-right">
        <div class="hero-image-wrap">
            <img src="images/hero-grocery.jpg" alt="Cart Hero" class="hero-main-image" onerror="this.src='images/default.jpg'">
        </div>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Cart Items</h2>
    <p class="section-subtitle">Manage the products you want to order.</p>

    <div class="table-card">
        <table class="cart-table">
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Action</th>
            </tr>

            <%
                try {
                	Class.forName("com.mysql.cj.jdbc.Driver");

                	Connection con = DriverManager.getConnection(
                	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
                	    "root",
                	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
                	);
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM cart");

                    while(rs.next()) {
                        hasItems = true;
                        total += rs.getInt("price");
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td>&#8377;<%= rs.getInt("price") %></td>
                <td>
                    <form action="removefromcart" method="post" style="margin:0;">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                    }

                    con.close();
                } catch(Exception e) {
            %>
            <tr>
                <td colspan="4">Error: <%= e.getMessage() %></td>
            </tr>
            <%
                }
            %>
        </table>

        <%
            if(hasItems){
        %>
        <div class="checkout-box">
            <div class="total-box">
                Total: &#8377;<%= total %>
            </div>
            <a href="delivery.jsp" class="checkout-btn">Proceed to Checkout</a>
        </div>
        <%
            } else {
        %>
        <div class="empty-box" style="margin-top:20px;">
            No items in cart yet.
            <br><br>
            <a href="dashboard.jsp" class="action-btn">Browse Products</a>
        </div>
        <%
            }
        %>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Premium Cart
</div>

</body>
</html>