<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
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
        <h2>Add New Product</h2>
        <p>Add products with real images.</p>

        <form action="addproduct" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="product_name" required>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="category" required>
                    <option value="">Select Category</option>
                    <option value="Groceries">Groceries</option>
                    <option value="Dairy">Dairy</option>
                    <option value="Fruits">Fruits</option>
                    <option value="Protein">Protein</option>
                </select>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="number" name="price" required>
            </div>

            <div class="form-group">
                <label>Product Image</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <input type="submit" value="Add Product" class="submit-btn">
        </form>
    </div>
</div>

<div class="footer">
    © 2026 GroceryPro |  Built by Sailesh 🚀
</div>

</body>
</html>