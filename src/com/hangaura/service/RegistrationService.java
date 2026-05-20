package com.hangaura.service;

import com.hangaura.DAO.EventDAO;
import com.hangaura.Model.EventModel;

import java.time.LocalDate;
import java.util.List;

/**
 * Business logic for the "My Registrations" feature.
 *
 * Sorting, filtering, and upcoming/completed counting all live here —
 * NOT in the JSP's JavaScript and NOT in the servlet.
 */
public class RegistrationService {

    private final EventDAO eventDAO = new EventDAO();

    // ─────────────────────────────────────────────────────────────
    //  QUERIES
    // ─────────────────────────────────────────────────────────────

    public List<EventModel> getRegisteredEvents(int userId) {
        return eventDAO.getRegisteredEvents(userId);
    }

    // ─────────────────────────────────────────────────────────────
    //  FILTERING  (was JS filterTable() in the JSP)
    // ─────────────────────────────────────────────────────────────

    /**
     * Returns the subset of events that match the search query and status filter.
     * Both parameters are optional (null / blank = no filter applied).
     */
    public List<EventModel> filter(List<EventModel> events, String query, String status) {
        if (events == null) return List.of();

        boolean hasQuery  = query  != null && !query.trim().isEmpty();
        boolean hasStatus = status != null && !status.trim().isEmpty();

        if (!hasQuery && !hasStatus) return events;

        String q = hasQuery  ? query.trim().toLowerCase()  : null;
        String s = hasStatus ? status.trim().toLowerCase() : null;

        return events.stream()
                .filter(ev -> {
                    boolean matchQ = true;
                    boolean matchS = true;

                    if (q != null) {
                        String name = ev.getEventName()     != null ? ev.getEventName().toLowerCase()     : "";
                        String loc  = ev.getEventLocation() != null ? ev.getEventLocation().toLowerCase() : "";
                        matchQ = name.contains(q) || loc.contains(q);
                    }

                    if (s != null) {
                        String evStatus = ev.getStatus() != null ? ev.getStatus().toLowerCase() : "confirmed";
                        matchS = evStatus.equals(s);
                    }

                    return matchQ && matchS;
                })
                .collect(java.util.stream.Collectors.toList());
    }

    // ─────────────────────────────────────────────────────────────
    //  SORTING  (was JS sortTable() in the JSP)
    // ─────────────────────────────────────────────────────────────

    /**
     * Sorts the list in-place according to the sort key.
     * Accepted values: "date-asc" (default), "date-desc", "name-asc".
     */
    public List<EventModel> sort(List<EventModel> events, String sortKey) {
        if (events == null || events.isEmpty()) return events;

        java.util.Comparator<EventModel> cmp;

        switch (sortKey == null ? "" : sortKey) {
            case "date-desc":
                cmp = java.util.Comparator.comparing(
                        EventModel::getEventDate,
                        java.util.Comparator.nullsLast(java.util.Comparator.reverseOrder()));
                break;
            case "name-asc":
                cmp = java.util.Comparator.comparing(
                        ev -> ev.getEventName() != null ? ev.getEventName().toLowerCase() : "");
                break;
            default: // "date-asc"
                cmp = java.util.Comparator.comparing(
                        EventModel::getEventDate,
                        java.util.Comparator.nullsLast(java.util.Comparator.naturalOrder()));
        }

        events.sort(cmp);
        return events;
    }

    // ─────────────────────────────────────────────────────────────
    //  COUNTS  (was inline loop in MyRegistrationsServlet)
    // ─────────────────────────────────────────────────────────────

    public int countUpcoming(List<EventModel> events) {
        if (events == null) return 0;
        LocalDate today = LocalDate.now();
        return (int) events.stream()
                .filter(ev -> ev.getEventDate() != null
                        && !ev.getEventDate().toLocalDate().isBefore(today))
                .count();
    }

    public int countCompleted(List<EventModel> events) {
        if (events == null) return 0;
        LocalDate today = LocalDate.now();
        return (int) events.stream()
                .filter(ev -> ev.getEventDate() != null
                        && ev.getEventDate().toLocalDate().isBefore(today))
                .count();
    }
}