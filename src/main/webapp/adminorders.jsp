<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String search = request.getParameter("search");
    if(search == null) search = "";

    int totalOrders = 0;
    int pendingOrders = 0;
    int deliveredOrders = 0;
    int totalSales = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Orders</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar premium-navbar">
    <div class="logo">GroceryPro Admin</div>

    <div class="nav-links">
        <a href="admin.jsp">Add Product</a>
        <a href="adminproducts.jsp">Products</a>
        <a href="adminorders.jsp">Orders</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Manage Orders</h2>
    <p class="section-subtitle">Track and update customer orders professionally.</p>

    <div class="table-card" style="margin-bottom:25px;">
        <form action="adminorders.jsp" method="get" style="display:flex; gap:15px; flex-wrap:wrap; align-items:end;">
            <div style="flex:1; min-width:260px;">
                <label style="font-weight:bold; display:block; margin-bottom:8px;">Search by Email or City</label>
                <input type="text" name="search" value="<%= search %>" placeholder="Enter email or city"
                       style="width:100%; padding:12px; border:1px solid #ccc; border-radius:10px;">
            </div>

            <div>
                <button type="submit" class="submit-btn" style="padding:12px 20px;">Search</button>
            </div>
        </form>
    </div>

    <%
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);

        	Statement sumSt = con.createStatement();
        	ResultSet sumRs = sumSt.executeQuery("SELECT * FROM orders");

        	while(sumRs.next()){
        	    totalOrders++;
        	    totalSales += sumRs.getInt("total_amount");

        	    String s = sumRs.getString("order_status");
        	    if("Placed".equalsIgnoreCase(s) || "Processing".equalsIgnoreCase(s) || "Shipped".equalsIgnoreCase(s)){
        	        pendingOrders++;
        	    }
        	    if("Delivered".equalsIgnoreCase(s)){
        	        deliveredOrders++;
        	    }
        	}

        	con.close();
        } catch(Exception e) {
    %>
        <div class="empty-box">Error loading summary: <%= e.getMessage() %></div>
    <%
        }
    %>

    <div class="products" style="margin-bottom:30px;">
        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Total Orders</h3>
                <div class="price"><%= totalOrders %></div>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Active Orders</h3>
                <div class="price"><%= pendingOrders %></div>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Delivered</h3>
                <div class="price"><%= deliveredOrders %></div>
            </div>
        </div>

        <div class="product-card premium-product">
            <div class="product-info">
                <h3>Total Sales</h3>
                <div class="price">&#8377;<%= totalSales %></div>
            </div>
        </div>
    </div>

    <div class="table-card">
        <table class="cart-table">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>City</th>
                <th>Slot</th>
                <th>Payment</th>
                <th>Total</th>
                <th>Status</th>
                <th>Update</th>
            </tr>

            <%
                try {
                	Class.forName("com.mysql.cj.jdbc.Driver");

                	Connection con = DriverManager.getConnection(
                	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
                	    "root",
                	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
                	);

                    String sql = "SELECT * FROM orders WHERE customer_email LIKE ? OR city LIKE ? ORDER BY id DESC";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, "%" + search + "%");
                    ps.setString(2, "%" + search + "%");

                    ResultSet rs = ps.executeQuery();

                    while(rs.next()) {
                        String status = rs.getString("order_status");
                        String color = "#555";

                        if("Placed".equals(status)) color = "#ff9800";
                        else if("Processing".equals(status)) color = "#2196f3";
                        else if("Shipped".equals(status)) color = "#9c27b0";
                        else if("Delivered".equals(status)) color = "#2e7d32";
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("customer_email") %></td>
                <td><%= rs.getString("city") %></td>
                <td><%= rs.getString("delivery_slot") %></td>
                <td><%= rs.getString("payment_method") %></td>
                <td>&#8377;<%= rs.getInt("total_amount") %></td>
                <td>
                    <span style="color:<%= color %>; font-weight:bold;"><%= status %></span>
                </td>
                <td>
                    <form action="updateorderstatus" method="post" style="margin:0; display:flex; gap:8px; align-items:center; flex-wrap:wrap;">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

                        <select name="order_status" style="padding:8px; border-radius:8px;">
                            <option value="Placed" <%= status.equals("Placed") ? "selected" : "" %>>Placed</option>
                            <option value="Processing" <%= status.equals("Processing") ? "selected" : "" %>>Processing</option>
                            <option value="Shipped" <%= status.equals("Shipped") ? "selected" : "" %>>Shipped</option>
                            <option value="Delivered" <%= status.equals("Delivered") ? "selected" : "" %>>Delivered</option>
                        </select>

                        <button type="submit" class="checkout-btn">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }

                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Built by Sailesh 🚀
</div>

</body>
</html>