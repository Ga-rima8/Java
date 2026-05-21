package com.java_web_app.service;

import com.java_web_app.model.CategoryModel;
import com.java_web_app.model.EventModel;

import java.util.ArrayList;
import java.util.List;


public class DashboardService {

    public int getTotalEvents() {
        return 0; 
    }

    public int getTotalCategories() {
        return 0; 
    }

    public int getUpcomingCount() {
        return 0; 
    }

    public List<EventModel> getRecentEvents(int limit) {
        return new ArrayList<>(); 
    }

    public List<EventModel> getRegisteredEvents(int userId) {
        return new ArrayList<>();
    }

    public List<CategoryModel> getAllCategories() {
        return new ArrayList<>();
    }
}