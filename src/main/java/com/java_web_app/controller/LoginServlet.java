package com.java_web_app.controller;

import com.java_web_app.dao.AdminDAO;
import com.java_web_app.model.UserModel;
import com.java_web_app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AdminDAO     adminDAO    = new AdminDAO();
    private final UserService  userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null) {
            
            if (session.getAttribute("adminName") != null) {
                res.sendRedirect(req.getContextPath() + "/AdminDashboard");
                return;
            }
           
            if (session.getAttribute("userId") != null) {
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
        }

      
        String registered = req.getParameter("registered");
        if ("true".equals(registered)) {
            req.setAttribute("message", "Account created! Please log in.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            req.setAttribute("error", "Please enter username and password.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        username = username.trim();
        password = password.trim();

      
        String adminName = adminDAO.loginAdmin(username, password);
        if (adminName != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("adminName",  adminName);
            session.setAttribute("adminEmail", username);
            session.setMaxInactiveInterval(60 * 60);
            res.sendRedirect(req.getContextPath() + "/AdminDashboard");
            return;
        }

      
        UserModel user = userService.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",    user.getUserId());   // int
            session.setAttribute("user",      user);               // ✅ full object too
            session.setAttribute("username",  user.getUserName());
            session.setAttribute("firstName", user.getFirstName());
            session.setMaxInactiveInterval(30 * 60);
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        
        req.setAttribute("error", "Invalid username or password.");
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
    }
}