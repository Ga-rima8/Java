package com.java_web_app.dao;

import com.java_web_app.model.UserModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<UserModel> getAllUsers() {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, phone, gender, status, created_at " +
                     "FROM users ORDER BY created_at DESC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserModel u = new UserModel();
                u.setUserId(rs.getInt("user_id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setGender(rs.getString("gender"));
                u.setStatus(rs.getString("status"));
                u.setCreatedAt(rs.getString("created_at"));
                list.add(u);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getTotalUsers()    { return getCount("SELECT COUNT(*) FROM users"); }
    public int getPendingUsers()  { return getCount("SELECT COUNT(*) FROM users WHERE status='pending'"); }
    public int getApprovedUsers() { return getCount("SELECT COUNT(*) FROM users WHERE status='approved'"); }
    public int getRejectedUsers() { return getCount("SELECT COUNT(*) FROM users WHERE status='rejected'"); }

    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE users SET status=? WHERE user_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    private int getCount(String sql) {
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