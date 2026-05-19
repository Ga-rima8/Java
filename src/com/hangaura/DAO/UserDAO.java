package com.hangaura.DAO;

import com.hangaura.Model.UserModel;
import com.hangaura.utils.DBConfig;
import com.hangaura.utils.PasswordUtil;

import java.sql.*;

/**
 * CRUD operations for the `user` table.
 *
 * TABLE NAME : user         (no trailing 's')
 * PK column  : user_id
 * phone col  : number
 * login col  : username     (NOT user_name)
 */
public class UserDAO {

    // ── CREATE ───────────────────────────────────────────────────────────
    public boolean registerUser(UserModel u) throws SQLException {
        String sql = "INSERT INTO user " +
                     "(first_name, last_name, username, email, number, gender, dob, password, program_id) " +
                     "VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFirstName());
            ps.setString(2, u.getLastName());
            ps.setString(3, u.getUserName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getNumber());
            ps.setString(6, u.getGender());
            ps.setDate  (7, u.getDob());
            ps.setString(8, u.getPassword()); // already hashed in RegisterServlet
            ps.setInt   (9, u.getProgramId() > 0 ? u.getProgramId() : 1);
            return ps.executeUpdate() > 0;
        }
    }

    // ── READ: login ───────────────────────────────────────────────────────
    public UserModel login(String username, String password) throws SQLException {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password");
                    if (PasswordUtil.verify(password, hashed)) {
                        return mapRow(rs);
                    }
                }
            }
        }
        return null;
    }

    // ── READ: by id ───────────────────────────────────────────────────────
    public UserModel getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // ── READ: by username ─────────────────────────────────────────────────
    public UserModel getUserByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // ── READ: username exists? ────────────────────────────────────────────
    public boolean usernameExists(String username) throws SQLException {
        String sql = "SELECT 1 FROM user WHERE username = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ── READ: email exists? ───────────────────────────────────────────────
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM user WHERE email = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ── UPDATE: profile ───────────────────────────────────────────────────
    public boolean updateProfile(UserModel u) throws SQLException {
        String sql = "UPDATE user SET " +
                     "first_name=?, last_name=?, email=?, number=?, gender=?, dob=? " +
                     "WHERE user_id=?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFirstName());
            ps.setString(2, u.getLastName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getNumber());
            ps.setString(5, u.getGender());
            ps.setDate  (6, u.getDob());
            ps.setInt   (7, u.getUserId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── UPDATE: full profile (including username & program) ───────────────
    public boolean updateUser(UserModel u) throws SQLException {
        String sql = "UPDATE user SET " +
                     "first_name=?, last_name=?, username=?, email=?, " +
                     "number=?, gender=?, dob=?, program_id=? " +
                     "WHERE user_id=?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFirstName());
            ps.setString(2, u.getLastName());
            ps.setString(3, u.getUserName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getNumber());
            ps.setString(6, u.getGender());
            ps.setDate  (7, u.getDob());
            ps.setInt   (8, u.getProgramId());
            ps.setInt   (9, u.getUserId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── UPDATE: password ──────────────────────────────────────────────────
    public boolean updatePassword(int userId, String newPassword) throws SQLException {
        String sql = "UPDATE user SET password=? WHERE user_id=?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, PasswordUtil.hash(newPassword));
            ps.setInt   (2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── UPDATE: profile image ─────────────────────────────────────────────
    public boolean updateProfileImage(int userId, byte[] imageBytes) throws SQLException {
        String sql = "UPDATE user SET profile_image=? WHERE user_id=?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBytes(1, imageBytes);
            ps.setInt  (2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── READ: image bytes ─────────────────────────────────────────────────
    public byte[] getProfileImage(String username) throws SQLException {
        String sql = "SELECT profile_image FROM user WHERE username = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBytes("profile_image");
            }
        }
        return null;
    }

    // ── DELETE ────────────────────────────────────────────────────────────
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM user WHERE user_id=?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── MAPPER ────────────────────────────────────────────────────────────
    private UserModel mapRow(ResultSet rs) throws SQLException {
        UserModel u = new UserModel();
        u.setUserId   (rs.getInt   ("user_id"));
        u.setFirstName(rs.getString("first_name"));
        u.setLastName (rs.getString("last_name"));
        u.setUserName (rs.getString("username"));   // column is `username`
        u.setEmail    (rs.getString("email"));
        u.setNumber   (rs.getString("number"));     // column is `number`
        u.setGender   (rs.getString("gender"));
        u.setDob      (rs.getDate  ("dob"));
        u.setPassword (rs.getString("password"));
        u.setProgramId(rs.getInt   ("program_id"));
        byte[] img = rs.getBytes("profile_image");
        if (img != null && img.length > 0) u.setProfileImage(img);
        return u;
    }
}