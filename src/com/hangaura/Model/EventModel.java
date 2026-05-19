package com.hangaura.Model;

import java.sql.Date;

/** Maps to the `events` table. */
public class EventModel {

    private int    eventId;
    private String eventName;
    private Date   eventDate;
    private String eventLocation;
    private String description;
    private int    categoryId;
    private String category;     // joined from category table

    public int    getEventId()              { return eventId; }
    public void   setEventId(int v)         { this.eventId = v; }

    public String getEventName()            { return eventName; }
    public void   setEventName(String v)    { this.eventName = v; }

    public Date   getEventDate()            { return eventDate; }
    public void   setEventDate(Date v)      { this.eventDate = v; }

    public String getEventLocation()           { return eventLocation; }
    public void   setEventLocation(String v)   { this.eventLocation = v; }

    public String getDescription()          { return description; }
    public void   setDescription(String v)  { this.description = v; }

    public int    getCategoryId()           { return categoryId; }
    public void   setCategoryId(int v)      { this.categoryId = v; }

    public String getCategory()             { return category; }
    public void   setCategory(String v)     { this.category = v; }
}