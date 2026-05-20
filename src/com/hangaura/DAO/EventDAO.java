package com.hangaura.DAO;

import com.hangaura.Model.EventModel;
import com.hangaura.utils.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CRUD for the `event` table.
 *
 * Actual DB columns (hangaura_db):
 *   event_id, event_name, event_date, event_location,
 *   description, category_id, max_capacity, created_at
 *
 * Every query also fetches:
 *   category_name  — LEFT JOIN on `category`
 *   reg_count      — subquery COUNT from `registration` (mapped to EventModel.capacity)
 *
 * host / price / event_time columns do NOT exist — never referenced here.
 */
public class EventDAO {

    // ── Shared SELECT fragment ─────────────────────────────────────────────
    //
    // Subquery for current registration count keeps the queries readable and
    // avoids GROUP BY complications when other JOINs are present.

    private static final String SELECT_COLS =
            "SELECT e.event_id, e.event_name, e.event_date, e.event_location, " +
            "       e.description, e.category_id, e.max_capacity, " +
            "       c.category_name, " +
            "       (SELECT COUNT(*) FROM registration r WHERE r.event_id = e.event_id) AS reg_count ";

    private static final String FROM_JOIN =
            "FROM event e " +
            "LEFT JOIN category c ON e.category_id = c.category_id ";

    // ── All events ─────────────────────────────────────────────────────────

    public List<EventModel> getAllEvents() throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN + "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── N most recently created events ─────────────────────────────────────

    public List<EventModel> getRecentEvents(int limit) throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN + "ORDER BY e.created_at DESC LIMIT ?";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── Upcoming events (event_date >= today) ──────────────────────────────

    public List<EventModel> getUpcomingEvents() throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN +
                     "WHERE e.event_date >= CURDATE() " +
                     "ORDER BY e.event_date";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Events a specific user is registered for ───────────────────────────

    public List<EventModel> getRegisteredEvents(int userId) throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN +
                     "JOIN registration reg ON e.event_id = reg.event_id " +
                     "WHERE reg.user_id = ? " +
                     "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventModel ev = mapRow(rs);
                    ev.setStatus("confirmed");   // all rows in registration are confirmed
                    list.add(ev);
                }
            }
        }
        return list;
    }

    // ── Count of all events ────────────────────────────────────────────────

    public int countEvents() throws SQLException {
        try (Connection con = DBConfig.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM event")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ── Count of upcoming events ───────────────────────────────────────────

    public int countUpcoming() throws SQLException {
        try (Connection con = DBConfig.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(
                     "SELECT COUNT(*) FROM event WHERE event_date >= CURDATE()")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ── Row mapper ─────────────────────────────────────────────────────────
    //
    // Maps only columns that actually exist in the DB plus the two
    // computed columns (category_name alias, reg_count alias).

    private EventModel mapRow(ResultSet rs) throws SQLException {
        EventModel e = new EventModel();
        e.setEventId      (rs.getInt   ("event_id"));
        e.setEventName    (rs.getString("event_name"));
        e.setEventDate    (rs.getDate  ("event_date"));
        e.setEventLocation(rs.getString("event_location"));
        e.setDescription  (rs.getString("description"));
        e.setCategoryId   (rs.getInt   ("category_id"));
        e.setMaxCapacity  (rs.getInt   ("max_capacity"));
        e.setCategory     (rs.getString("category_name"));  // from LEFT JOIN
        e.setCapacity     (rs.getInt   ("reg_count"));      // subquery count
        // status left as null unless caller sets it (e.g. "confirmed")
        return e;
    }
}