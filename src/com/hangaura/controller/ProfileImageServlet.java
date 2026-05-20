package com.hangaura.controller;

import com.hangaura.DAO.UserDAO;
import com.hangaura.Model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Streams the current user's profile_image BLOB from the `user` table.
 * JSPs reference this as: src="${pageContext.request.contextPath}/profileImage"
 *
 * Magic-byte sniffing determines MIME type — no need to store it separately.
 */
@WebServlet("/profileImage")
public class ProfileImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ── Auth guard ─────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        int userId = (int) session.getAttribute("userId");

        // ── Load image bytes ───────────────────────────────────────────
        byte[] imageBytes = null;
        try {
            UserModel user = userDAO.getUserById(userId);
            if (user != null) {
                imageBytes = user.getProfileImage();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (imageBytes == null || imageBytes.length == 0) {
            // No image stored — 404 so the JSP falls back to the initials avatar
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ── Detect MIME from magic bytes ──────────────────────────────
        String mimeType = detectMimeType(imageBytes);

        // ── Write response ─────────────────────────────────────────────
        res.setContentType(mimeType);
        res.setContentLength(imageBytes.length);
        res.setHeader("Cache-Control", "private, max-age=300"); // 5-min browser cache
        res.getOutputStream().write(imageBytes);
    }

    /**
     * Returns the MIME type by inspecting the first few magic bytes.
     * Defaults to "image/jpeg" for anything unrecognised.
     */
    private String detectMimeType(byte[] b) {
        if (b == null || b.length < 4) return "image/jpeg";

        // PNG  — 89 50 4E 47
        if (b[0] == (byte) 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47)
            return "image/png";

        // GIF  — 47 49 46 38
        if (b[0] == 0x47 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x38)
            return "image/gif";

        // WebP — 52 49 46 46 ... 57 45 42 50
        if (b.length >= 12
                && b[0] == 0x52 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x46
                && b[8] == 0x57 && b[9] == 0x45 && b[10] == 0x42 && b[11] == 0x50)
            return "image/webp";

        // JPEG — FF D8
        if (b[0] == (byte) 0xFF && b[1] == (byte) 0xD8)
            return "image/jpeg";

        return "image/jpeg"; // safe default
    }
}