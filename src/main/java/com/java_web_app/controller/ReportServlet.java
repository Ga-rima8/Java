package com.java_web_app.controller;

import com.java_web_app.dao.adminEventdao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    private adminEventdao eventDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new adminEventdao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalBookings = eventDAO.getTotalBookings();
        int confirmedBookings = eventDAO.getConfirmedBookings();
        int pendingBookings = eventDAO.getPendingBookings();
        int cancelledBookings = eventDAO.getCancelledBookings();
        double totalRevenue = eventDAO.getTotalRevenue();

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("confirmedBookings", confirmedBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("cancelledBookings", cancelledBookings);
        request.setAttribute("totalRevenue", totalRevenue);

        request.setAttribute("eventStats", eventDAO.getEventStats());

        request.getRequestDispatcher("/WEB-INF/pages/report.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}