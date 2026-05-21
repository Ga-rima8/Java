package com.java_web_app.controller;

import com.java_web_app.dao.adminEventdao;
import com.java_web_app.model.adminEventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/updateEvent")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class UpdateEvent extends HttpServlet {

    private final adminEventdao eventDAO = new adminEventdao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<adminEventModel> events = eventDAO.getAllEvents();
        req.setAttribute("events",       events);
        req.setAttribute("eventsCount",  events.size());
        req.setAttribute("currentPage",  "updateEvent");

        
        String editIdParam = req.getParameter("editId");
        if (editIdParam != null && !editIdParam.trim().isEmpty()) {
            try {
                int editId = Integer.parseInt(editIdParam.trim());
                adminEventModel editEvent = eventDAO.getEventById(editId);
                if (editEvent != null) {
                    req.setAttribute("editEvent", editEvent);
                }
            } catch (NumberFormatException ignored) { }
        }

        req.getRequestDispatcher("/WEB-INF/pages/updateevent.jsp")
           .forward(req, resp);
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

        String title    = req.getParameter("title")       == null ? "" : req.getParameter("title").trim();
        String host     = req.getParameter("host")        == null ? "" : req.getParameter("host").trim();
        String category = req.getParameter("category")    == null ? "" : req.getParameter("category").trim();
        String date     = req.getParameter("event_date")  == null ? "" : req.getParameter("event_date").trim();
        String location = req.getParameter("location")    == null ? "" : req.getParameter("location").trim();
        String price    = req.getParameter("price")       == null ? "" : req.getParameter("price").trim();
        String desc     = req.getParameter("description") == null ? "" : req.getParameter("description").trim();

        List<String> errors = new ArrayList<>();

        if (title.isEmpty())                        errors.add("Title is required.");
        else if (!title.matches("[a-zA-Z0-9 .,!'-]+")) errors.add("Title has invalid characters.");
        else if (title.length() < 3 || title.length() > 100) errors.add("Title must be 3-100 chars.");

        if (host.isEmpty())                  errors.add("Host is required.");
        else if (!host.matches("[a-zA-Z ]+")) errors.add("Host must contain letters only.");

        if (category.isEmpty())                  errors.add("Category is required.");
        else if (!category.matches("[a-zA-Z ]+")) errors.add("Category must contain letters only.");

        if (date.isEmpty()) {
            errors.add("Date is required.");
        } else {
            try { LocalDate.parse(date); }
            catch (Exception ex) { errors.add("Date is not valid."); }
        }

        if (location.isEmpty())                        errors.add("Location is required.");
        else if (!location.matches("[a-zA-Z0-9 .,/-]+")) errors.add("Location has invalid characters.");

        if (price.isEmpty()) {
            errors.add("Price is required.");
        } else {
            try {
                double p = Double.parseDouble(price);
                if (p < 0)       errors.add("Price cannot be negative.");
                else if (p > 1_000_000) errors.add("Price seems too high.");
            } catch (NumberFormatException ex) {
                errors.add("Price must be a valid number.");
            }
        }

        if (desc.isEmpty())             errors.add("Description is required.");
        else if (desc.length() < 10)    errors.add("Description must be at least 10 characters.");

        String eventIdParam = req.getParameter("event_id");
        if (!errors.isEmpty()) {
            String detail = String.join(" | ", errors);
            resp.sendRedirect("updateEvent?msg=error&detail="
                + java.net.URLEncoder.encode(detail, "UTF-8")
                + (eventIdParam != null ? "&editId=" + eventIdParam : ""));
            return;
        }

        adminEventModel e = new adminEventModel();
        e.setEventId(Integer.parseInt(eventIdParam));
        e.setTitle(title);
        e.setHost(host);
        e.setCategory(category);
        e.setEventDate(date);
        e.setLocation(location);
        e.setPrice(Double.parseDouble(price));
        e.setDescription(desc);
        e.setImageUrl(req.getParameter("existing_image"));

        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                String uploadDir = getServletContext().getRealPath("")
                                   + File.separator + "uploads";
                new File(uploadDir).mkdirs();
                filePart.write(uploadDir + File.separator + fileName);
                e.setImageUrl("uploads/" + fileName);
            }
        } catch (Exception ex) {  }

        boolean ok = eventDAO.updateEvent(e);
        resp.sendRedirect("updateEvent?msg=" + (ok ? "updated" : "error"));
    }

    private void handleToggleStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int eventId   = Integer.parseInt(req.getParameter("event_id"));
        int newStatus = Integer.parseInt(req.getParameter("new_status"));
        boolean ok    = eventDAO.toggleStatus(eventId, newStatus);
        resp.sendRedirect("updateEvent?msg=" + (ok ? "statusUpdated" : "error"));
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