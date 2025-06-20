package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.HarvestPlan;

public class HarvestDAO {
    public boolean addHarvestPlan(HarvestPlan plan) throws SQLException {
        String sql = "INSERT INTO harvest_plans (crop_id, harvest_date, season_type) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, plan.getCropId());
            stmt.setDate(2, plan.getHarvestDate());
            stmt.setString(3, plan.getSeasonType());
            return stmt.executeUpdate() > 0;
        }
    }

    public HarvestPlan getHarvestPlanById(int planId) throws SQLException {
        HarvestPlan plan = null;
        String sql = "SELECT hp.*, c.crop_name, c.planting_date " +
                     "FROM harvest_plans hp JOIN crops c ON hp.crop_id = c.crop_id " +
                     "WHERE hp.plan_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    plan = new HarvestPlan();
                    plan.setPlanId(rs.getInt("plan_id"));
                    plan.setCropId(rs.getInt("crop_id"));
                    plan.setCropName(rs.getString("crop_name"));
                    plan.setPlantingDate(rs.getDate("planting_date"));
                    plan.setHarvestDate(rs.getDate("harvest_date"));
                    plan.setSeasonType(rs.getString("season_type"));
                }
            }
        }
        return plan;
    }

    public boolean updateHarvestPlan(HarvestPlan plan) throws SQLException {
        String sql = "UPDATE harvest_plans SET harvest_date = ?, season_type = ? WHERE plan_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, plan.getHarvestDate());
            stmt.setString(2, plan.getSeasonType());
            stmt.setInt(3, plan.getPlanId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteHarvestPlan(int planId) throws SQLException {
        String sql = "DELETE FROM harvest_plans WHERE plan_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planId);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<HarvestPlan> getAllHarvestPlans() throws SQLException {
        List<HarvestPlan> plans = new ArrayList<>();
        String sql = "SELECT hp.*, c.crop_name, c.planting_date " +
                     "FROM harvest_plans hp JOIN crops c ON hp.crop_id = c.crop_id ORDER BY hp.harvest_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                HarvestPlan plan = new HarvestPlan();
                plan.setPlanId(rs.getInt("plan_id"));
                plan.setCropId(rs.getInt("crop_id"));
                plan.setCropName(rs.getString("crop_name"));
                plan.setPlantingDate(rs.getDate("planting_date"));
                plan.setHarvestDate(rs.getDate("harvest_date"));
                plan.setSeasonType(rs.getString("season_type"));
                plans.add(plan);
            }
        }
        return plans;
    }
}