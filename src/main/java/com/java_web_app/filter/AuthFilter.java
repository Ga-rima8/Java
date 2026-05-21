package com.java_web_app.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Protects all /admin/* URLs.
 * If the session does not have "adminName", redirects to /login.
 */
@WebFilter(urlPatterns = "/admin/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        boolean isAdmin = (session != null && session.getAttribute("adminName") != null);

        if (isAdmin) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}