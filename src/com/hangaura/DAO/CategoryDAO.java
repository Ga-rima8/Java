package com.hangaura.DAO;

import com.hangaura.Model.CategoryModel;
import com.hangaura.utils.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CRUD for the `category` table.
 * TABLE NAMES: category, event  (no trailing 's' — matches DB schema)
 * COLUMN: description  (not category_desc)
 */
public class CategoryDAO {

    /** All categories with event count. */
    public List<CategoryModel> getAllCategories() throws SQLException {
        String sql = "SELECT c.category_id, c.category_name, c.description, " +
                     "COUNT(e.event_id) AS event_count " +
                     "FROM category c LEFT JOIN event e ON c.category_id = e.category_id " +
                     "GROUP BY c.category_id, c.category_name, c.description " +
                     "ORDER BY c.category_name";
        List<CategoryModel> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
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

    /** Count of distinct categories. */
    public int countCategories() throws SQLException {
        try (Connection c = DBConfig.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM category")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}