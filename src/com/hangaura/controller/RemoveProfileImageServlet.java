package com.hangaura.controller;

import com.hangaura.Model.UserModel;
import com.hangaura.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller only.
 *
 * Fixed:
 *  - No direct UserDAO calls — delegates to UserService.removeProfileImage().
 */
@WebServlet("/removeProfileImage")
public class RemoveProfileImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ── Auth guard ─────────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        // ── Delegate to service ────────────────────────────────────────────
        String error = userService.removeProfileImage(userId);

        if (error != null) {
            session.setAttribute("error", error);
        } else {
            // Refresh session so the avatar immediately shows initials
            UserModel updatedUser = userService.getUserById(userId);
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
            }
            session.setAttribute("message", "Profile photo removed.");
        }

        res.sendRedirect(req.getContextPath() + "/profile");
    }

    // Fallback: direct GET hits just redirect safely
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/profile");
    }
}