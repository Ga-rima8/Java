package com.java_web_app.dao;

import com.java_web_app.utils.DBconfig;
import java.sql.*;
import java.util.*;

public class AdminDAO {

   
    public String loginAdmin(String email, String password) {
        String sql = "SELECT Name FROM admin WHERE Email = ? AND Password = ?";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("Name");
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    
    public Map<String, Integer> getDashboardCounts() {
        Map<String, Integer> map = new HashMap<>();
        try (Connection con = DBconfig.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM events WHERE is_deleted=0");
                 ResultSet rs = ps.executeQuery()) {
                map.put("events", rs.next() ? rs.getInt(1) : 0);
            }
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM user");
                 ResultSet rs = ps.executeQuery()) {
                map.put("visitors", rs.next() ? rs.getInt(1) : 0);
            }
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM host");
                 ResultSet rs = ps.executeQuery()) {
                map.put("hosts", rs.next() ? rs.getInt(1) : 0);
            }
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM bookings");
                 ResultSet rs = ps.executeQuery()) {
                map.put("registrations", rs.next() ? rs.getInt(1) : 0);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    public List<Map<String, Object>> getAllEvents() {
        return searchEvents(null);
    }

    public List<Map<String, Object>> searchEvents(String keyword) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql =
            "SELECT e.Events_id, e.Title, h.Name AS host, c.Title AS category, " +
            "e.Event_date, e.Event_location, e.Event_price, e.is_active " +
            "FROM events e " +
            "LEFT JOIN host h ON e.Host_id = h.Host_id " +
            "LEFT JOIN category c ON e.Category_id = c.Category_id " +
            "WHERE e.is_deleted = 0";
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        if (hasKeyword) {
            sql += " AND (e.Title LIKE ? OR h.Name LIKE ? " +
                   "OR c.Title LIKE ? OR e.Event_location LIKE ?)";
        }
        sql += " ORDER BY e.Events_id DESC";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasKeyword) {
                String k = "%" + keyword.trim() + "%";
                ps.setString(1, k); ps.setString(2, k);
                ps.setString(3, k); ps.setString(4, k);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("id",         rs.getInt("Events_id"));
                    row.put("title",      rs.getString("Title"));
                    row.put("host",       rs.getString("host"));
                    row.put("category",   rs.getString("category"));
                    row.put("event_date", rs.getString("Event_date"));
                    row.put("location",   rs.getString("Event_location"));
                    row.put("price",      rs.getDouble("Event_price"));
                    row.put("status",     rs.getInt("is_active"));
                    list.add(row);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}