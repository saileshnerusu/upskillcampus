package com.grocery;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productName = request.getParameter("product_name");
        String category = request.getParameter("category");
        int price = Integer.parseInt(request.getParameter("price"));

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        filePart.write(uploadPath + File.separator + fileName);

        try {
          

        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO products(product_name, category, price, image_name) VALUES(?,?,?,?)"
            );

            ps.setString(1, productName);
            ps.setString(2, category);
            ps.setInt(3, price);
            ps.setString(4, fileName);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("adminproducts.jsp");

        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}