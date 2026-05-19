package com.hangaura.utils;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility for HangAura.
 * Update DB_URL / DB_USER / DB_PASS to match your XAMPP/MariaDB setup.
 */
public class DBConfig {

    private static final String DB_URL  =
        "jdbc:mysql://localhost:3306/hangaura_db" +
        "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";   // XAMPP default: empty

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    private DBConfig() {}
}