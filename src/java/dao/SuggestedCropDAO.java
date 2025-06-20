// SuggestedCropDAO.java
package dao;

import model.SuggestedCrop;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SuggestedCropDAO {

    public boolean addSuggestedCrop(SuggestedCrop suggestedCrop) throws SQLException {
        String sql = "INSERT INTO suggested_crops (crop_name, suggested_by_user_id) VALUES (?, ?)"; // Adjust based on if you use suggested_by_user_id
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, suggestedCrop.getCropName());
            if (suggestedCrop.getSuggestedByUserId() > 0) {
                stmt.setInt(2, suggestedCrop.getSuggestedByUserId());
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            return stmt.executeUpdate() > 0;
        }
    }

    public List<SuggestedCrop> getAllSuggestedCrops() throws SQLException {
        List<SuggestedCrop> suggestedCrops = new ArrayList<>();
        String sql = "SELECT * FROM suggested_crops ORDER BY suggestion_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                SuggestedCrop suggestedCrop = new SuggestedCrop();
                suggestedCrop.setSuggestionId(rs.getInt("suggestion_id"));
                suggestedCrop.setCropName(rs.getString("crop_name"));
                suggestedCrop.setSuggestedByUserId(rs.getInt("suggested_by_user_id"));
                suggestedCrop.setSuggestionDate(rs.getTimestamp("suggestion_date"));
                suggestedCrops.add(suggestedCrop);
            }
        }
        return suggestedCrops;
    }
    
    public boolean suggestionExists(String cropName) throws SQLException {
        String sql = "SELECT COUNT(*) FROM suggested_crops WHERE LOWER(crop_name) = LOWER(?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cropName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
