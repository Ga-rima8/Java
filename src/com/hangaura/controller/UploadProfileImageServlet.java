package com.hangaura.controller;

import com.hangaura.Model.UserModel;
import com.hangaura.service.UserService;

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

/**
 * Controller only.
 *
 * Fixed:
 *  - MIME-type validation moved to UserService.updateProfileImage().
 *  - No direct DAO calls — only service calls.
 */
@WebServlet("/uploadProfileImage")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize       = 5 * 1024 * 1024,  // 5 MB per file
    maxRequestSize    = 6 * 1024 * 1024   // 6 MB total
)
public class UploadProfileImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ── 1. Auth guard ──────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        // ── 2. Read uploaded file (I/O is controller responsibility) ───────
        Part filePart = req.getPart("profileImage");
        if (filePart == null || filePart.getSize() == 0) {
            session.setAttribute("error", "No image file was received.");
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        String contentType = filePart.getContentType();
        byte[] imageBytes;

        try (InputStream is = filePart.getInputStream()) {
            imageBytes = is.readAllBytes();
        } catch (IOException e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to read the uploaded file.");
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // ── 3. Delegate validation + persistence to service ────────────────
        String error = userService.updateProfileImage(userId, imageBytes, contentType);

        if (error != null) {
            session.setAttribute("error", error);
            res.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // ── 4. Refresh session ─────────────────────────────────────────────
        UserModel updatedUser = userService.getUserById(userId);
        if (updatedUser != null) {
            session.setAttribute("user", updatedUser);
        }
        session.setAttribute("message", "Profile photo updated successfully!");
        res.sendRedirect(req.getContextPath() + "/profile");
    }
}