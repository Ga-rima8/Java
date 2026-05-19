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

@WebServlet("/handleUser")
public class HandleUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection con = DBconfig.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery(
                "SELECT Visitor_id, Name, Email, Address, status " +
                "FROM visitor " +
                "ORDER BY Visitor_id DESC"
            );

            List<Map<String, String>> userList = new ArrayList<>();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id",      rs.getString("Visitor_id"));
                row.put("name",    rs.getString("Name"));
                row.put("email",   rs.getString("Email"));
                row.put("address", rs.getString("Address"));
                row.put("status",  rs.getString("status"));
                userList.add(row);
            }

            // Count by status
            long pending  = userList.stream().filter(u -> "Pending".equalsIgnoreCase(u.get("status"))).count();
            long accepted = userList.stream().filter(u -> "Accepted".equalsIgnoreCase(u.get("status"))).count();
            long declined = userList.stream().filter(u -> "Declined".equalsIgnoreCase(u.get("status"))).count();

            request.setAttribute("userList",       userList);
            request.setAttribute("totalUsers",     userList.size());
            request.setAttribute("pendingCount",   pending);
            request.setAttribute("acceptedCount",  accepted);
            request.setAttribute("declinedCount",  declined);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load users: " + e.getMessage());
        }

        request.setAttribute("currentPage", "handleuser");
        request.getRequestDispatcher("/WEB-INF/pages/handleuser.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("userId"));

        try {
            Connection con = DBconfig.getConnection();

            if ("accept".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE visitor SET status = 'Accepted' WHERE Visitor_id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();

            } else if ("decline".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE visitor SET status = 'Declined' WHERE Visitor_id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();

            } else if ("delete".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM visitor WHERE Visitor_id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/handleUser");
    }
}