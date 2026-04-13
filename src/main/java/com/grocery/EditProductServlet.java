package com.grocery;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String productName = request.getParameter("product_name");
        String category = request.getParameter("category");
        String imageName = request.getParameter("image_name");
        int price = Integer.parseInt(request.getParameter("price"));

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);

            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET product_name=?, category=?, image_name=?, price=? WHERE id=?"
            );

            ps.setString(1, productName);
            ps.setString(2, category);
            ps.setString(3, imageName);
            ps.setInt(4, price);
            ps.setInt(5, id);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("adminproducts.jsp");

        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}