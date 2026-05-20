package com.hangaura.Model;

import java.sql.Date;

/**
 * Maps to the `event` table in hangaura_db.
 *
 * DB columns (actual):
 *   event_id, event_name, event_date, event_location,
 *   description, category_id, max_capacity, created_at
 *
 * Transient/computed fields (populated by DAO queries):
 *   category     — joined from `category` table (category_name)
 *   capacity     — COUNT of registrations from `registration` table
 *   status       — derived ("confirmed" for all registered events)
 *
 * NOTE: host, price, event_time do NOT exist as DB columns.
 *       The JSPs show "HangAura" statically for host.
 */
public class EventModel {

    // ── DB-mapped fields ───────────────────────────────────────────────────

    private int    eventId;
    private String eventName;
    private Date   eventDate;
    private String eventLocation;
    private String description;
    private int    categoryId;
    private int    maxCapacity;    // DB column: max_capacity

    // ── Computed / joined fields (not DB columns) ──────────────────────────

    private String category;       // from LEFT JOIN category.category_name
    private int    capacity;       // COUNT(*) from registration (current bookings)
    private String status;         // e.g. "confirmed" — set by servlet/DAO layer

    // ── Getters & Setters ──────────────────────────────────────────────────

    public int    getEventId()               { return eventId; }
    public void   setEventId(int v)          { this.eventId = v; }

    public String getEventName()             { return eventName; }
    public void   setEventName(String v)     { this.eventName = v; }

    public Date   getEventDate()             { return eventDate; }
    public void   setEventDate(Date v)       { this.eventDate = v; }

    public String getEventLocation()         { return eventLocation; }
    public void   setEventLocation(String v) { this.eventLocation = v; }

    public String getDescription()           { return description; }
    public void   setDescription(String v)   { this.description = v; }

    public int    getCategoryId()            { return categoryId; }
    public void   setCategoryId(int v)       { this.categoryId = v; }

    public int    getMaxCapacity()           { return maxCapacity; }
    public void   setMaxCapacity(int v)      { this.maxCapacity = v; }

    public String getCategory()              { return category; }
    public void   setCategory(String v)      { this.category = v; }

    public int    getCapacity()              { return capacity; }
    public void   setCapacity(int v)         { this.capacity = v; }

    public String getStatus()                { return status; }
    public void   setStatus(String v)        { this.status = v; }
}