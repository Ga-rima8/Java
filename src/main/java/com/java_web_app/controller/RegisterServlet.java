package com.java_web_app.controller;

import com.java_web_app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        
        String firstName = req.getParameter("first_name");
        String lastName  = req.getParameter("last_name");
        String username  = req.getParameter("username");
        String email     = req.getParameter("email");
        String number    = req.getParameter("number");
        String gender    = req.getParameter("gender");
        String dob       = req.getParameter("dob");
        String password  = req.getParameter("password");
        String confirm   = req.getParameter("confirmPassword");

        
        if (password == null || password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            repopulate(req, firstName, lastName, username, email, number, gender, dob);
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            repopulate(req, firstName, lastName, username, email, number, gender, dob);
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

       
        int programId = 1;
        try {
            String prog = req.getParameter("program");
            if (prog != null && !prog.isEmpty()) programId = Integer.parseInt(prog);
        } catch (NumberFormatException ignored) {}

      
        String error = userService.register(
                firstName, lastName, username, email,
                number, gender, dob, password, programId);

        if (error != null) {
            req.setAttribute("error", error);
            repopulate(req, firstName, lastName, username, email, number, gender, dob);
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        res.sendRedirect(req.getContextPath() + "/login?registered=true");
    }

   
    private void repopulate(HttpServletRequest req,
                            String firstName, String lastName, String username,
                            String email, String number, String gender, String dob) {
        req.setAttribute("firstName", firstName);
        req.setAttribute("lastName",  lastName);
        req.setAttribute("username",  username);
        req.setAttribute("email",     email);
        req.setAttribute("number",    number);
        req.setAttribute("gender",    gender);
        req.setAttribute("dob",       dob);
    }
}