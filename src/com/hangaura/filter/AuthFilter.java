package com.hangaura.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Authentication filter.
 * Protects /dashboard, /profile, /getimage from unauthenticated access.
 * Passes /login, /register, /logout, and static resources freely.
 */
@WebFilter(urlPatterns = {"/dashboard", "/profile", "/getimage"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        if (loggedIn) {
            // Refresh remember-me cookie TTL on every authenticated request
            refreshCookie(request, response);
            chain.doFilter(req, res);
        } else {
            // Check remember-me cookie
            String rememberedId = getRememberedUserId(request);
            if (rememberedId != null) {
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("userId", Integer.parseInt(rememberedId));
                newSession.setMaxInactiveInterval(30 * 60); // 30 min
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        }
    }

    private String getRememberedUserId(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        if (cookies == null) return null;
        for (Cookie c : cookies) {
            if ("ha_remember".equals(c.getName())) {
                String val = c.getValue();
                // Basic validation: numeric
                if (val != null && val.matches("\\d+")) return val;
            }
        }
        return null;
    }

    private void refreshCookie(HttpServletRequest req, HttpServletResponse res) {
        Cookie[] cookies = req.getCookies();
        if (cookies == null) return;
        for (Cookie c : cookies) {
            if ("ha_remember".equals(c.getName())) {
                Cookie fresh = new Cookie("ha_remember", c.getValue());
                fresh.setMaxAge(7 * 24 * 60 * 60); // 7 days
                fresh.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                fresh.setHttpOnly(true);
                res.addCookie(fresh);
                break;
            }
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}