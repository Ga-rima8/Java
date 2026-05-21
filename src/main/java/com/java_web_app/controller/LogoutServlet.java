package com.java_web_app.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

       
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        
        Cookie kill = new Cookie("ha_remember", "");
        kill.setMaxAge(0);
        kill.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
        kill.setHttpOnly(true);
        res.addCookie(kill);

        res.sendRedirect(req.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}