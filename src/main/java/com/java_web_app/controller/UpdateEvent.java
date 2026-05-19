package com.java_web_app.controller;

import com.java_web_app.dao.Eventdao;
import com.java_web_app.model.EventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;
import java.util.List;

@WebServlet("/updateEvent")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class UpdateEvent extends HttpServlet {

    private final Eventdao eventDAO = new Eventdao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<EventModel> events = eventDAO.getAllEvents();
        req.setAttribute("events", events);
        req.getRequestDispatcher("/WEB-INF/pages/updateevent.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            handleEdit(req, resp);
        } else if ("toggleStatus".equals(action)) {
            handleToggleStatus(req, resp);
        } else {
            resp.sendRedirect("updateEvent");
        }
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        EventModel e = new EventModel();
        e.setEventId(Integer.parseInt(req.getParameter("event_id")));
        e.setTitle(req.getParameter("title"));
        e.setHost(req.getParameter("host"));
        e.setCategory(req.getParameter("category"));
        e.setEventDate(req.getParameter("event_date"));
        e.setLocation(req.getParameter("location"));
        e.setPrice(Double.parseDouble(req.getParameter("price")));
        e.setDescription(req.getParameter("description"));
        e.setImageUrl(req.getParameter("existing_image"));

        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
                new File(uploadDir).mkdirs();
                filePart.write(uploadDir + File.separator + fileName);
                e.setImageUrl("uploads/" + fileName);
            }
        } catch (Exception ex) {
            // no new image uploaded, keep existing
        }

        boolean success = eventDAO.updateEvent(e);
        resp.sendRedirect("updateEvent?msg=" + (success ? "updated" : "error"));
    }

    private void handleToggleStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int eventId   = Integer.parseInt(req.getParameter("event_id"));
        int newStatus = Integer.parseInt(req.getParameter("new_status"));

        boolean success = eventDAO.toggleStatus(eventId, newStatus);
        resp.sendRedirect("updateEvent?msg=" + (success ? "statusUpdated" : "error"));
    }

    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1)
                         .trim().replace("\"", "")
                         .replaceAll("[^a-zA-Z0-9._-]", "_");
            }
        }
        return "file_" + System.currentTimeMillis();
    }
}