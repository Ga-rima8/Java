package com.java_web_app.controller;

import com.java_web_app.dao.UserDAO;
import com.java_web_app.model.UserModel;
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

       
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        int userId = (int) session.getAttribute("userId");

       
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
            
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        
        String mimeType = detectMimeType(imageBytes);

        res.setContentType(mimeType);
        res.setContentLength(imageBytes.length);
        res.setHeader("Cache-Control", "private, max-age=300"); 
        res.getOutputStream().write(imageBytes);
    }

   
    private String detectMimeType(byte[] b) {
        if (b == null || b.length < 4) return "image/jpeg";

        
        if (b[0] == (byte) 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47)
            return "image/png";

        
        if (b[0] == 0x47 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x38)
            return "image/gif";

       
        if (b.length >= 12
                && b[0] == 0x52 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x46
                && b[8] == 0x57 && b[9] == 0x45 && b[10] == 0x42 && b[11] == 0x50)
            return "image/webp";

       
        if (b[0] == (byte) 0xFF && b[1] == (byte) 0xD8)
            return "image/jpeg";

        return "image/jpeg"; 
    }
}