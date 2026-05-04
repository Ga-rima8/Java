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

@WebServlet("/booking")  // fixed: sidebar links to /booking
public class BookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DBconfig.getConnection();
            Statement st = con.createStatement();

            // All bookings from event_registration (your actual table)
            ResultSet rs = st.executeQuery(
                "SELECT er.Event_registration_id, v.Name AS visitor_name, v.Email AS visitor_email, " +
                "e.Title AS event_title, e.Event_price, e.Event_location, er.Registration_date " +
                "FROM event_registration er " +
                "JOIN visitor v ON er.Visitor_id = v.Visitor_id " +
                "JOIN events e ON er.Events_id = e.Events_id " +
                "ORDER BY er.Event_registration_id DESC"
            );

            List<Map<String, String>> bookingList = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id",            rs.getString("Event_registration_id"));
                row.put("visitorName",   rs.getString("visitor_name"));
                row.put("visitorEmail",  rs.getString("visitor_email"));
                row.put("eventTitle",    rs.getString("event_title"));
                row.put("eventPrice",    rs.getString("Event_price"));
                row.put("eventLocation", rs.getString("Event_location"));
                row.put("regDate",       rs.getString("Registration_date"));
                bookingList.add(row);
            }
            request.setAttribute("bookingList", bookingList);
            request.setAttribute("totalBookings", bookingList.size());
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load bookings: " + e.getMessage());
        }
        request.setAttribute("currentPage", "booking");
        request.getRequestDispatcher("/WEB-INF/pages/booking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            Connection con = DBconfig.getConnection();
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("bookingId"));
                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM event_registration WHERE Event_registration_id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/booking");
    }
}