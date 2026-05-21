package com.java_web_app.controller;

import com.java_web_app.model.UserModel;
import com.java_web_app.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/removeProfileImage")
public class RemoveProfileImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

       
        int userId = Integer.parseInt(
                session.getAttribute("userId").toString()
        );

      
        UserModel user = userService.getUserById(userId);

        if (user == null) {
            session.invalidate();
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        
        user.setProfileImage(null);

        boolean updated = userService.updateUser(user);

        if (!updated) {

            session.setAttribute(
                    "error",
                    "Failed to remove profile image."
            );

        } else {

            
            UserModel updatedUser = userService.getUserById(userId);

            session.setAttribute("user", updatedUser);

            session.setAttribute(
                    "message",
                    "Profile photo removed successfully!"
            );
        }

        res.sendRedirect(req.getContextPath() + "/profile");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.sendRedirect(req.getContextPath() + "/profile");
    }
}