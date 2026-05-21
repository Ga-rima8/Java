package com.java_web_app.controller;

import com.java_web_app.utils.ValidationUtil;
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

        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            String name = ValidationUtil.clean(request.getParameter("name"));
            String email = ValidationUtil.clean(request.getParameter("email"));
            String subject = ValidationUtil.clean(request.getParameter("subject"));
            String message = ValidationUtil.clean(request.getParameter("message"));

            if (ValidationUtil.isNullOrBlank(name)
                    || ValidationUtil.isNullOrBlank(email)
                    || ValidationUtil.isNullOrBlank(message)) {

                request.setAttribute("error",
                        "Name, Email and Message are required to send your message.");
                request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                        .forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {

                request.setAttribute("error",
                        "Please enter a valid email address.");
                request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                        .forward(request, response);
                return;
            }

         
            request.setAttribute("success",
                    "Your response has been recorded successfully in HangAura. Thank you for contacting us 🌿");

            request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("error",
                    "Something went wrong while submitting your message. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp")
                    .forward(request, response);
        }
    }
}