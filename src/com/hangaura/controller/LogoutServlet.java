package com.hangaura.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Invalidate session
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Delete remember-me cookie
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("ha_remember".equals(c.getName())) {
                    Cookie kill = new Cookie("ha_remember", "");
                    kill.setMaxAge(0);
                    kill.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                    kill.setHttpOnly(true);
                    res.addCookie(kill);
                    break;
                }
            }
        }

        res.sendRedirect(req.getContextPath() + "/login?logout=true");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}