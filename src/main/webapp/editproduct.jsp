<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    String productName = "";
    String category = "";
    String imageName = "";
    int price = 0;

    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

    	Connection con = DriverManager.getConnection(
    	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
    	    "root",
    	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
    	);

        PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            productName = rs.getString("product_name");
            category = rs.getString("category");
            imageName = rs.getString("image_name");
            price = rs.getInt("price");
        }

        con.close();
    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
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
<div class="form-wrapper">
    <div class="form-card">
        <h2>Edit Product</h2>
        <p>Update product details.</p>

        <form action="editproduct" method="post">
            <input type="hidden" name="id" value="<%= id %>">

            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="product_name" value="<%= productName %>" required>
            </div>

            <div class="form-group">
                <label>Category</label>
                <input type="text" name="category" value="<%= category %>" required>
            </div>

            <div class="form-group">
                <label>Image Name</label>
                <input type="text" name="image_name" value="<%= imageName %>" placeholder="example: mango.jpg" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="number" name="price" value="<%= price %>" required>
            </div>

            <input type="submit" value="Save Changes" class="submit-btn">
        </form>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro | Built by Sailesh 🚀
</div>

</body>
</html>