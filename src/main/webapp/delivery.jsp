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
    <title>Delivery Details - GroceryPro</title>
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
        <img src="images/fast-delivery.jpg" alt="Delivery" class="auth-side-image" onerror="this.src='images/default.jpg'">
        <div class="auth-image-overlay">
            <h2>Fast &amp; Secure Delivery</h2>
            <p>Enter your delivery information to complete the checkout process smoothly.</p>
        </div>
    </div>

    <div class="auth-card auth-form-card">
        <div class="auth-badge">Delivery Details</div>
        <h1>Enter Delivery Information</h1>
        <p class="auth-subtext">
            Provide your address, city, pincode, mobile number, and preferred delivery slot.
        </p>

        <form action="payment.jsp" method="post" class="auth-form">
            <div class="form-group">
                <label>Full Address</label>
                <textarea name="full_address" placeholder="Enter full address" required></textarea>
            </div>

            <div class="form-group">
                <label>City</label>
                <input type="text" name="city" placeholder="Enter city" required>
            </div>

            <div class="form-group">
                <label>Pincode</label>
                <input type="text" name="pincode" placeholder="Enter pincode" required>
            </div>

            <div class="form-group">
                <label>Mobile Number</label>
                <input type="text" name="mobile" placeholder="Enter mobile number" required>
            </div>

            <div class="form-group">
                <label>Delivery Slot</label>
                <select name="delivery_slot" required>
                    <option value="">Select Slot</option>
                    <option value="9 AM - 12 PM">9 AM - 12 PM</option>
                    <option value="12 PM - 3 PM">12 PM - 3 PM</option>
                    <option value="3 PM - 6 PM">3 PM - 6 PM</option>
                    <option value="6 PM - 9 PM">6 PM - 9 PM</option>
                </select>
            </div>

            <button type="submit" class="submit-btn auth-btn">Continue to Payment</button>
        </form>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Premium Delivery Details
</div>

</body>
</html>