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

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DBconfig.getConnection();
            Statement st = con.createStatement();
            ResultSet rs;

            // Total bookings 
            rs = st.executeQuery("SELECT COUNT(*) FROM event_registration");
            rs.next(); int total = rs.getInt(1);
            request.setAttribute("totalBookings", total);

            
            request.setAttribute("confirmedBookings", total);
            request.setAttribute("pendingBookings", 0);
            request.setAttribute("cancelledBookings", 0);
            request.setAttribute("confirmedPct", total > 0 ? 100 : 0);
            request.setAttribute("pendingPct", 0);
            request.setAttribute("cancelledPct", 0);
            request.setAttribute("cancelRate", 0);

            
            rs = st.executeQuery(
                "SELECT COALESCE(SUM(e.Event_price), 0) " +
                "FROM event_registration er " +
                "JOIN events e ON er.Events_id = e.Events_id"
            );
            rs.next();
            request.setAttribute("totalRevenue", rs.getBigDecimal(1));

            // Bookings per event + revenue per event
            rs = st.executeQuery(
                "SELECT e.Title AS event_name, COUNT(er.Event_registration_id) AS cnt, " +
                "COALESCE(SUM(e.Event_price), 0) AS revenue " +
                "FROM events e " +
                "LEFT JOIN event_registration er ON e.Events_id = er.Events_id " +
                "GROUP BY e.Events_id, e.Title " +
                "ORDER BY cnt DESC"
            );

            List<Map<String, Object>> eventStats   = new ArrayList<>();
            List<Map<String, Object>> eventAnalysis = new ArrayList<>();
            List<Object[]> rows = new ArrayList<>();
            int maxBookings = 1;

            while (rs.next()) {
                int cnt = rs.getInt("cnt");
                if (cnt > maxBookings) maxBookings = cnt;
                rows.add(new Object[]{
                    rs.getString("event_name"),
                    cnt,
                    rs.getBigDecimal("revenue")
                });
            }

            for (Object[] row : rows) {
                String eName   = (String) row[0];
                int    cnt     = (int)    row[1];
                Object revenue = row[2];
                int    fillPct = (cnt * 100) / maxBookings;

                Map<String, Object> stat = new HashMap<>();
                stat.put("eventName",    eName);
                stat.put("bookingCount", cnt);
                stat.put("fillPercent",  fillPct);
                eventStats.add(stat);

                Map<String, Object> analysis = new HashMap<>();
                analysis.put("eventName", eName);
                analysis.put("booked",    cnt);
                analysis.put("capacity",  "N/A");
                analysis.put("fillRate",  fillPct);
                analysis.put("revenue",   revenue);
                eventAnalysis.add(analysis);
            }

            request.setAttribute("eventStats",    eventStats);
            request.setAttribute("eventAnalysis", eventAnalysis);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Could not load report data.");
        }
        request.setAttribute("currentPage", "report");
        request.getRequestDispatcher("/WEB-INF/pages/report.jsp").forward(request, response);
    }
}