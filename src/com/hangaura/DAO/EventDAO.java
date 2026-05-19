package com.hangaura.DAO;

import com.hangaura.Model.EventModel;
import com.hangaura.utils.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CRUD for the `event` table.
 * TABLE NAMES: event, category, registration  (no trailing 's' — matches DB schema)
 *
 * Expected `event` columns:
 *   event_id, event_name, event_date, event_time, event_location,
 *   description, host, price, category_id
 *
 * Expected `registration` columns:
 *   registration_id, user_id, event_id, registered_at
 */
public class EventDAO {

    // ── All events with category name joined ──────────────────────────────
    public List<EventModel> getAllEvents() throws SQLException {
        String sql = "SELECT e.*, c.category_name " +
                     "FROM event e " +
                     "LEFT JOIN category c ON e.category_id = c.category_id " +
                     "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── N most recent events ──────────────────────────────────────────────
    public List<EventModel> getRecentEvents(int limit) throws SQLException {
        String sql = "SELECT e.*, c.category_name " +
                     "FROM event e " +
                     "LEFT JOIN category c ON e.category_id = c.category_id " +
                     "ORDER BY e.event_date DESC LIMIT ?";
        List<EventModel> list = new ArrayList<>();
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── Upcoming events (date >= today) ───────────────────────────────────
    public List<EventModel> getUpcomingEvents() throws SQLException {
        String sql = "SELECT e.*, c.category_name " +
                     "FROM event e " +
                     "LEFT JOIN category c ON e.category_id = c.category_id " +
                     "WHERE e.event_date >= CURDATE() " +
                     "ORDER BY e.event_date";
        List<EventModel> list = new ArrayList<>();
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Events a specific user is registered for ──────────────────────────
    public List<EventModel> getRegisteredEvents(int userId) throws SQLException {
        String sql = "SELECT e.*, c.category_name " +
                     "FROM event e " +
                     "JOIN registration r ON e.event_id = r.event_id " +
                     "LEFT JOIN category c ON e.category_id = c.category_id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── Count of all events ───────────────────────────────────────────────
    public int countEvents() throws SQLException {
        try (Connection c = DBConfig.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM event")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ── Count of upcoming events ──────────────────────────────────────────
    public int countUpcoming() throws SQLException {
        try (Connection c = DBConfig.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(
                     "SELECT COUNT(*) FROM event WHERE event_date >= CURDATE()")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ── Row mapper ────────────────────────────────────────────────────────
    private EventModel mapRow(ResultSet rs) throws SQLException {
        EventModel e = new EventModel();
        e.setEventId      (rs.getInt   ("event_id"));
        e.setEventName    (rs.getString("event_name"));
        e.setEventDate    (rs.getDate  ("event_date"));
        e.setEventTime    (rs.getString("event_time"));       // nullable — returns null if absent
        e.setEventLocation(rs.getString("event_location"));
        e.setDescription  (rs.getString("description"));
        e.setHost         (rs.getString("host"));             // nullable
        e.setPrice        (rs.getDouble("price"));            // 0 if null
        e.setCategoryId   (rs.getInt   ("category_id"));
        e.setCategory     (rs.getString("category_name"));    // from JOIN
        return e;
    }
}