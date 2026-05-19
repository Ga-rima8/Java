package com.hangaura.controller;

import com.hangaura.Model.UserModel;
import com.hangaura.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

/**
 * ProfileServlet  —  /profile  (GET + POST)
 *
 * Matches your actual codebase:
 *   Model  : com.hangaura.Model.UserModel
 *   Service: com.hangaura.service.UserService
 *   PK     : userId
 *   Image  : stored as BLOB (byte[])
 */
@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    // ═══════════════════════════════════════════════════════
    // GET  → SHOW PROFILE PAGE
    // ═══════════════════════════════════════════════════════
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", session.getAttribute("user"));

        req.getRequestDispatcher("/WEB-INF/Pages/profile.jsp")
           .forward(req, resp);
    }

    // ═══════════════════════════════════════════════════════
    // POST  → UPDATE PROFILE
    // ═══════════════════════════════════════════════════════
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserModel current = (UserModel) session.getAttribute("user");

        try {

            // ─────────────────────────────────────────────
            // GET FORM VALUES
            // ─────────────────────────────────────────────
            String firstName = trim(req.getParameter("firstName"));
            String lastName  = trim(req.getParameter("lastName"));
            String username  = trim(req.getParameter("username"));
            String email     = trim(req.getParameter("email"));
            String phone     = trim(req.getParameter("phone"));
            String dobStr    = trim(req.getParameter("dob"));
            String gender    = trim(req.getParameter("gender"));
            String password  = req.getParameter("password");

            // ─────────────────────────────────────────────
            // VALIDATION
            // ─────────────────────────────────────────────
            if (firstName.isEmpty() ||
                lastName.isEmpty()  ||
                username.isEmpty()  ||
                email.isEmpty()) {

                error(session,
                        "First name, last name, username and email are required.");

                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            if (!email.matches("^[^@\\\\s]+@[^@\\\\s]+\\\\.[^@\\\\s]+$")) {

                error(session, "Please enter a valid email address.");

                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            // ─────────────────────────────────────────────
            // DATE OF BIRTH
            // ─────────────────────────────────────────────
            Date dob = null;

            if (!dobStr.isEmpty()) {

                try {
                    dob = Date.valueOf(dobStr);

                } catch (IllegalArgumentException ignored) {
                }
            }

            // ─────────────────────────────────────────────
            // PROFILE IMAGE
            // ─────────────────────────────────────────────
            byte[] imageBytes = current.getProfileImage();

            Part filePart = req.getPart("profileImage");

            if (filePart != null && filePart.getSize() > 0) {

                String contentType = filePart.getContentType();

                if (contentType == null ||
                        !contentType.startsWith("image/")) {

                    error(session,
                            "Only image files are allowed.");

                    resp.sendRedirect(req.getContextPath() + "/profile");
                    return;
                }

                if (filePart.getSize() > 5 * 1024 * 1024) {

                    error(session,
                            "Image size must be under 5 MB.");

                    resp.sendRedirect(req.getContextPath() + "/profile");
                    return;
                }

                try (InputStream is = filePart.getInputStream()) {

                    imageBytes = is.readAllBytes();
                }
            }

            // ─────────────────────────────────────────────
            // BUILD UPDATED USER MODEL
            // ─────────────────────────────────────────────
            UserModel updated = new UserModel();

            updated.setUserId(current.getUserId());

            updated.setFirstName(firstName);
            updated.setLastName(lastName);
            updated.setUserName(username);

            updated.setEmail(email);
            updated.setNumber(phone);

            updated.setDob(dob);

            updated.setGender(
                    gender.isEmpty() ? null : gender
            );

            updated.setProfileImage(imageBytes);

            updated.setProgramId(current.getProgramId());

            // PASSWORD
            if (password != null &&
                    !password.trim().isEmpty()) {

                updated.setPassword(password.trim());

            } else {

                updated.setPassword(current.getPassword());
            }

            // ─────────────────────────────────────────────
            // UPDATE DATABASE
            // ─────────────────────────────────────────────
            boolean success = userService.updateUser(updated);

            if (success) {

                // refresh session user
                session.setAttribute("user", updated);

                session.setAttribute(
                        "message",
                        "Profile updated successfully!"
                );

            } else {

                error(session,
                        "Could not update profile. Please try again.");
            }

        } catch (Exception ex) {

            ex.printStackTrace();

            error(session,
                    "Unexpected error: " + ex.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    // ═══════════════════════════════════════════════════════
    // HELPER METHODS
    // ═══════════════════════════════════════════════════════

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }

    private void error(HttpSession session, String message) {
        session.setAttribute("error", message);
    }
}