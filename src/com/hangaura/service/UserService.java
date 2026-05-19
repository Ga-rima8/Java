package com.hangaura.service;

import com.hangaura.Model.UserModel;
import com.hangaura.utils.DBConfig;

import java.sql.*;

/**
 * UserService — higher-level service wrapping UserDAO operations.
 *
 * TABLE NAME : user         (no trailing 's' — matches DB schema)
 * PK column  : user_id
 * login col  : username     (NOT user_name)
 * image col  : profile_image  LONGBLOB
 */
public class UserService {

    // ═══════════════════════════════════════════════════════
    //  UPDATE USER  (called by ProfileServlet)
    // ═══════════════════════════════════════════════════════
    public boolean updateUser(UserModel user) {

        String sql = "UPDATE user SET "
                   + "  first_name    = ?, "
                   + "  last_name     = ?, "
                   + "  username      = ?, "    // column is `username`, NOT `user_name`
                   + "  email         = ?, "
                   + "  number        = ?, "
                   + "  dob           = ?, "
                   + "  gender        = ?, "
                   + "  password      = ?, "
                   + "  profile_image = ?, "
                   + "  program_id    = ? "
                   + "WHERE user_id   = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUserName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getNumber());

            if (user.getDob() != null) {
                ps.setDate(6, user.getDob());
            } else {
                ps.setNull(6, Types.DATE);
            }

            ps.setString(7, user.getGender());
            ps.setString(8, user.getPassword());

            byte[] img = user.getProfileImage();
            if (img != null && img.length > 0) {
                ps.setBytes(9, img);
            } else {
                ps.setNull(9, Types.LONGVARBINARY);
            }

            ps.setInt(10, user.getProgramId());
            ps.setInt(11, user.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ═══════════════════════════════════════════════════════
    //  GET USER BY ID
    // ═══════════════════════════════════════════════════════
    public UserModel getUserById(int id) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ═══════════════════════════════════════════════════════
    //  GET USER BY USERNAME
    // ═══════════════════════════════════════════════════════
    public UserModel getUserByUsername(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";   // column: username
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ═══════════════════════════════════════════════════════
    //  DELETE USER
    // ═══════════════════════════════════════════════════════
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ═══════════════════════════════════════════════════════
    //  USERNAME EXISTS CHECK
    // ═══════════════════════════════════════════════════════
    public boolean usernameExists(String username) {
        String sql = "SELECT user_id FROM user WHERE username = ?";   // column: username
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ═══════════════════════════════════════════════════════
    //  SHARED ROW MAPPER
    // ═══════════════════════════════════════════════════════
    private UserModel mapRow(ResultSet rs) throws SQLException {
        UserModel u = new UserModel();
        u.setUserId      (rs.getInt   ("user_id"));
        u.setFirstName   (rs.getString("first_name"));
        u.setLastName    (rs.getString("last_name"));
        u.setUserName    (rs.getString("username"));        // column: username
        u.setEmail       (rs.getString("email"));
        u.setNumber      (rs.getString("number"));
        u.setGender      (rs.getString("gender"));
        u.setDob         (rs.getDate  ("dob"));
        u.setPassword    (rs.getString("password"));
        u.setProfileImage(rs.getBytes ("profile_image"));
        u.setProgramId   (rs.getInt   ("program_id"));
        return u;
    }
}