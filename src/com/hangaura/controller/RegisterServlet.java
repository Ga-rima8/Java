package com.hangaura.controller;

import com.hangaura.service.UserService;
import com.hangaura.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Controller only — receives HTTP input, calls UserService, redirects/forwards.
 *
 * Fixed:
 *  - All validation removed from servlet and moved into UserService.register().
 *  - All DAO calls removed from servlet (no more userDAO.usernameExists() etc.).
 *  - Duplicate-check logic, password hashing, and model construction are in
 *    UserService, not here.
 *  - Auth guard now checks "userId" (consistent with login servlet), not "user".
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    // ── GET: show registration page ────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // If already logged in, bounce to dashboard
        if (session != null && session.getAttribute("userId") != null) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
    }

    // ── POST: process registration ─────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // ── Extract raw inputs (controller responsibility) ─────────────────
        String firstName    = ValidationUtil.clean(req.getParameter("first_name"));
        String lastName     = ValidationUtil.clean(req.getParameter("last_name"));
        String username     = ValidationUtil.clean(req.getParameter("username"));
        String email        = ValidationUtil.clean(req.getParameter("email"));
        String number       = ValidationUtil.clean(req.getParameter("number"));
        String gender       = ValidationUtil.clean(req.getParameter("gender"));
        String dobStr       = ValidationUtil.clean(req.getParameter("dob"));
        String password     = req.getParameter("password");   // intentionally not cleaned
        String programIdStr = req.getParameter("program_id");

        // ── Parse programId (controller responsibility: HTTP param → Java type) ──
        int programId = 0;
        if (!ValidationUtil.isNullOrBlank(programIdStr)) {
            try {
                programId = Integer.parseInt(programIdStr.trim());
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid Program ID — must be a number.");
                req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
                return;
            }
        }

        // ── Delegate ALL validation + persistence to the service layer ─────────
        String error = userService.register(
                firstName, lastName, username,
                email, number, gender,
                dobStr, password, programId);

        if (error != null) {
            // Preserve form inputs so the user doesn't have to retype everything
            req.setAttribute("error",     error);
            req.setAttribute("firstName", firstName);
            req.setAttribute("lastName",  lastName);
            req.setAttribute("username",  username);
            req.setAttribute("email",     email);
            req.setAttribute("number",    number);
            req.setAttribute("gender",    gender);
            req.setAttribute("dob",       dobStr);
            req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
            return;
        }

        // ── Success ────────────────────────────────────────────────────────────
        res.sendRedirect(req.getContextPath() + "/login?registered=true");
    }
}