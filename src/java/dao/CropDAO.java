/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Nabil Nasri
 */

import model.Crop;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CropDAO {
    
    public List<Crop> getAllCrops() throws SQLException {
        List<Crop> crops = new ArrayList<>();
        String sql = "SELECT * FROM crops";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Crop crop = new Crop();
                crop.setCropId(rs.getInt("crop_id"));
                crop.setCropName(rs.getString("crop_name"));
                crop.setPlantingDate(rs.getDate("planting_date"));
                crop.setStatus(rs.getString("status"));
                crop.setNotes(rs.getString("notes"));
                crop.setImagePath(rs.getString("image_path"));
                crops.add(crop);
            }
        }
        return crops;
    }
    
    public List<Crop> getCropsByUserEmail(String userEmail) throws SQLException {
        List<Crop> crops = new ArrayList<>();
        String sql = "SELECT * FROM crops WHERE user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Crop crop = new Crop();
                    crop.setCropId(rs.getInt("crop_id"));
                    crop.setCropName(rs.getString("crop_name"));
                    crop.setPlantingDate(rs.getDate("planting_date"));
                    crop.setStatus(rs.getString("status"));
                    crop.setNotes(rs.getString("notes"));
                    crop.setImagePath(rs.getString("image_path"));
                    crop.setUserEmail(rs.getString("user_email"));
                    crops.add(crop);
                }
            }
        }
        return crops;
    }
    
    public boolean addCrop(Crop crop) throws SQLException {
        String sql = "INSERT INTO crops (crop_name, planting_date, status, notes, image_path, user_email) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, crop.getCropName());
            stmt.setDate(2, crop.getPlantingDate());
            stmt.setString(3, crop.getStatus());
            stmt.setString(4, crop.getNotes());
            stmt.setString(5, crop.getImagePath());
            stmt.setString(6, crop.getUserEmail());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateCrop(Crop crop) throws SQLException {
        String sql = "UPDATE crops SET crop_name = ?, planting_date = ?, status = ?, notes = ?, image_path = ? WHERE crop_id = ? AND user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, crop.getCropName());
            stmt.setDate(2, crop.getPlantingDate());
            stmt.setString(3, crop.getStatus());
            stmt.setString(4, crop.getNotes());
            stmt.setString(5, crop.getImagePath());
            stmt.setInt(6, crop.getCropId());
            stmt.setString(7, crop.getUserEmail());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteCrop(int cropId, String userEmail) throws SQLException {
        String sql = "DELETE FROM crops WHERE crop_id = ? AND user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cropId);
            stmt.setString(2, userEmail);
            return stmt.executeUpdate() > 0;
        }
    }

    public Crop getCropById(int cropId, String userEmail) throws SQLException {
        String sql = "SELECT * FROM crops WHERE crop_id = ? AND user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cropId);
            stmt.setString(2, userEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Crop crop = new Crop();
                    crop.setCropId(rs.getInt("crop_id"));
                    crop.setCropName(rs.getString("crop_name"));
                    crop.setPlantingDate(rs.getDate("planting_date"));
                    crop.setStatus(rs.getString("status"));
                    crop.setNotes(rs.getString("notes"));
                    crop.setImagePath(rs.getString("image_path"));
                    crop.setUserEmail(rs.getString("user_email"));
                    return crop;
                }
            }
        }
        return null;
    }
}