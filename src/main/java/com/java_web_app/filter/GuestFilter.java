package com.java_web_app.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.java_web_app.utils.SessionUtil;

/**
 * Redirects authenticated users away from landing/auth pages to the dashboard.
 */
@WebFilter(urlPatterns = {"/login", "/register", "/home", ""})
public class GuestFilter extends HttpFilter {
    
    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
    	// Cast the generic request/response to HTTP-specific versions
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		// Logic: Check if the session exists and contains your login identifier
		// Change "user" to whatever attribute name you set in your LoginServlet
		boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

        if (isLoggedIn) {
            // User is already logged in, redirect them to the dashboard
            // We use getContextPath() to ensure the URL is absolute to the app root
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
        } else {
            // User is a guest, let them proceed to login/register/home
            chain.doFilter(request, response);
        }
    }
}