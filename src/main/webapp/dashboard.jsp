<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String user = (String) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.html");
        return;
    }

    String search = request.getParameter("search");
    String category = request.getParameter("category");

    if(search == null) search = "";
    if(category == null) category = "All";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - GroceryPro</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar">
    <div class="logo">GroceryPro</div>
    <div class="nav-links">
        <a href="dashboard.jsp">Home</a>
        <a href="cart.jsp">Cart</a>
        <a href="orderhistory.jsp">Orders</a>
        <a href="profile.jsp">Profile</a>
        <a href="admin.jsp">Admin</a>
        <a href="adminproducts.jsp">Manage Products</a>
        <a href="adminorders.jsp">Manage Orders</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="premium-hero premium-home-hero">
    <div class="premium-hero-left">
        <span class="hero-badge">Welcome Back</span>
        <h1>Hello, <%= user %></h1>
        <p>
            Explore fresh groceries, manage your cart, track your orders,
            and enjoy a premium shopping experience with GroceryPro.
        </p>

        <div class="hero-buttons">
            <a href="cart.jsp" class="primary-btn">Go to Cart</a>
            <a href="orderhistory.jsp" class="secondary-btn">My Orders</a>
        </div>

        <div class="hero-stats">
            <div class="stat-box">
                <h3>Fresh</h3>
                <p>Daily Products</p>
            </div>
            <div class="stat-box">
                <h3>Fast</h3>
                <p>Home Delivery</p>
            </div>
            <div class="stat-box">
                <h3>Smart</h3>
                <p>Easy Shopping</p>
            </div>
        </div>
    </div>

    <div class="premium-hero-right">
        <div class="hero-image-wrap">
            <img src="images/hero-grocery.jpg" alt="Dashboard Hero" class="hero-main-image" onerror="this.src='images/default.jpg'">
        </div>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Browse Products</h2>
    <p class="section-subtitle">Search, filter, and shop your daily essentials.</p>

    <div class="table-card" style="margin-bottom:30px;">
        <form action="dashboard.jsp" method="get" style="display:flex; gap:15px; flex-wrap:wrap; align-items:end;">
            <div style="flex:1; min-width:260px;">
                <label style="font-weight:bold; display:block; margin-bottom:8px;">Search Product</label>
                <input type="text" name="search" value="<%= search %>" placeholder="Search by product name"
                       list="productSuggestions"
                       style="width:100%; padding:12px; border:1px solid #ccc; border-radius:12px;">
                
                <datalist id="productSuggestions">
                    <%
                        try {
                        	Class.forName("com.mysql.cj.jdbc.Driver");

                        	Connection con = DriverManager.getConnection(
                        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
                        	    "root",
                        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
                        	);

                        	Statement st2 = con.createStatement();
                        	ResultSet rs2 = st2.executeQuery("SELECT product_name FROM products");

                        	while(rs2.next()){
                        	%>
                        	<option value="<%= rs2.getString("product_name") %>">
                        	<%
                        	}
                        	con.close();
                        } catch(Exception e){}
                    %>
                </datalist>
            </div>

            <div style="min-width:220px;">
                <label style="font-weight:bold; display:block; margin-bottom:8px;">Category</label>
                <select name="category" style="width:100%; padding:12px; border:1px solid #ccc; border-radius:12px;">
                    <option value="All" <%= category.equals("All") ? "selected" : "" %>>All</option>
                    <option value="Groceries" <%= category.equals("Groceries") ? "selected" : "" %>>Groceries</option>
                    <option value="Dairy" <%= category.equals("Dairy") ? "selected" : "" %>>Dairy</option>
                    <option value="Fruits" <%= category.equals("Fruits") ? "selected" : "" %>>Fruits</option>
                    <option value="Protein" <%= category.equals("Protein") ? "selected" : "" %>>Protein</option>
                </select>
            </div>

            <div>
                <button type="submit" class="submit-btn" style="padding:12px 20px;">Apply</button>
            </div>
        </form>
    </div>

    <div class="products">
        <%
            boolean found = false;

            try {
            	Class.forName("com.mysql.cj.jdbc.Driver");

            	Connection con = DriverManager.getConnection(
            	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
            	    "root",
            	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
            	);

                String sql = "SELECT * FROM products WHERE product_name LIKE ?";
                if(!category.equals("All")){
                    sql += " AND category = ?";
                }

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, "%" + search + "%");

                if(!category.equals("All")){
                    ps.setString(2, category);
                }

                ResultSet rs = ps.executeQuery();

                while(rs.next()){
                    found = true;
        %>

        <div class="product-card premium-product">
            <div class="product-img">
                <img src="images/<%= rs.getString("image_name") %>"
                     alt="<%= rs.getString("product_name") %>"
                     class="product-image"
                     onerror="this.src='images/default.jpg'">
            </div>

            <div class="product-info">
                <h3><%= rs.getString("product_name") %></h3>
                <p class="product-desc"><%= rs.getString("category") %> item</p>
                <div class="price">&#8377;<%= rs.getInt("price") %></div>

                <form action="addtocart" method="post">
                    <input type="hidden" name="product_name" value="<%= rs.getString("product_name") %>">
                    <input type="hidden" name="price" value="<%= rs.getInt("price") %>">
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </div>

        <%
                }

                con.close();
            } catch(Exception e) {
        %>
            <div class="empty-box" style="width:100%;">
                Error: <%= e.getMessage() %>
            </div>
        <%
            }

            if(!found){
        %>
            <div class="empty-box" style="width:100%;">
                No matching products found.
            </div>
        <%
            }
        %>
    </div>
</div>

<div class="section">
    <h2 class="section-title">Quick Access</h2>
    <p class="section-subtitle">Customer and admin shortcuts in one place.</p>

    <div class="features-row">
        <div class="feature-box">
            <div class="feature-icon">Customer</div>
            <h3>Cart &amp; Orders</h3>
            <p>Manage your cart, place orders, and track order history easily.</p>
            <a href="cart.jsp" class="mini-btn">Open Cart</a>
        </div>

        <div class="feature-box">
            <div class="feature-icon">Profile</div>
            <h3>My Account</h3>
            <p>View your profile details, previous activity, and account information.</p>
            <a href="profile.jsp" class="mini-btn">Open Profile</a>
        </div>

        <div class="feature-box">
            <div class="feature-icon">Admin</div>
            <h3>Manage Products</h3>
            <p>Add products, edit product details, and update images for your store.</p>
            <a href="adminproducts.jsp" class="mini-btn">Manage Products</a>
        </div>

        <div class="feature-box">
            <div class="feature-icon">Orders</div>
            <h3>Manage Orders</h3>
            <p>Update order status from placed to delivered and monitor all customer orders.</p>
            <a href="adminorders.jsp" class="mini-btn">Manage Orders</a>
        </div>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Premium Dashboard
</div>

</body>
</html>