/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Nabil Nasri
 */

import java.sql.*;
import java.util.*;
import model.Equipment;

public class EquipmentDAO {
    
    public List<Equipment> getAllEquipment() throws SQLException {
        List<Equipment> equipmentList = new ArrayList<>();
        String sql = "SELECT * FROM equipment";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Equipment equip = new Equipment();
                equip.setId(rs.getInt("equipment_id"));
                equip.setName(rs.getString("equipment_name"));
                equip.setConditionStatus(rs.getString("condition_status"));
                equip.setLastMaintenance(rs.getDate("last_maintenance"));
                equip.setNextMaintenance(rs.getDate("next_maintenance"));
                equip.setHoursUsed(rs.getInt("hours_used"));
                equip.setEquipmentType(rs.getString("equipment_type"));
                equipmentList.add(equip);
            }
        }
        return equipmentList;
    }

    public boolean addEquipment(Equipment equipment) throws SQLException {
        String sql = "INSERT INTO equipment (equipment_name, condition_status, last_maintenance, next_maintenance, hours_used, equipment_type, user_email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, equipment.getName());
            stmt.setString(2, equipment.getConditionStatus());
            stmt.setDate(3, equipment.getLastMaintenance());
            stmt.setDate(4, equipment.getNextMaintenance());
            stmt.setInt(5, equipment.getHoursUsed());
            stmt.setString(6, equipment.getEquipmentType());
            stmt.setString(7, equipment.getUserEmail());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateEquipment(Equipment equipment) throws SQLException {
        String sql = "UPDATE equipment SET equipment_name = ?, condition_status = ?, last_maintenance = ?, next_maintenance = ?, hours_used = ?, equipment_type = ? WHERE equipment_id = ? AND user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, equipment.getName());
            stmt.setString(2, equipment.getConditionStatus());
            stmt.setDate(3, equipment.getLastMaintenance());
            stmt.setDate(4, equipment.getNextMaintenance());
            stmt.setInt(5, equipment.getHoursUsed());
            stmt.setString(6, equipment.getEquipmentType());
            stmt.setInt(7, equipment.getId());
            stmt.setString(8, equipment.getUserEmail());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteEquipment(int id, String userEmail) throws SQLException {
        String sql = "DELETE FROM equipment WHERE equipment_id = ? AND user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setString(2, userEmail);
            return stmt.executeUpdate() > 0;
        }
    }

    public Map<String, Integer> getEquipmentHealthStats() throws SQLException {
        Map<String, Integer> stats = new LinkedHashMap<>();
        String sql = "SELECT condition_status, COUNT(*) as count FROM equipment GROUP BY condition_status";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                stats.put(rs.getString("condition_status"), rs.getInt("count"));
            }
        }
        return stats;
    }

    public List<Equipment> getUpcomingMaintenance() throws SQLException {
        List<Equipment> equipmentList = new ArrayList<>();
        String sql = "SELECT * FROM equipment WHERE next_maintenance BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Equipment equip = new Equipment();
                equip.setId(rs.getInt("equipment_id"));
                equip.setName(rs.getString("equipment_name"));
                equip.setNextMaintenance(rs.getDate("next_maintenance"));
                equipmentList.add(equip);
            }
        }
        return equipmentList;
    }

    public List<Equipment> getEquipmentByUserEmail(String userEmail) throws SQLException {
        List<Equipment> equipmentList = new ArrayList<>();
        String sql = "SELECT * FROM equipment WHERE user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Equipment equip = new Equipment();
                    equip.setId(rs.getInt("equipment_id"));
                    equip.setName(rs.getString("equipment_name"));
                    equip.setConditionStatus(rs.getString("condition_status"));
                    equip.setLastMaintenance(rs.getDate("last_maintenance"));
                    equip.setNextMaintenance(rs.getDate("next_maintenance"));
                    equip.setHoursUsed(rs.getInt("hours_used"));
                    equip.setEquipmentType(rs.getString("equipment_type"));
                    equip.setUserEmail(rs.getString("user_email"));
                    equipmentList.add(equip);
                }
            }
        }
        return equipmentList;
    }
}