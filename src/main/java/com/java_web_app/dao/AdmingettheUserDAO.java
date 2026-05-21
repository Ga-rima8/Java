package com.java_web_app.dao;

import com.java_web_app.model.AdmingetUserModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdmingettheUserDAO {

    public List<AdmingetUserModel> getAllUsers() {
        List<AdmingetUserModel> list = new ArrayList<>();
        String sql =
            "SELECT u.user_id, u.first_name, u.last_name, u.username, " +
            "u.email, u.number, u.gender, u.dob, u.program_id, u.created_at, " +
            "COALESCE(ui.status, 'pending') AS status " +
            "FROM user u " +
            "LEFT JOIN userinfo ui ON u.user_id = ui.user_id " +
            "ORDER BY u.user_id DESC";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int getTotalUsers() {
        return runCount("SELECT COUNT(*) FROM user", null);
    }

    public int getPendingUsers() {
        return runCount("SELECT COUNT(*) FROM userinfo WHERE status = ?", "pending");
    }

    public int getApprovedUsers() {
        return runCount("SELECT COUNT(*) FROM userinfo WHERE status = ?", "approved");
    }

    public int getRejectedUsers() {
        return runCount("SELECT COUNT(*) FROM userinfo WHERE status = ?", "rejected");
    }

    private int runCount(String sql, String param) {
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (param != null) ps.setString(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public boolean updateStatus(int userId, String status) {
        String sql = "INSERT INTO userinfo (user_id, status) VALUES (?, ?) " +
                     "ON DUPLICATE KEY UPDATE status = VALUES(status)";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    private AdmingetUserModel mapRow(ResultSet rs) throws SQLException {
        AdmingetUserModel m = new AdmingetUserModel();
        m.setUserId(rs.getInt("user_id"));
        m.setFirstName(rs.getString("first_name"));
        m.setLastName(rs.getString("last_name"));
        m.setUserName(rs.getString("username"));
        m.setEmail(rs.getString("email"));
        m.setNumber(rs.getString("number"));
        m.setGender(rs.getString("gender"));
        m.setDob(rs.getDate("dob"));
        m.setStatus(rs.getString("status"));
        m.setProgramId(rs.getInt("program_id"));
        m.setCreatedAt(rs.getString("created_at"));
        return m;
    }
}