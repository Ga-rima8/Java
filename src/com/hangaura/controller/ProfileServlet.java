package com.hangaura.controller;

import com.hangaura.Model.UserModel;
import com.hangaura.service.UserService;
import com.hangaura.utils.ValidationUtil;

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

/**
 * Controller only.
 *
 * Fixed:
 *  - Validation rules (required fields, email format, image type) moved to UserService.
 *  - Password hashing moved to UserService.
 *  - Profile image type check moved to UserService.
 *  - Profile completion percentage computed by UserService and set as an attribute,
 *    so dashboard.jsp no longer computes it with inline JavaScript.
 *  - Auth guard consistently uses "userId".
 */
@WebServlet("/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB
        maxFileSize       = 5 * 1024 * 1024,  // 5 MB per file
        maxRequestSize    = 10 * 1024 * 1024  // 10 MB total
)
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    // ── GET: show profile page ─────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        UserModel user = userService.getUserById(userId);

        if (user == null) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        session.setAttribute("user", user);
        req.setAttribute("user",              user);

        // Profile completion computed in service — JSP just renders the number
        req.setAttribute("profileCompletion", userService.computeProfileCompletion(user));

        req.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(req, resp);
    }

    // ── POST: update profile ───────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // ── Extract raw HTTP inputs (controller responsibility) ────────────
        String firstName = ValidationUtil.clean(req.getParameter("firstName"));
        String lastName  = ValidationUtil.clean(req.getParameter("lastName"));
        String username  = ValidationUtil.clean(req.getParameter("username"));
        String email     = ValidationUtil.clean(req.getParameter("email"));
        String phone     = ValidationUtil.clean(req.getParameter("phone"));
        String dobStr    = ValidationUtil.clean(req.getParameter("dob"));
        String gender    = ValidationUtil.clean(req.getParameter("gender"));
        String password  = req.getParameter("password");   // not cleaned — may contain special chars

        // ── Read image bytes (I/O is controller responsibility) ────────────
        byte[] imageBytes       = null;
        String imageContentType = null;

        try {
            Part filePart = req.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                imageContentType = filePart.getContentType();
                try (InputStream is = filePart.getInputStream()) {
                    imageBytes = is.readAllBytes();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Image upload failed. Please try again.");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // ── Delegate ALL business logic to the service ─────────────────────
        String error = userService.updateProfile(
                userId,
                firstName, lastName, username, email,
                phone, dobStr, gender, password,
                imageBytes, imageContentType);

        if ("USER_NOT_FOUND".equals(error)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (error != null) {
            session.setAttribute("error", error);
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // ── Refresh session with updated user ──────────────────────────────
        UserModel updatedUser = userService.getUserById(userId);
        if (updatedUser != null) {
            session.setAttribute("user", updatedUser);
        }
        session.setAttribute("message", "Profile updated successfully!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}