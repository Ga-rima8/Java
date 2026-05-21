package com.java_web_app.model;


public class CategoryModel {

    private int    categoryId;
    private String categoryName;
    private String categoryDesc;
    private int    eventCount;

    public int    getCategoryId()            { return categoryId; }
    public void   setCategoryId(int v)       { this.categoryId = v; }

    public String getCategoryName()          { return categoryName; }
    public void   setCategoryName(String v)  { this.categoryName = v; }

    public String getCategoryDesc()          { return categoryDesc; }
    public void   setCategoryDesc(String v)  { this.categoryDesc = v; }

    public int    getEventCount()            { return eventCount; }
    public void   setEventCount(int v)       { this.eventCount = v; }
}