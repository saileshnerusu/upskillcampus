package com.grocery;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	jakarta.servlet.http.HttpSession session = request.getSession();
            	session.setAttribute("user", email);
            	response.sendRedirect("dashboard.jsp");
            } else {
                out.println("<html><head><title>Login Failed</title>");
                out.println("<link rel='stylesheet' href='style.css'>");
                out.println("</head><body>");
                out.println("<div class='form-wrapper'>");
                out.println("<div class='form-card'>");
                out.println("<h2>Invalid Email or Password ❌</h2>");
                out.println("<p>Please enter correct login details.</p>");
                out.println("<div class='form-bottom'><a href='login.html'>Try Again</a></div>");
                out.println("</div></div></body></html>");
            }

            con.close();

        } catch (Exception e) {
            out.println("<html><body><h2>Error: " + e.getMessage() + "</h2></body></html>");
        }
    }
}
