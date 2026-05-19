package com.hangaura.controller;

import com.hangaura.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Show contact page
        request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            // ───── GET FORM DATA ─────
            String name = ValidationUtil.clean(request.getParameter("name"));
            String email = ValidationUtil.clean(request.getParameter("email"));
            String subject = ValidationUtil.clean(request.getParameter("subject"));
            String message = ValidationUtil.clean(request.getParameter("message"));

            // ───── VALIDATION ─────
            if (ValidationUtil.isNullOrBlank(name)
                    || ValidationUtil.isNullOrBlank(email)
                    || ValidationUtil.isNullOrBlank(message)) {

                request.setAttribute("error", "Name, Email and Message are required.");
                request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                        .forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                        .forward(request, response);
                return;
            }

            // ───── SUCCESS (NO DB YET - SAFE VERSION) ─────
            // If you want DB saving, I can add ContactDAO for you

            request.setAttribute("success", "Message sent successfully!");
            request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("error", "Server error occurred.");
            request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                    .forward(request, response);
        }
    }
}