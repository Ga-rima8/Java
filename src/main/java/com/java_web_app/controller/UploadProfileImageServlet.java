package com.java_web_app.controller;

import com.java_web_app.model.UserModel;
import com.java_web_app.service.UserService;

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

@WebServlet("/uploadProfileImage")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class UploadProfileImageServlet extends HttpServlet {

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

        int userId = Integer.parseInt(session.getAttribute("userId").toString());

        
        Part filePart = req.getPart("profileImage");

        if (filePart == null || filePart.getSize() == 0) {
            session.setAttribute("error", "No image selected.");
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        String contentType = filePart.getContentType();
        byte[] imageBytes;

        try (InputStream is = filePart.getInputStream()) {
            imageBytes = is.readAllBytes();
        }

       
        if (contentType == null ||
                !(contentType.equals("image/png")
                        || contentType.equals("image/jpeg")
                        || contentType.equals("image/jpg"))) {

            session.setAttribute("error", "Only JPG, JPEG, PNG allowed.");
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        
        UserModel user = userService.getUserById(userId);

        if (user == null) {
            session.invalidate();
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        
        user.setProfileImage(imageBytes);


        boolean updated = userService.updateUser(user);

        if (!updated) {
            session.setAttribute("error", "Failed to update profile image.");
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        
        UserModel updatedUser = userService.getUserById(userId);
        session.setAttribute("user", updatedUser);

        session.setAttribute("message", "Profile photo updated successfully!");
        res.sendRedirect(req.getContextPath() + "/profile");
    }
}