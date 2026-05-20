package com.hangaura.controller;

import com.hangaura.Model.EventModel;
import com.hangaura.Model.UserModel;
import com.hangaura.service.DashboardService;
import com.hangaura.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Controller only.
 *
 * Fixed:
 *  - No more direct EventDAO / CategoryDAO / UserDAO calls in the servlet.
 *  - All data-fetching delegated to DashboardService and UserService.
 *  - Profile completion percentage computed by UserService.computeProfileCompletion()
 *    and passed as a plain integer — JSP JavaScript no longer computes it.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService      userService      = new UserService();
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ── 1. Auth guard ──────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        try {
            // ── 2. Fresh user (service handles DAO) ───────────────────────
            UserModel user = userService.getUserById(userId);
            if (user == null) {
                session.invalidate();
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            session.setAttribute("user", user);
            req.setAttribute("user", user);

            // ── 3. Profile completion (computed in service, not in JSP) ───
            req.setAttribute("profileCompletion",
                    userService.computeProfileCompletion(user));

            // ── 4. Aggregate stats (all via service) ──────────────────────
            req.setAttribute("totalEvents",     dashboardService.getTotalEvents());
            req.setAttribute("totalCategories", dashboardService.getTotalCategories());
            req.setAttribute("upcomingCount",   dashboardService.getUpcomingCount());

            // ── 5. Recent events (latest 6) ───────────────────────────────
            req.setAttribute("recentEvents",    dashboardService.getRecentEvents(6));

            // ── 6. Registered events for this user ────────────────────────
            List<EventModel> registeredEvents = dashboardService.getRegisteredEvents(userId);
            req.setAttribute("registeredEvents", registeredEvents);
            req.setAttribute("registeredCount",
                    registeredEvents != null ? registeredEvents.size() : 0);

            // ── 7. Categories ─────────────────────────────────────────────
            req.setAttribute("categories",      dashboardService.getAllCategories());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load dashboard data.");
        }

        req.getRequestDispatcher("/WEB-INF/Pages/dashboard.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}