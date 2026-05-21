package com.java_web_app.service;

import com.java_web_app.model.UserModel;
import com.java_web_app.utils.DBconfig;
import com.java_web_app.utils.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {

 
    private UserModel mapRow(ResultSet rs) throws SQLException {

        UserModel user = new UserModel();

        user.setUserId(rs.getInt("user_id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setUserName(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setNumber(rs.getString("number"));
        user.setGender(rs.getString("gender"));
        user.setDob(rs.getDate("dob"));
        user.setPassword(rs.getString("password"));
        user.setProgramId(rs.getInt("program_id"));

        
        try {
            byte[] img = rs.getBytes("profile_image");
            if (img != null && img.length > 0) {
                user.setProfileImage(img);
            }
        } catch (SQLException e) {
           
            System.err.println("Warning: profile_image column missing from DB. " +
                               "Run: ALTER TABLE user ADD COLUMN profile_image LONGBLOB;");
        }

        return user;
    }

   
    public UserModel getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

   
    public UserModel getUserByUsername(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

  
    public UserModel getUserByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    
    public UserModel login(String username, String password) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel user = mapRow(rs);
                    if (PasswordUtil.verify(password, user.getPassword())) {
                        return user;
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

   
    public String register(
            String firstName, String lastName, String username,
            String email, String number, String gender,
            String dobStr, String password, int programId) {

        try {
            if (firstName == null || firstName.isBlank()
                    || lastName  == null || lastName.isBlank()
                    || username  == null || username.isBlank()
                    || email     == null || email.isBlank()
                    || password  == null || password.isBlank()) {
                return "Please fill all required fields.";
            }
            if (usernameExists(username)) return "Username already exists.";
            if (emailExists(email))       return "Email already exists.";

            UserModel user = new UserModel();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setUserName(username);
            user.setEmail(email);
            user.setNumber(number);
            user.setGender(gender);
            user.setPassword(PasswordUtil.hash(password));
            user.setProgramId(programId > 0 ? programId : 1);

            if (dobStr != null && !dobStr.isBlank()) {
                user.setDob(java.sql.Date.valueOf(dobStr));
            }

            String sql = "INSERT INTO user " +
                    "(first_name, last_name, username, email, number, gender, dob, password, program_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection conn = DBconfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getFirstName());
                ps.setString(2, user.getLastName());
                ps.setString(3, user.getUserName());
                ps.setString(4, user.getEmail());
                ps.setString(5, user.getNumber());
                ps.setString(6, user.getGender());
                ps.setDate(7,   user.getDob());
                ps.setString(8, user.getPassword());
                ps.setInt(9,    user.getProgramId());

                if (ps.executeUpdate() > 0) return null; // success
            }
            return "Registration failed.";

        } catch (Exception e) {
            e.printStackTrace();
            return "Server error occurred.";
        }
    }

  
    public String updateProfile(
            int userId, String firstName, String lastName,
            String username, String email, String phone,
            String dobStr, String gender, String password,
            byte[] imageBytes, String imageContentType) {

        try {
            UserModel user = getUserById(userId);
            if (user == null) return "USER_NOT_FOUND";

            if (firstName == null || firstName.isBlank()
                    || lastName == null || lastName.isBlank()
                    || username == null || username.isBlank()
                    || email    == null || email.isBlank()) {
                return "Required fields cannot be empty.";
            }

            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setUserName(username);
            user.setEmail(email);
            user.setNumber(phone);
            user.setGender(gender);

            if (dobStr != null && !dobStr.isBlank()) {
                user.setDob(java.sql.Date.valueOf(dobStr));
            }

            if (password != null && !password.isBlank()) {
                user.setPassword(PasswordUtil.hash(password));
            }

            if (imageBytes != null && imageBytes.length > 0) {
                if (imageContentType == null ||
                        !(imageContentType.equals("image/png")
                                || imageContentType.equals("image/jpeg")
                                || imageContentType.equals("image/jpg"))) {
                    return "Only JPG, JPEG, and PNG images are allowed.";
                }
                user.setProfileImage(imageBytes);
            }

            if (!updateUser(user)) return "Failed to update profile.";
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return "Server error occurred.";
        }
    }

    
    public boolean updateUser(UserModel user) {

        boolean hasImage = user.getProfileImage() != null
                && user.getProfileImage().length > 0;

        String sql = hasImage
                ? "UPDATE user SET first_name=?, last_name=?, username=?, email=?, " +
                  "number=?, gender=?, dob=?, password=?, profile_image=? WHERE user_id=?"
                : "UPDATE user SET first_name=?, last_name=?, username=?, email=?, " +
                  "number=?, gender=?, dob=?, password=? WHERE user_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUserName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getNumber());
            ps.setString(6, user.getGender());
            ps.setDate(7,   user.getDob());
            ps.setString(8, user.getPassword());

            if (hasImage) {
                ps.setBytes(9,  user.getProfileImage());
                ps.setInt(10,   user.getUserId());
            } else {
                ps.setInt(9, user.getUserId());
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

  
    public boolean updatePassword(int userId, String hashedPassword) {
        String sql = "UPDATE user SET password=? WHERE user_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setInt(2,    userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    
    public boolean usernameExists(String username) {
        String sql = "SELECT 1 FROM user WHERE username = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

   
    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM user WHERE email = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

   
    public int computeProfileCompletion(UserModel user) {
        if (user == null) return 0;
        int filled = 0, total = 5;
        if (user.getFirstName() != null && !user.getFirstName().isEmpty()) filled++;
        if (user.getLastName()  != null && !user.getLastName().isEmpty())  filled++;
        if (user.getEmail()     != null && !user.getEmail().isEmpty())     filled++;
        if (user.getNumber()    != null && !user.getNumber().isEmpty())    filled++;
        if (user.getGender()    != null && !user.getGender().isEmpty())    filled++;
        return (filled * 100) / total;
    }
}