package com.java_web_app.dao;

import com.java_web_app.model.EventModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class EventDAO {

    
    private static final String SELECT_COLS =
            "SELECT e.event_id, e.event_name, e.event_date, e.event_location, " +
            "       e.description, e.category_id, e.max_capacity, " +
            "       c.category_name, " +
            "       (SELECT COUNT(*) FROM registration r WHERE r.event_id = e.event_id) AS reg_count ";

    private static final String FROM_JOIN =
            "FROM event e " +
            "LEFT JOIN category c ON e.category_id = c.category_id ";

    

    public List<EventModel> getAllEvents() throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN + "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

   

    public List<EventModel> getRecentEvents(int limit) throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN + "ORDER BY e.created_at DESC LIMIT ?";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

   

    public List<EventModel> getUpcomingEvents() throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN +
                     "WHERE e.event_date >= CURDATE() " +
                     "ORDER BY e.event_date";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    

    public List<EventModel> getRegisteredEvents(int userId) throws SQLException {
        String sql = SELECT_COLS + FROM_JOIN +
                     "JOIN registration reg ON e.event_id = reg.event_id " +
                     "WHERE reg.user_id = ? " +
                     "ORDER BY e.event_date DESC";
        List<EventModel> list = new ArrayList<>();
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventModel ev = mapRow(rs);
                    ev.setStatus("confirmed");  
                    list.add(ev);
                }
            }
        }
        return list;
    }

  
    public int countEvents() throws SQLException {
        try (Connection con = DBconfig.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM event")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

   

    public int countUpcoming() throws SQLException {
        try (Connection con = DBconfig.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(
                     "SELECT COUNT(*) FROM event WHERE event_date >= CURDATE()")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

   
    private EventModel mapRow(ResultSet rs) throws SQLException {
        EventModel e = new EventModel();
        e.setEventId      (rs.getInt   ("event_id"));
        e.setEventName    (rs.getString("event_name"));
        e.setEventDate    (rs.getDate  ("event_date"));
        e.setEventLocation(rs.getString("event_location"));
        e.setDescription  (rs.getString("description"));
        e.setCategoryId   (rs.getInt   ("category_id"));
        e.setMaxCapacity  (rs.getInt   ("max_capacity"));
        e.setCategory     (rs.getString("category_name"));  
        e.setCapacity     (rs.getInt   ("reg_count"));     
       
        return e;
    }
}