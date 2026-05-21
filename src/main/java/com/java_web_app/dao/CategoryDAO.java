package com.java_web_app.dao;

import com.java_web_app.model.CategoryModel;
import com.java_web_app.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CategoryDAO {

   
    public List<CategoryModel> getAllCategories() throws SQLException {
        String sql = "SELECT c.category_id, c.category_name, c.description, " +
                     "COUNT(e.event_id) AS event_count " +
                     "FROM category c LEFT JOIN event e ON c.category_id = e.category_id " +
                     "GROUP BY c.category_id, c.category_name, c.description " +
                     "ORDER BY c.category_name";
        List<CategoryModel> list = new ArrayList<>();
        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryModel cat = new CategoryModel();
                cat.setCategoryId  (rs.getInt   ("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                cat.setCategoryDesc(rs.getString("description"));   // DB column = description
                cat.setEventCount  (rs.getInt   ("event_count"));
                list.add(cat);
            }
        }
        return list;
    }

   
    public int countCategories() throws SQLException {
        try (Connection c = DBconfig.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM category")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}