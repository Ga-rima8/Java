package com.hangaura.controller;

import com.hangaura.DAO.CategoryDAO;
import com.hangaura.DAO.EventDAO;
import com.hangaura.DAO.UserDAO;
import com.hangaura.Model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO     userDAO     = new UserDAO();
    private final EventDAO    eventDAO    = new EventDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            // Load fresh user from DB
            UserModel user = userDAO.getUserById(userId);
            if (user == null) {
                session.invalidate();
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            session.setAttribute("user", user);

            // Stats
            req.setAttribute("totalEvents",     eventDAO.countEvents());
            req.setAttribute("totalCategories", categoryDAO.countCategories());
            req.setAttribute("upcomingCount",   eventDAO.countUpcoming());

            // Recent events (latest 6)
            req.setAttribute("recentEvents",    eventDAO.getRecentEvents(6));

            // Registered events for this user
            var registeredEvents = eventDAO.getRegisteredEvents(userId);
            req.setAttribute("registeredEvents", registeredEvents);
            req.setAttribute("registeredCount",  registeredEvents.size());

            // Categories
            req.setAttribute("categories",      categoryDAO.getAllCategories());

            req.setAttribute("user", user);

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