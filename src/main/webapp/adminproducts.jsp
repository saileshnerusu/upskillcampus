<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Products</title>
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
    <h2 class="section-title">Manage Products</h2>
    <p class="section-subtitle">Edit or delete products from your store.</p>

    <div class="table-card">
        <table class="cart-table">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Image</th>
                <th>Price</th>
                <th>Edit</th>
                <th>Delete</th>
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
                    ResultSet rs = st.executeQuery("SELECT * FROM products ORDER BY id DESC");

                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getString("image_name") %></td>
                <td>&#8377;<%= rs.getInt("price") %></td>
                <td>
                    <a href="editproduct.jsp?id=<%= rs.getInt("id") %>" class="checkout-btn">Edit</a>
                </td>
                <td>
                    <form action="deleteproduct" method="post" style="margin:0;">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="remove-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }

                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro |  Built by Sailesh 🚀
</div>

</body>
</html>