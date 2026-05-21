package com.java_web_app.model;

import java.sql.Date;

public class EventModel {

    

    private int    eventId;
    private String eventName;
    private Date   eventDate;
    private String eventLocation;
    private String description;
    private int    categoryId;
    private int    maxCapacity;    

    

    private String category;      
    private int    capacity;       
    private String status;       
    
    

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