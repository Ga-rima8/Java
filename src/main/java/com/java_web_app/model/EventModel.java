package com.java_web_app.model;

public class EventModel {

    private int     eventId;
    private String  title;
    private String  host;
    private String  category;
    private String  eventDate;
    private String  location;
    private double  price;
    private String  imageUrl;
    private String  description;
    private boolean active;

    public EventModel() {}

    public int getEventId()                     { return eventId; }
    public void setEventId(int eventId)         { this.eventId = eventId; }

    public String getTitle()                    { return title; }
    public void setTitle(String title)          { this.title = title; }

    public String getHost()                     { return host; }
    public void setHost(String host)            { this.host = host; }

    public String getCategory()                 { return category; }
    public void setCategory(String category)    { this.category = category; }

    public String getEventDate()                { return eventDate; }
    public void setEventDate(String eventDate)  { this.eventDate = eventDate; }

    public String getLocation()                 { return location; }
    public void setLocation(String location)    { this.location = location; }

    public double getPrice()                    { return price; }
    public void setPrice(double price)          { this.price = price; }

    public String getImageUrl()                 { return imageUrl; }
    public void setImageUrl(String imageUrl)    { this.imageUrl = imageUrl; }

    public String getDescription()              { return description; }
    public void setDescription(String desc)     { this.description = desc; }

    public boolean isActive()                   { return active; }
    public void setActive(boolean active)       { this.active = active; }
}