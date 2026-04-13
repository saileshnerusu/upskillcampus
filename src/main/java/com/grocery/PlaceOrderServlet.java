package com.grocery;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String user = (String) session.getAttribute("user");

        String fullAddress = request.getParameter("full_address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String mobile = request.getParameter("mobile");
        String deliverySlot = request.getParameter("delivery_slot");
        String paymentMethod = request.getParameter("payment_method");
        String upiId = request.getParameter("upi_id");
        String cardNumber = request.getParameter("card_number");

        int totalAmount = 0;

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        	Connection con = DriverManager.getConnection(
        	    "jdbc:mysql://metro.proxy.rlwy.net:31064/railway?useSSL=true&requireSSL=true&serverTimezone=UTC",
        	    "root",
        	    "upRZIMzKBexjVGPrAsVJkBOmpNfAIIPt"
        	);

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(price) AS total FROM cart");

            if (rs.next()) {
                totalAmount = rs.getInt("total");
            }

            if ("UPI".equals(paymentMethod) && (upiId == null || upiId.trim().isEmpty())) {
                response.getWriter().println("<h2>UPI ID is required.</h2>");
                return;
            }

            if ("Card".equals(paymentMethod) && (cardNumber == null || cardNumber.trim().isEmpty())) {
                response.getWriter().println("<h2>Card details are required.</h2>");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders(customer_email, full_address, city, pincode, mobile, delivery_slot, payment_method, total_amount, order_status) VALUES(?,?,?,?,?,?,?,?,?)"
            );

            ps.setString(1, user);
            ps.setString(2, fullAddress);
            ps.setString(3, city);
            ps.setString(4, pincode);
            ps.setString(5, mobile);
            ps.setString(6, deliverySlot);
            ps.setString(7, paymentMethod);
            ps.setInt(8, totalAmount);
            ps.setString(9, "Placed");

            ps.executeUpdate();

            Statement clearCart = con.createStatement();
            clearCart.executeUpdate("DELETE FROM cart");

            con.close();

            response.sendRedirect("ordersuccess.jsp");

        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}