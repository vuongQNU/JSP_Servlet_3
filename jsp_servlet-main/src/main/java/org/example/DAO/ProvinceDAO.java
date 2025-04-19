package org.example.DAO;

import org.example.model.Province;
import org.example.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProvinceDAO {
    private final DatabaseConnection databaseConnection = new DatabaseConnection();

    public List<Province> getAll() {
        List<Province> provinces = new ArrayList<>();
        String sql = "SELECT * FROM provinces";
        try (Connection conn = databaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Province province = new Province();
                province.setIdProvince(rs.getInt("idProvince"));
                province.setNameProvince(rs.getString("nameProvince"));
                provinces.add(province);
            }
            System.out.println("Số tỉnh/thành lấy được: " + provinces.size()); // Log
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách tỉnh/thành: " + e.getMessage());
            e.printStackTrace();
        }
        return provinces;
    }
 // Thêm phương thức findById
    public Province findById(int id) {
        Province province = null;
        String sql = "SELECT * FROM provinces WHERE idProvince = ?";
        try (Connection conn = databaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    province = new Province();
                    province.setIdProvince(rs.getInt("idProvince"));
                    province.setNameProvince(rs.getString("nameProvince"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thông tin tỉnh/thành: " + e.getMessage());
            e.printStackTrace();
        }
        return province;
    }
}