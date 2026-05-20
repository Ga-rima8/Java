package com.hangaura.service;

import com.hangaura.DAO.CategoryDAO;
import com.hangaura.DAO.EventDAO;
import com.hangaura.Model.CategoryModel;
import com.hangaura.Model.EventModel;

import java.util.List;

/**
 * Aggregates data needed by the Dashboard.
 * DashboardServlet calls only this class — never any DAO directly.
 */
public class DashboardService {

    private final EventDAO    eventDAO    = new EventDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    public int getTotalEvents()      { return eventDAO.countEvents();       }
    public int getTotalCategories()  { return categoryDAO.countCategories(); }
    public int getUpcomingCount()    { return eventDAO.countUpcoming();      }

    public List<EventModel>    getRecentEvents(int limit)       { return eventDAO.getRecentEvents(limit);       }
    public List<EventModel>    getRegisteredEvents(int userId)  { return eventDAO.getRegisteredEvents(userId);  }
    public List<CategoryModel> getAllCategories()               { return categoryDAO.getAllCategories();         }
}