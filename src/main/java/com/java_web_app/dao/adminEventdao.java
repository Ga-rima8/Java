package com.java_web_app.dao;

import com.java_web_app.model.adminEventModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.*;

public class adminEventdao {

    

    public List<adminEventModel> getAllEvents() {
        List<adminEventModel> list = new ArrayList<>();
        String sql =
            "SELECT e.Events_id, e.Title, h.Name AS Host, c.Title AS Category, " +
            "e.Event_date, e.Event_location, e.Event_price, e.Event_image, " +
            "e.Event_desc, e.is_active " +
            "FROM events e " +
            "LEFT JOIN host h ON e.Host_id = h.Host_id " +
            "LEFT JOIN category c ON e.Category_id = c.Category_id " +
            "WHERE e.is_deleted = 0 ORDER BY e.Events_id DESC";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                adminEventModel m = new adminEventModel();
                m.setEventId(rs.getInt("Events_id"));
                m.setTitle(rs.getString("Title"));
                m.setHost(rs.getString("Host"));
                m.setCategory(rs.getString("Category"));
                m.setEventDate(rs.getString("Event_date"));
                m.setLocation(rs.getString("Event_location"));
                m.setPrice(rs.getDouble("Event_price"));
                m.setImageUrl(rs.getString("Event_image"));
                m.setDescription(rs.getString("Event_desc"));
                m.setActive(rs.getInt("is_active") == 1);
                list.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public adminEventModel getEventById(int id) {
        String sql =
            "SELECT e.Events_id, e.Title, h.Name AS Host, c.Title AS Category, " +
            "e.Event_date, e.Event_location, e.Event_price, e.Event_image, " +
            "e.Event_desc, e.is_active " +
            "FROM events e " +
            "LEFT JOIN host h ON e.Host_id = h.Host_id " +
            "LEFT JOIN category c ON e.Category_id = c.Category_id " +
            "WHERE e.Events_id = ? AND e.is_deleted = 0";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    adminEventModel m = new adminEventModel();
                    m.setEventId(rs.getInt("Events_id"));
                    m.setTitle(rs.getString("Title"));
                    m.setHost(rs.getString("Host"));
                    m.setCategory(rs.getString("Category"));
                    m.setEventDate(rs.getString("Event_date"));
                    m.setLocation(rs.getString("Event_location"));
                    m.setPrice(rs.getDouble("Event_price"));
                    m.setImageUrl(rs.getString("Event_image"));
                    m.setDescription(rs.getString("Event_desc"));
                    m.setActive(rs.getInt("is_active") == 1);
                    return m;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateEvent(adminEventModel e) {
        String sql =
            "UPDATE events SET Title=?, Event_date=?, Event_location=?, " +
            "Event_price=?, Event_desc=?, Event_image=? WHERE Events_id=?";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getTitle());
            ps.setString(2, e.getEventDate());
            ps.setString(3, e.getLocation());
            ps.setDouble(4, e.getPrice());
            ps.setString(5, e.getDescription());
            ps.setString(6, e.getImageUrl());
            ps.setInt(7, e.getEventId());
            return ps.executeUpdate() > 0;
        } catch (Exception ex) { ex.printStackTrace(); return false; }
    }

    public boolean toggleStatus(int eventId, int newStatus) {
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE events SET is_active=? WHERE Events_id=?")) {
            ps.setInt(1, newStatus);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

   

    public int getTotalEvents() {
        return queryCount("SELECT COUNT(*) FROM events WHERE is_deleted=0");
    }

    public int getActiveEvents() {
        return queryCount("SELECT COUNT(*) FROM events WHERE is_deleted=0 AND is_active=1");
    }

    public int getInactiveEvents() {
        return queryCount("SELECT COUNT(*) FROM events WHERE is_deleted=0 AND is_active=0");
    }

    public int getTotalBookings() {
        return queryCount("SELECT COUNT(*) FROM bookings");
    }

    public int getConfirmedBookings() {
        return queryCount("SELECT COUNT(*) FROM bookings WHERE booking_status='confirmed'");
    }

    public int getPendingBookings() {
        return queryCount("SELECT COUNT(*) FROM bookings WHERE booking_status='pending'");
    }

    public int getCancelledBookings() {
        return queryCount("SELECT COUNT(*) FROM bookings WHERE booking_status='cancelled'");
    }

    public double getTotalRevenue() {
        String sql =
            "SELECT COALESCE(SUM(e.Event_price), 0) " +
            "FROM bookings b JOIN events e ON b.Event_id = e.Events_id " +
            "WHERE b.booking_status = 'confirmed'";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public double getCancelRate() {
        int total = getTotalBookings();
        if (total == 0) return 0;
        int cancelled = getCancelledBookings();
        return Math.round((cancelled * 100.0 / total) * 10.0) / 10.0;
    }

   
    public List<Map<String, Object>> getEventStats() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql =
            "SELECT e.Title, COUNT(b.Booking_id) AS cnt " +
            "FROM events e LEFT JOIN bookings b ON e.Events_id = b.Event_id " +
            "WHERE e.is_deleted=0 " +
            "GROUP BY e.Events_id, e.Title ORDER BY cnt DESC LIMIT 8";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Object[]> rows = new ArrayList<>();
            int max = 1;
            while (rs.next()) {
                int cnt = rs.getInt("cnt");
                if (cnt > max) max = cnt;
                rows.add(new Object[]{ rs.getString("Title"), cnt });
            }
            for (Object[] row : rows) {
                int cnt = (int) row[1];
                Map<String, Object> m = new HashMap<>();
                m.put("eventName",    row[0]);
                m.put("bookingCount", cnt);
                m.put("fillPercent",  (int) Math.round(cnt * 100.0 / max));
                list.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    
    public List<Map<String, Object>> getEventAnalysis() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql =
            "SELECT e.Title, " +
            "COALESCE(e.Capacity, 100) AS capacity, " +
            "COUNT(b.Booking_id) AS booked, " +
            "COALESCE(SUM(CASE WHEN b.booking_status='confirmed' " +
            "   THEN e.Event_price ELSE 0 END), 0) AS revenue " +
            "FROM events e LEFT JOIN bookings b ON e.Events_id = b.Event_id " +
            "WHERE e.is_deleted=0 " +
            "GROUP BY e.Events_id, e.Title, e.Capacity, e.Event_price " +
            "ORDER BY booked DESC";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int booked   = rs.getInt("booked");
                int capacity = rs.getInt("capacity");
                if (capacity == 0) capacity = 100;
                int fillRate = (int) Math.min(Math.round(booked * 100.0 / capacity), 100);
                Map<String, Object> m = new HashMap<>();
                m.put("eventName", rs.getString("Title"));
                m.put("booked",    booked);
                m.put("capacity",  capacity);
                m.put("fillRate",  fillRate);
                m.put("revenue",   String.format("%.2f", rs.getDouble("revenue")));
                list.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

   
    private int queryCount(String sql) {
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}