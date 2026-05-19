package com.java_web_app.dao;

import com.java_web_app.model.EventModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Eventdao {

    public List<EventModel> getAllEvents() {
        List<EventModel> list = new ArrayList<>();
        String sql = "SELECT e.Events_id, e.Title, h.Name AS host_name, " +
                     "c.Title AS category_name, e.Event_date, e.Event_location, " +
                     "e.Event_price, e.Event_image, e.Event_desc, e.is_deleted " +
                     "FROM events e " +
                     "LEFT JOIN host h ON e.Host_id = h.Host_id " +
                     "LEFT JOIN category c ON e.Category_id = c.Category_id " +
                     "ORDER BY e.Event_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                EventModel e = new EventModel();
                e.setEventId(rs.getInt("Events_id"));
                e.setTitle(rs.getString("Title"));
                e.setHost(rs.getString("host_name"));
                e.setCategory(rs.getString("category_name"));
                e.setEventDate(rs.getString("Event_date"));
                e.setLocation(rs.getString("Event_location"));
                e.setPrice(rs.getDouble("Event_price"));
                e.setImageUrl(rs.getString("Event_image"));
                e.setDescription(rs.getString("Event_desc"));
                e.setActive(rs.getInt("is_deleted") == 0);
                list.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean updateEvent(EventModel e) {
        String sql = "UPDATE events SET Title=?, " +
                     "Host_id=(SELECT Host_id FROM host WHERE Name=?), " +
                     "Category_id=(SELECT Category_id FROM category WHERE Title=?), " +
                     "Event_date=?, Event_location=?, Event_price=?, " +
                     "Event_desc=?, Event_image=? WHERE Events_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, e.getTitle());
            ps.setString(2, e.getHost());
            ps.setString(3, e.getCategory());
            ps.setString(4, e.getEventDate());
            ps.setString(5, e.getLocation());
            ps.setDouble(6, e.getPrice());
            ps.setString(7, e.getDescription());
            ps.setString(8, e.getImageUrl());
            ps.setInt(9, e.getEventId());
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean toggleStatus(int eventId, int newStatus) {
        // newStatus 1 = activate = is_deleted 0
        // newStatus 0 = deactivate = is_deleted 1
        String sql = "UPDATE events SET is_deleted=? WHERE Events_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newStatus == 1 ? 0 : 1);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public int getTotalEvents() {
        return getSingleCount("SELECT COUNT(*) FROM events");
    }

    public int getActiveEvents() {
        return getSingleCount("SELECT COUNT(*) FROM events WHERE is_deleted = 0");
    }

    public int getInactiveEvents() {
        return getSingleCount("SELECT COUNT(*) FROM events WHERE is_deleted = 1");
    }

    public int getTotalBookings() {
        return getSingleCount("SELECT COUNT(*) FROM bookings");
    }

    public int getConfirmedBookings() {
        return getSingleCount("SELECT COUNT(*) FROM bookings WHERE status = 'confirmed'");
    }

    public int getPendingBookings() {
        return getSingleCount("SELECT COUNT(*) FROM bookings WHERE status = 'pending'");
    }

    public int getCancelledBookings() {
        return getSingleCount("SELECT COUNT(*) FROM bookings WHERE status = 'cancelled'");
    }

    private int getSingleCount(String sql) {
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
}