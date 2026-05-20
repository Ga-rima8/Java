package com.hangaura.DAO;

import com.hangaura.Model.UserModel;
import com.hangaura.utils.DBConfig;

import java.sql.*;

/**
 * DAO for the `user` table.
 */
public class UserDAO {

    // ─────────────────────────────────────────────────────────────
    // Fetch user by ID
    // ─────────────────────────────────────────────────────────────
    public UserModel getUserById(int userId) throws SQLException {

        String sql = "SELECT * FROM user WHERE user_id = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }

        return null;
    }

    // ─────────────────────────────────────────────────────────────
    // Fetch user by username
    // ─────────────────────────────────────────────────────────────
    public UserModel getUserByUsername(String username) throws SQLException {

        String sql = "SELECT * FROM user WHERE username = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }

        return null;
    }

    // ─────────────────────────────────────────────────────────────
    // Fetch user by email
    // ─────────────────────────────────────────────────────────────
    public UserModel getUserByEmail(String email) throws SQLException {

        String sql = "SELECT * FROM user WHERE email = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }

        return null;
    }

    // ─────────────────────────────────────────────────────────────
    // Insert new user
    // ─────────────────────────────────────────────────────────────
    public boolean insertUser(UserModel u) throws SQLException {

        String sql = "INSERT INTO user "
                + "(first_name, last_name, username, email, number, gender, dob, password, profile_image, program_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getFirstName());
            ps.setString(2, u.getLastName());
            ps.setString(3, u.getUserName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getNumber());
            ps.setString(6, u.getGender());
            ps.setDate(7, u.getDob());
            ps.setString(8, u.getPassword());

            if (u.getProfileImage() != null) {
                ps.setBytes(9, u.getProfileImage());
            } else {
                ps.setNull(9, Types.BLOB);
            }

            ps.setInt(10, u.getProgramId() > 0 ? u.getProgramId() : 1);

            return ps.executeUpdate() > 0;
        }
    }

    // ─────────────────────────────────────────────────────────────
    // Update user profile
    // ─────────────────────────────────────────────────────────────
    public boolean updateUser(UserModel u) throws SQLException {

        String sql = "UPDATE user "
                + "SET first_name=?, "
                + "last_name=?, "
                + "email=?, "
                + "number=?, "
                + "gender=?, "
                + "dob=? "
                + "WHERE user_id=?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getFirstName());
            ps.setString(2, u.getLastName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getNumber());
            ps.setString(5, u.getGender());
            ps.setDate(6, u.getDob());
            ps.setInt(7, u.getUserId());

            return ps.executeUpdate() > 0;
        }
    }

    // ─────────────────────────────────────────────────────────────
    // Update password
    // ─────────────────────────────────────────────────────────────
    public boolean updatePassword(int userId, String hashedPassword)
            throws SQLException {

        String sql = "UPDATE user SET password=? WHERE user_id=?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        }
    }

    // ─────────────────────────────────────────────────────────────
    // Update profile image
    // ─────────────────────────────────────────────────────────────
    public boolean updateProfileImage(int userId, byte[] imageBytes)
            throws SQLException {

        if (imageBytes == null || imageBytes.length == 0) {
            return false;
        }

        String sql = "UPDATE user SET profile_image=? WHERE user_id=?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBytes(1, imageBytes);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        }
    }

    // ─────────────────────────────────────────────────────────────
    // Remove profile image
    // ─────────────────────────────────────────────────────────────
    public boolean removeProfileImage(int userId) throws SQLException {

        String sql = "UPDATE user SET profile_image = NULL WHERE user_id = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;
        }
    }

    // ─────────────────────────────────────────────────────────────
    // Map ResultSet → UserModel
    // ─────────────────────────────────────────────────────────────
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