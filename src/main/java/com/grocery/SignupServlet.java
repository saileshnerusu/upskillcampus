package com.grocery;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name,email,password,phone,address) VALUES(?,?,?,?,?)"
            );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, address);

            int i = ps.executeUpdate();

            if (i > 0) {
                out.println("<html><head><title>Success</title>");
                out.println("<link rel='stylesheet' href='style.css'>");
                out.println("</head><body>");
                out.println("<div class='form-wrapper'>");
                out.println("<div class='form-card'>");
                out.println("<h2>Signup Successful ✅</h2>");
                out.println("<p>Your account has been created successfully.</p>");
                out.println("<div class='form-bottom'><a href='login.html'>Go to Login</a></div>");
                out.println("</div></div></body></html>");
            } else {
                out.println("<html><body><h2>Signup Failed</h2></body></html>");
            }

            con.close();

        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}