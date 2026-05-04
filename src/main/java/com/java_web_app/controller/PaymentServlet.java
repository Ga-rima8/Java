package com.java_web_app.controller;

import com.java_web_app.utils.DBconfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DBconfig.getConnection();
            Statement st = con.createStatement();
            ResultSet rs;

            // Total earnings = sum of all event prices from registrations
            rs = st.executeQuery(
                "SELECT COALESCE(SUM(e.Event_price), 0) " +
                "FROM event_registration er " +
                "JOIN events e ON er.Events_id = e.Events_id"
            );
            rs.next();
            Object totalEarnings = rs.getObject(1);
            request.setAttribute("totalEarnings", totalEarnings);
            request.setAttribute("netRevenue",    totalEarnings);

            // Total transactions = total registrations
            rs = st.executeQuery("SELECT COUNT(*) FROM event_registration");
            rs.next();
            request.setAttribute("totalTransactions", rs.getInt(1));

            // No payments table — refunds are 0
            request.setAttribute("totalRefunds", 0);
            request.setAttribute("refundCount",  0);

            // All "transactions" = each registration with event price
            rs = st.executeQuery(
                "SELECT er.Event_registration_id, v.Name AS visitor_name, " +
                "e.Title AS event_title, e.Event_price, er.Registration_date " +
                "FROM event_registration er " +
                "JOIN visitor v ON er.Visitor_id = v.Visitor_id " +
                "JOIN events e ON er.Events_id = e.Events_id " +
                "ORDER BY er.Event_registration_id DESC"
            );

            List<Map<String, String>> payments = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> p = new HashMap<>();
                p.put("userName",    rs.getString("visitor_name"));
                p.put("eventName",   rs.getString("event_title"));
                p.put("amount",      rs.getString("Event_price"));
                p.put("paymentDate", rs.getString("Registration_date"));
                p.put("method",      "On-site");   // no method column in your DB
                p.put("type",        "Payment");   // no type column in your DB
                payments.add(p);
            }
            request.setAttribute("payments", payments);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Could not load payment data.");
        }
        request.setAttribute("currentPage", "payment");
        request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
    }
}