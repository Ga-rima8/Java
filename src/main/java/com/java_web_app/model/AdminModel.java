package com.java_web_app.model;

import java.math.BigDecimal;
import java.sql.Date;

public class AdminModel {

    // ── Admin fields ─────────────────────────────────────
    private int adminId;
    private String name;
    private String email;
    private String password;

    // ── Event fields ─────────────────────────────────────
    private int eventId;
    private String eventTitle;
    private String eventDescription;
    private Date eventDate;
    private String eventLocation;
    private BigDecimal eventPrice;
    private int hostId;
    private String hostName;
    private int categoryId;
    private String categoryName;
    private String eventImage;
    private boolean active;

    // ════════════════════════════════════════════════════
    //  ADMIN GETTERS & SETTERS
    // ════════════════════════════════════════════════════
    public int getAdminId()                     { return adminId; }
    public void setAdminId(int adminId)         { this.adminId = adminId; }

    public String getName()                     { return name; }
    public void setName(String name)            { this.name = name; }

    public String getEmail()                    { return email; }
    public void setEmail(String email)          { this.email = email; }

    public String getPassword()                 { return password; }
    public void setPassword(String password)    { this.password = password; }

    // ════════════════════════════════════════════════════
    //  EVENT GETTERS & SETTERS
    // ════════════════════════════════════════════════════
    public int getEventId()                             { return eventId; }
    public void setEventId(int eventId)                 { this.eventId = eventId; }

    public String getEventTitle()                       { return eventTitle; }
    public void setEventTitle(String eventTitle)        { this.eventTitle = eventTitle; }

    public String getEventDescription()                 { return eventDescription; }
    public void setEventDescription(String d)           { this.eventDescription = d; }

    public Date getEventDate()                          { return eventDate; }
    public void setEventDate(Date eventDate)            { this.eventDate = eventDate; }

    public String getEventLocation()                    { return eventLocation; }
    public void setEventLocation(String eventLocation)  { this.eventLocation = eventLocation; }

    public BigDecimal getEventPrice()                   { return eventPrice; }
    public void setEventPrice(BigDecimal eventPrice)    { this.eventPrice = eventPrice; }

    public int getHostId()                              { return hostId; }
    public void setHostId(int hostId)                   { this.hostId = hostId; }

    public String getHostName()                         { return hostName; }
    public void setHostName(String hostName)            { this.hostName = hostName; }

    public int getCategoryId()                          { return categoryId; }
    public void setCategoryId(int categoryId)           { this.categoryId = categoryId; }

    public String getCategoryName()                     { return categoryName; }
    public void setCategoryName(String categoryName)    { this.categoryName = categoryName; }

    public String getEventImage()                       { return eventImage; }
    public void setEventImage(String eventImage)        { this.eventImage = eventImage; }

    public boolean isActive()                           { return active; }
    public void setActive(boolean active)               { this.active = active; }
}