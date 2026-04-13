<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String user = (String) session.getAttribute("user");

    String city = request.getParameter("city");
    String slot = request.getParameter("delivery_slot");
    String payment = request.getParameter("payment_method");

    int total = 0;

    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

    	Connection con = DriverManager.getConnection(
    	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
    	    "root",
    	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
    	);

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT SUM(price) FROM cart");

        if(rs.next()){
            total = rs.getInt(1);
        }

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO orders(customer_email, city, delivery_slot, payment_method, total_amount, order_status) VALUES(?,?,?,?,?,?)"
        );

        ps.setString(1, user);
        ps.setString(2, city);
        ps.setString(3, slot);
        ps.setString(4, payment);
        ps.setInt(5, total);
        ps.setString(6, "Placed");

        ps.executeUpdate();

        st.executeUpdate("DELETE FROM cart");

        con.close();

    } catch(Exception e){
        out.println(e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar premium-navbar">
    <div class="logo">GroceryPro</div>
</div>

<div class="section">
    <div class="empty-box">
        <h2 style="color:green;">Order Placed Successfully!</h2>
        <p>Your groceries will be delivered soon.</p>

        <br>
        <a href="dashboard.jsp" class="mini-btn">Back to Home</a>
    </div>
</div>

</body>
</html>