package com.java_web_app.dao;

import com.java_web_app.model.UserModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class UserinfoDAO {

   
    public List<UserModel> getAllUsers() {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT u.* FROM user u " +
                     "ORDER BY u.user_id DESC";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

   
    public UserModel getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    
    public UserModel verifyLogin(String username, String password) {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

   
    public String getUserStatus(int userId) {
        String sql = "SELECT status FROM userinfo WHERE user_id = ?";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("status");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "pending"; 
    }

    
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM user";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    
    private UserModel mapRow(ResultSet rs) throws SQLException {
        UserModel u = new UserModel();
        u.setUserId(rs.getInt("user_id"));
        u.setFirstName(rs.getString("first_name"));
        u.setLastName(rs.getString("last_name"));
        u.setUserName(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setNumber(rs.getString("number"));
        u.setGender(rs.getString("gender"));
        u.setDob(rs.getDate("dob"));
        u.setPassword(rs.getString("password"));
        u.setProfileImage(rs.getBytes("profile_image"));
        u.setProgramId(rs.getInt("program_id"));
        return u;
    }
}