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

@WebServlet("/events")
public class EventServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DBconfig.getConnection();
            Statement st = con.createStatement();
            ResultSet rs;

            rs = st.executeQuery(
                "SELECT e.Events_id, e.Title, e.Event_date, e.Event_location, " +
                "e.Event_price, e.Event_desc, h.Name AS host_name, c.Title AS category_name " +
                "FROM events e " +
                "LEFT JOIN host h ON e.Host_id = h.Host_id " +
                "LEFT JOIN category c ON e.Category_id = c.Category_id " +
                "ORDER BY e.Events_id DESC"
            );
            List<Map<String, String>> eventList = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id",           rs.getString("Events_id"));
                row.put("title",        rs.getString("Title"));
                row.put("date",         rs.getString("Event_date"));
                row.put("location",     rs.getString("Event_location"));
                row.put("price",        rs.getString("Event_price"));
                row.put("desc",         rs.getString("Event_desc"));
                row.put("hostName",     rs.getString("host_name"));
                row.put("categoryName", rs.getString("category_name"));
                eventList.add(row);
            }
            request.setAttribute("eventList", eventList);

            rs = st.executeQuery("SELECT Category_id, Title FROM category");
            List<Map<String, String>> categories = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id",    rs.getString("Category_id"));
                row.put("title", rs.getString("Title"));
                categories.add(row);
            }
            request.setAttribute("categories", categories);

            rs = st.executeQuery("SELECT Host_id, Name FROM host");
            List<Map<String, String>> hosts = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id",   rs.getString("Host_id"));
                row.put("name", rs.getString("Name"));
                hosts.add(row);
            }
            request.setAttribute("hosts", hosts);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load events: " + e.getMessage());
        }
        request.setAttribute("currentPage", "events");
        request.getRequestDispatcher("/WEB-INF/pages/events.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            Connection con = DBconfig.getConnection();

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("eventId"));

                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM event_registration WHERE Events_id = ?");
                ps.setInt(1, id); ps.executeUpdate();

                ps = con.prepareStatement("DELETE FROM review WHERE Events_id = ?");
                ps.setInt(1, id); ps.executeUpdate();

                ps = con.prepareStatement("DELETE FROM events WHERE Events_id = ?");
                ps.setInt(1, id); ps.executeUpdate();

            } else if ("create".equals(action)) {
                String title    = request.getParameter("title");
                String date     = request.getParameter("date");
                String location = request.getParameter("location");
                String price    = request.getParameter("price");
                String desc     = request.getParameter("desc");
                int hostId      = Integer.parseInt(request.getParameter("hostId"));
                int categoryId  = Integer.parseInt(request.getParameter("categoryId"));

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO events (Host_id, Title, Category_id, Event_date, " +
                    "Event_location, Event_price, Event_desc) VALUES (?,?,?,?,?,?,?)");
                ps.setInt(1, hostId);
                ps.setString(2, title);
                ps.setInt(3, categoryId);
                ps.setString(4, date);
                ps.setString(5, location);
                ps.setDouble(6, Double.parseDouble(price));
                ps.setString(7, desc);
                ps.executeUpdate();
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/events");
    }
}