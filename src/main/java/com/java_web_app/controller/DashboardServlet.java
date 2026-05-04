package com.java_web_app.controller;

import com.java_web_app.dao.AdminDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")  // was /admin/dashboard, sidebar links to /dashboard
public class DashboardServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Integer> counts = adminDAO.getDashboardCounts();
        request.setAttribute("counts", counts);

        List<Map<String, Object>> recentEvents = adminDAO.getAllEvents();
        if (recentEvents.size() > 5) {
            recentEvents = recentEvents.subList(0, 5);
        }
        request.setAttribute("recentEvents", recentEvents);

        request.setAttribute("currentPage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
    }
}