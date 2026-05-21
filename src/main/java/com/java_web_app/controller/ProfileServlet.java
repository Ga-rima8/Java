package com.java_web_app.controller;

import com.java_web_app.model.UserModel;
import com.java_web_app.service.UserService;
import com.java_web_app.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5 * 1024 * 1024,
        maxRequestSize    = 10 * 1024 * 1024
)
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        
        int userId = resolveUserId(session);
        if (userId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserModel user = userService.getUserById(userId);
        if (user == null) {
            if (session != null) session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        session.setAttribute("userId", userId); 
        session.setAttribute("user",   user);
        req.setAttribute("user",       user);

        try {
            req.setAttribute("profileCompletion",
                    userService.computeProfileCompletion(user));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("profileCompletion", 0);
        }

        
        if (session.getAttribute("message") != null) {
            req.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message");
        }
        if (session.getAttribute("error") != null) {
            req.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }

   
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        int userId = resolveUserId(session);
        if (userId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String firstName = ValidationUtil.clean(req.getParameter("firstName"));
        String lastName  = ValidationUtil.clean(req.getParameter("lastName"));
        String username  = ValidationUtil.clean(req.getParameter("username"));
        String email     = ValidationUtil.clean(req.getParameter("email"));
        String phone     = ValidationUtil.clean(req.getParameter("phone"));
        String dobStr    = ValidationUtil.clean(req.getParameter("dob"));
        String gender    = ValidationUtil.clean(req.getParameter("gender"));
        String password  = req.getParameter("password");


        byte[] imageBytes       = null;
        String imageContentType = null;

        try {
            Part filePart = req.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                imageContentType = filePart.getContentType();
                try (InputStream is = filePart.getInputStream()) {
                    imageBytes = is.readAllBytes();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Image upload failed.");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        
        String error = userService.updateProfile(
                userId, firstName, lastName, username, email,
                phone, dobStr, gender, password, imageBytes, imageContentType);

        if ("USER_NOT_FOUND".equals(error)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (error != null) {
            session.setAttribute("error", error);
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

       
        UserModel updated = userService.getUserById(userId);
        if (updated != null) session.setAttribute("user", updated);

        session.setAttribute("message", "Profile updated successfully!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    
    private int resolveUserId(HttpSession session) {
        if (session == null) return -1;

        
        Object idObj = session.getAttribute("userId");
        if (idObj != null) {
            try { return Integer.parseInt(idObj.toString()); }
            catch (NumberFormatException ignored) {}
        }

        
        Object userObj = session.getAttribute("user");
        if (userObj instanceof UserModel) {
            return ((UserModel) userObj).getUserId();
        }

        return -1; 
    }
}