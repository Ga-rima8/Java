package com.java_web_app.dao;

import com.java_web_app.model.AdminModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {

    // ════════════════════════════════════════════════════
    //  DASHBOARD
    // ════════════════════════════════════════════════════
	public Map<String, Integer> getDashboardCounts() {
	    Map<String, Integer> counts = new HashMap<>();
	    String sql = "SELECT " +
	                 "(SELECT COUNT(*) FROM events) as total_events, " +
	                 "(SELECT COUNT(*) FROM visitor) as total_visitors, " +
	                 "(SELECT COUNT(*) FROM host) as total_hosts, " +
	                 "(SELECT COUNT(*) FROM event_registration) as total_registrations";

	    try (Connection conn = DBconfig.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        if (rs.next()) {
	            counts.put("events",        rs.getInt("total_events"));
	            counts.put("visitors",      rs.getInt("total_visitors"));
	            counts.put("hosts",         rs.getInt("total_hosts"));
	            counts.put("registrations", rs.getInt("total_registrations"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return counts;
	}

    // ════════════════════════════════════════════════════
    //  GET ALL EVENTS AS MAP (used by events.jsp create page)
    // ════════════════════════════════════════════════════
    public List<Map<String, Object>> getAllEvents() {
        List<Map<String, Object>> events = new ArrayList<>();
        String sql = "SELECT e.*, h.Name as host_name, c.Title as category_title " +
                     "FROM events e " +
                     "LEFT JOIN host h ON e.Host_id = h.Host_id " +
                     "LEFT JOIN category c ON e.Category_id = c.Category_id " +
                     "ORDER BY e.Event_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> event = new HashMap<>();
                event.put("eventId",     rs.getInt("Events_id"));
                event.put("title",       rs.getString("Title"));
                event.put("hostName",    rs.getString("host_name"));
                event.put("category",    rs.getString("category_title"));
                event.put("date",        rs.getDate("Event_date"));
                event.put("location",    rs.getString("Event_location"));
                event.put("price",       rs.getBigDecimal("Event_price"));
                event.put("description", rs.getString("Event_desc"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // ════════════════════════════════════════════════════
    //  GET ALL EVENTS AS MODEL (used by updateEvents.jsp list)
    // ════════════════════════════════════════════════════
    public List<AdminModel> getAllEventsAsModel() {
        List<AdminModel> list = new ArrayList<>();
        String sql = "SELECT e.*, h.Name as host_name, c.Title as category_title " +
                     "FROM events e " +
                     "LEFT JOIN host h ON e.Host_id = h.Host_id " +
                     "LEFT JOIN category c ON e.Category_id = c.Category_id " +
                     "ORDER BY e.Event_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapEventRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ════════════════════════════════════════════════════
    //  GET SINGLE EVENT BY ID (pre-fill edit form)
    // ════════════════════════════════════════════════════
    public AdminModel getEventById(int id) {
        AdminModel model = null;
        String sql = "SELECT e.*, h.Name as host_name, c.Title as category_title " +
                     "FROM events e " +
                     "LEFT JOIN host h ON e.Host_id = h.Host_id " +
                     "LEFT JOIN category c ON e.Category_id = c.Category_id " +
                     "WHERE e.Events_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                model = mapEventRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return model;
    }

    // ════════════════════════════════════════════════════
    //  UPDATE EVENT (no image change)
    // ════════════════════════════════════════════════════
    public boolean updateEvent(AdminModel event) {
        String sql = "UPDATE events SET Title=?, Event_desc=?, Event_date=?, " +
                     "Event_location=?, Event_price=?, Host_id=?, Category_id=? " +
                     "WHERE Events_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1,     event.getEventTitle());
            stmt.setString(2,     event.getEventDescription());
            stmt.setDate(3,       event.getEventDate());
            stmt.setString(4,     event.getEventLocation());
            stmt.setBigDecimal(5, event.getEventPrice());
            stmt.setInt(6,        event.getHostId());
            stmt.setInt(7,        event.getCategoryId());
            stmt.setInt(8,        event.getEventId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ════════════════════════════════════════════════════
    //  UPDATE EVENT WITH NEW IMAGE
    // ════════════════════════════════════════════════════
    public boolean updateEventWithImage(AdminModel event) {
        String sql = "UPDATE events SET Title=?, Event_desc=?, Event_date=?, " +
                     "Event_location=?, Event_price=?, Host_id=?, Category_id=?, Image=? " +
                     "WHERE Events_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1,     event.getEventTitle());
            stmt.setString(2,     event.getEventDescription());
            stmt.setDate(3,       event.getEventDate());
            stmt.setString(4,     event.getEventLocation());
            stmt.setBigDecimal(5, event.getEventPrice());
            stmt.setInt(6,        event.getHostId());
            stmt.setInt(7,        event.getCategoryId());
            stmt.setString(8,     event.getEventImage());
            stmt.setInt(9,        event.getEventId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ════════════════════════════════════════════════════
    //  TOGGLE ACTIVE / INACTIVE
    // ════════════════════════════════════════════════════
    public boolean toggleEventActive(int eventId, boolean active) {
        String sql = "UPDATE events SET Is_active=? WHERE Events_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, active);
            stmt.setInt(2,    eventId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ════════════════════════════════════════════════════
    //  ALL VISITORS
    // ════════════════════════════════════════════════════
    public List<Map<String, Object>> getAllVisitors() {
        List<Map<String, Object>> visitors = new ArrayList<>();
        String sql = "SELECT Visitor_id, Name, Email, Citizenship_id FROM visitor";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> visitor = new HashMap<>();
                visitor.put("id",          rs.getInt("Visitor_id"));
                visitor.put("name",        rs.getString("Name"));
                visitor.put("email",       rs.getString("Email"));
                visitor.put("citizenship", rs.getString("Citizenship_id"));
                visitors.add(visitor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return visitors;
    }

    // ════════════════════════════════════════════════════
    //  ALL REGISTRATIONS
    // ════════════════════════════════════════════════════
    public List<Map<String, Object>> getAllRegistrations() {
        List<Map<String, Object>> regs = new ArrayList<>();
        String sql = "SELECT er.*, e.Title as event_title, v.Name as visitor_name " +
                     "FROM event_registration er " +
                     "JOIN events e ON er.Events_id = e.Events_id " +
                     "JOIN visitor v ON er.Visitor_id = v.Visitor_id " +
                     "ORDER BY er.Registration_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> reg = new HashMap<>();
                reg.put("regId",       rs.getInt("Event_registration_id"));
                reg.put("eventTitle",  rs.getString("event_title"));
                reg.put("visitorName", rs.getString("visitor_name"));
                reg.put("regDate",     rs.getDate("Registration_date"));
                regs.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return regs;
    }

    // ════════════════════════════════════════════════════
    //  HOSTS DROPDOWN
    // ════════════════════════════════════════════════════
    public List<Map<String, Object>> getAllHosts() {
        List<Map<String, Object>> hosts = new ArrayList<>();
        String sql = "SELECT Host_id, Name FROM host ORDER BY Name";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> h = new HashMap<>();
                h.put("id",   rs.getInt("Host_id"));
                h.put("name", rs.getString("Name"));
                hosts.add(h);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hosts;
    }

    // ════════════════════════════════════════════════════
    //  CATEGORIES DROPDOWN
    // ════════════════════════════════════════════════════
    public List<Map<String, Object>> getAllCategories() {
        List<Map<String, Object>> categories = new ArrayList<>();
        String sql = "SELECT Category_id, Title FROM category ORDER BY Title";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> c = new HashMap<>();
                c.put("id",    rs.getInt("Category_id"));
                c.put("title", rs.getString("Title"));
                categories.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // ════════════════════════════════════════════════════
    //  PRIVATE HELPER — ResultSet → AdminModel
    // ════════════════════════════════════════════════════
    private AdminModel mapEventRow(ResultSet rs) throws SQLException {
        AdminModel m = new AdminModel();
        m.setEventId(rs.getInt("Events_id"));
        m.setEventTitle(rs.getString("Title"));
        m.setEventDescription(rs.getString("Event_desc"));
        m.setEventDate(rs.getDate("Event_date"));
        m.setEventLocation(rs.getString("Event_location"));
        m.setEventPrice(rs.getBigDecimal("Event_price"));
        m.setHostId(rs.getInt("Host_id"));
        m.setHostName(rs.getString("host_name"));
        m.setCategoryId(rs.getInt("Category_id"));
        m.setCategoryName(rs.getString("category_title"));
        m.setEventImage(rs.getString("Image"));
        m.setActive(rs.getBoolean("Is_active"));
        return m;
    }
}