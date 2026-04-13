<%@ page contentType="text/html; charset=UTF-8" %>
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
    <title>Payment - GroceryPro</title>
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

<div class="auth-section">

    <div class="auth-card auth-image-card">
        <img src="images/secure-shopping.jpg" class="auth-side-image">
        <div class="auth-image-overlay">
            <h2>Secure Payment</h2>
            <p>Choose your payment method and complete your order safely.</p>
        </div>
    </div>

    <div class="auth-card auth-form-card">
        <div class="auth-badge">Payment</div>
        <h1>Select Payment Method</h1>

        <form action="ordersuccess.jsp" method="post" class="auth-form">
        <input type="hidden" name="city" value="<%= request.getParameter("city") %>">
<input type="hidden" name="delivery_slot" value="<%= request.getParameter("delivery_slot") %>">

            <div class="form-group">
                <label>Payment Method</label>
                <select name="payment_method" required>
                    <option value="">Select</option>
                    <option value="Cash on Delivery">Cash on Delivery</option>
                    <option value="UPI">UPI</option>
                    <option value="Card">Card</option>
                </select>
            </div>

            <button type="submit" class="submit-btn auth-btn">
                Place Order
            </button>

        </form>
    </div>

</div>

<div class="footer">
    © 2026 GroceryPro | Payment
</div>

</body>
</html>