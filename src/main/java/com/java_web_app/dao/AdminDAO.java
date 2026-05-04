package com.java_web_app.dao;

import com.java_web_app.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {
    
    // Get total counts for dashboard cards
    public Map<String, Integer> getDashboardCounts() {
        Map<String, Integer> counts = new HashMap<>();
        String sql = "SELECT " +
                     "(SELECT COUNT(*) FROM events) as total_events, " +
                     "(SELECT COUNT(*) FROM visitor) as total_visitors, " +
                     "(SELECT COUNT(*) FROM host) as total_hosts, " +
                     "(SELECT COUNT(*) FROM event_registration) as total_registrations, " +
                     "(SELECT COUNT(*) FROM review) as total_reviews";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                counts.put("events", rs.getInt("total_events"));
                counts.put("visitors", rs.getInt("total_visitors"));
                counts.put("hosts", rs.getInt("total_hosts"));
                counts.put("registrations", rs.getInt("total_registrations"));
                counts.put("reviews", rs.getInt("total_reviews"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }
    
    // Get all events for the admin to view
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
                event.put("eventId", rs.getInt("Events_id"));
                event.put("title", rs.getString("Title"));
                event.put("hostName", rs.getString("host_name"));
                event.put("category", rs.getString("category_title"));
                event.put("date", rs.getDate("Event_date"));
                event.put("location", rs.getString("Event_location"));
                event.put("price", rs.getBigDecimal("Event_price"));
                event.put("description", rs.getString("Event_desc"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    // Get all visitors
    public List<Map<String, Object>> getAllVisitors() {
        List<Map<String, Object>> visitors = new ArrayList<>();
        String sql = "SELECT Visitor_id, Name, Email, Citizenship_id FROM visitor";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> visitor = new HashMap<>();
                visitor.put("id", rs.getInt("Visitor_id"));
                visitor.put("name", rs.getString("Name"));
                visitor.put("email", rs.getString("Email"));
                visitor.put("citizenship", rs.getString("Citizenship_id"));
                visitors.add(visitor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return visitors;
    }
    
    // Get all event registrations
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
                reg.put("regId", rs.getInt("Event_registration_id"));
                reg.put("eventTitle", rs.getString("event_title"));
                reg.put("visitorName", rs.getString("visitor_name"));
                reg.put("regDate", rs.getDate("Registration_date"));
                regs.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return regs;
    }
}