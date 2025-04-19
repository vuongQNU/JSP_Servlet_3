package org.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private final String jdbcURL = "jdbc:mysql://127.0.0.1:3306/jsp_servlet2";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "19092004";

    public Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            System.out.println("Kết nối cơ sở dữ liệu thành công!");
            return conn;
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
            throw e;
        }
    }
}