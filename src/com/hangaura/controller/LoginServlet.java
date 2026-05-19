package com.hangaura.controller;

import com.hangaura.DAO.UserDAO;
import com.hangaura.Model.UserModel;
import com.hangaura.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Handles:
 * GET  /login  -> Show login page
 * POST /login  -> Authenticate user
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    // ─────────────────────────────────────────────────────────
    // GET : Show Login Page
    // ─────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("userId") != null) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(req, res);
    }

    // ─────────────────────────────────────────────────────────
    // POST : Login Authentication
    // ─────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        // ── Basic validation ────────────────────────────────
        if (ValidationUtil.isBlank(username) || ValidationUtil.isBlank(password)) {
            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(req, res);
            return;
        }

        try {
            UserModel user = userDAO.login(username.trim(), password);

            // ── Invalid credentials ─────────────────────────
            if (user == null) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(req, res);
                return;
            }

            // ── Create session ──────────────────────────────
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // ── Remember-me cookie ──────────────────────────
            if ("on".equals(remember) || "true".equals(remember)) {
                Cookie cookie = new Cookie("ha_remember", String.valueOf(user.getUserId()));
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                cookie.setHttpOnly(true);
                cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                res.addCookie(cookie);
            }

            res.sendRedirect(req.getContextPath() + "/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "A server error occurred. Please try again.");
            req.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(req, res);
        }
    }
}