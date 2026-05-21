package com.java_web_app.controller;

import com.java_web_app.model.EventModel;
import com.java_web_app.model.UserModel;
import com.java_web_app.service.DashboardService;
import com.java_web_app.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

      
        Object idObj = session.getAttribute("userId");
        int userId;

        if (idObj instanceof Integer) {
            userId = (Integer) idObj;
        } else {
            userId = Integer.parseInt(idObj.toString());
        }

        try {
            UserModel user = userService.getUserById(userId);

            if (user == null) {
                session.invalidate();
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            session.setAttribute("user", user);
            req.setAttribute("user", user);

            req.setAttribute(
                    "profileCompletion",
                    userService.computeProfileCompletion(user)
            );

            req.setAttribute("totalEvents", dashboardService.getTotalEvents());
            req.setAttribute("totalCategories", dashboardService.getTotalCategories());
            req.setAttribute("upcomingCount", dashboardService.getUpcomingCount());

            List<EventModel> recentEvents = dashboardService.getRecentEvents(6);
            req.setAttribute("recentEvents", recentEvents);

            List<EventModel> registeredEvents = dashboardService.getRegisteredEvents(userId);

            req.setAttribute("registeredEvents", registeredEvents);
            req.setAttribute(
                    "registeredCount",
                    registeredEvents != null ? registeredEvents.size() : 0
            );

            req.setAttribute("categories", dashboardService.getAllCategories());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load dashboard data.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}