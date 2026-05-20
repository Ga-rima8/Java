package com.hangaura.service;

import com.hangaura.Model.UserModel;
import com.hangaura.utils.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Service layer for the `user` table.
 *
 * DB columns:
 *   user_id, first_name, last_name, username, email,
 *   number, gender, dob, password, profile_image,
 *   program_id, created_at
 *
 * TABLE NAME: `user`  (NOT `users`)
 * PHONE COLUMN: `number`  (NOT `phone`)
 */
public class UserService {

    // ── Shared row mapper ──────────────────────────────────────────────────

    private UserModel mapRow(ResultSet rs) throws Exception {
        UserModel user = new UserModel();
        user.setUserId   (rs.getInt   ("user_id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName (rs.getString("last_name"));
        user.setUserName (rs.getString("username"));
        user.setEmail    (rs.getString("email"));
        user.setNumber   (rs.getString("number"));
        user.setGender   (rs.getString("gender"));
        user.setDob      (rs.getDate  ("dob"));
        user.setPassword (rs.getString("password"));
        user.setProgramId(rs.getInt   ("program_id"));
        byte[] img = rs.getBytes("profile_image");
        if (img != null && img.length > 0) {
            user.setProfileImage(img);
        }
        return user;
    }

    // ── Get user by ID ─────────────────────────────────────────────────────

    public UserModel getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Get user by username (for login) ───────────────────────────────────

    public UserModel getUserByUsername(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Get user by email ──────────────────────────────────────────────────

    public UserModel getUserByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Update user profile ────────────────────────────────────────────────
    //
    // Two SQL variants:
    //   WITH image    → also updates profile_image column
    //   WITHOUT image → leaves profile_image column untouched in DB

    public boolean updateUser(UserModel user) {
        boolean hasImage = user.getProfileImage() != null
                        && user.getProfileImage().length > 0;

        String sql = hasImage
            ? "UPDATE user SET " +
              "first_name=?, last_name=?, username=?, email=?, " +
              "number=?, gender=?, dob=?, password=?, profile_image=? " +
              "WHERE user_id=?"
            : "UPDATE user SET " +
              "first_name=?, last_name=?, username=?, email=?, " +
              "number=?, gender=?, dob=?, password=? " +
              "WHERE user_id=?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUserName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getNumber());
            ps.setString(6, user.getGender());
            ps.setDate  (7, user.getDob());
            ps.setString(8, user.getPassword());

            if (hasImage) {
                ps.setBytes(9,  user.getProfileImage());
                ps.setInt  (10, user.getUserId());
            } else {
                ps.setInt  (9, user.getUserId());
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Update password only ───────────────────────────────────────────────

    public boolean updatePassword(int userId, String hashedPassword) {
        String sql = "UPDATE user SET password=? WHERE user_id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setInt   (2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Check if username already taken ───────────────────────────────────

    public boolean usernameExists(String username) {
        String sql = "SELECT 1 FROM user WHERE username = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Check if email already taken ──────────────────────────────────────

    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM user WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}