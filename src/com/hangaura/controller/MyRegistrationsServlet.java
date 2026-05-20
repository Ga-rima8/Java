package com.hangaura.controller;

import com.hangaura.Model.EventModel;
import com.hangaura.Model.UserModel;
import com.hangaura.service.RegistrationService;
import com.hangaura.service.UserService;
import com.hangaura.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Controller only.
 *
 * Fixed:
 *  - Search query, status filter, and sort order are now received as HTTP
 *    request parameters and passed to RegistrationService — the JSP never
 *    filters or sorts data itself.
 *  - upcoming / completed counts computed in RegistrationService, not here.
 *  - No direct DAO access — only service calls.
 *  - Auth guard checks "userId" (consistent with all other servlets).
 */
@WebServlet("/myregistrations")
public class MyRegistrationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService         userService         = new UserService();
    private final RegistrationService registrationService = new RegistrationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ── 1. Auth guard ──────────────────────────────────────────────────
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        try {
            // ── 2. Fresh user ──────────────────────────────────────────────
            UserModel user = userService.getUserById(userId);
            if (user == null) {
                session.invalidate();
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            session.setAttribute("user", user);
            req.setAttribute("user", user);

            // ── 3. Read filter / sort parameters from the request ──────────
            //       (These were previously computed by JS inside the JSP)
            String query   = ValidationUtil.clean(req.getParameter("q"));
            String status  = ValidationUtil.clean(req.getParameter("status"));
            String sortKey = ValidationUtil.clean(req.getParameter("sort"));

            // Default sort = soonest first
            if (ValidationUtil.isNullOrBlank(sortKey)) sortKey = "date-asc";

            // Echo back to JSP so filter controls stay populated on reload
            req.setAttribute("filterQuery",  query);
            req.setAttribute("filterStatus", status);
            req.setAttribute("filterSort",   sortKey);

            // ── 4. Fetch all registrations ─────────────────────────────────
            List<EventModel> allEvents = registrationService.getRegisteredEvents(userId);

            // ── 5. Counts based on full list (before filtering) ────────────
            req.setAttribute("registeredCount", allEvents != null ? allEvents.size() : 0);
            req.setAttribute("upcomingCount",   registrationService.countUpcoming(allEvents));
            req.setAttribute("completedCount",  registrationService.countCompleted(allEvents));

            // ── 6. Apply filter then sort (service responsibility) ─────────
            List<EventModel> filtered = registrationService.filter(allEvents, query, status);
            List<EventModel> sorted   = registrationService.sort(filtered, sortKey);

            req.setAttribute("registeredEvents", sorted);
            req.setAttribute("visibleCount",     sorted != null ? sorted.size() : 0);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load your registrations.");
        }

        req.getRequestDispatcher("/WEB-INF/Pages/myregistrations.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}