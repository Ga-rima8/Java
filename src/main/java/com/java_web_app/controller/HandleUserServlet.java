package com.java_web_app.controller;

import com.java_web_app.dao.AdmingettheUserDAO;
import com.java_web_app.model.AdmingetUserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/handleUser"})
public class HandleUserServlet extends HttpServlet {

    private final AdmingettheUserDAO userDAO = new AdmingettheUserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<AdmingetUserModel> users = userDAO.getAllUsers();

        req.setAttribute("users",         users);
        req.setAttribute("totalUsers",    userDAO.getTotalUsers());
        req.setAttribute("pendingUsers",  userDAO.getPendingUsers());
        req.setAttribute("approvedUsers", userDAO.getApprovedUsers());
        req.setAttribute("rejectedUsers", userDAO.getRejectedUsers());
        req.setAttribute("currentPage",   "handleUser");

        req.getRequestDispatcher("/WEB-INF/pages/handleuser.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String userId = req.getParameter("user_id");

        if (userId != null && !userId.isEmpty()) {
            int id = Integer.parseInt(userId);

            switch (action == null ? "" : action) {
                case "approve":
                    userDAO.updateStatus(id, "approved");
                    resp.sendRedirect(req.getContextPath() + "/handleUser?msg=approved");
                    break;
                case "reject":
                    userDAO.updateStatus(id, "rejected");
                    resp.sendRedirect(req.getContextPath() + "/handleUser?msg=rejected");
                    break;
                case "delete":
                    userDAO.deleteUser(id);
                    resp.sendRedirect(req.getContextPath() + "/handleUser?msg=deleted");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/handleUser");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/handleUser");
        }
    }
}