package com.grocery;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM cart WHERE id=?"
            );
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();

            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}