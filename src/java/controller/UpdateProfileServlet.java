package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date; 
import java.text.SimpleDateFormat; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3308/agritrack";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin11"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        // Prepare a String response for JSON output, INITIALIZED TO A DEFAULT ERROR
        String jsonResponse = "{\"success\":\"false\", \"message\":\"An unexpected server error occurred. Please try again.\"}";

        if (userEmail == null) {
            jsonResponse = "{\"success\":\"false\", \"message\":\"User not logged in.\"}";
            response.getWriter().write(jsonResponse);
            return;
        }

        String fullName = request.getParameter("name");
        String title = request.getParameter("title");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String farmSize = request.getParameter("farmSize");
        String mainCrops = request.getParameter("mainCrops");
        String memberSinceStr = request.getParameter("memberSince");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "UPDATE user_profiles SET " +
                         "full_name = ?, title = ?, phone_number = ?, location = ?, " +
                         "farm_size = ?, main_crops = ?, member_since = ? " +
                         "WHERE email = ?";
            stmt = conn.prepareStatement(sql);

            // Use null if the parameter is empty after trimming, otherwise trim it
            stmt.setString(1, (fullName != null && !fullName.trim().isEmpty()) ? fullName.trim() : null);
            stmt.setString(2, (title != null && !title.trim().isEmpty()) ? title.trim() : null);
            stmt.setString(3, (phone != null && !phone.trim().isEmpty()) ? phone.trim() : null);
            stmt.setString(4, (location != null && !location.trim().isEmpty()) ? location.trim() : null);
            stmt.setString(5, (farmSize != null && !farmSize.trim().isEmpty()) ? farmSize.trim() : null);
            stmt.setString(6, (mainCrops != null && !mainCrops.trim().isEmpty()) ? mainCrops.trim() : null);

            Date memberSinceDate = null;
            if (memberSinceStr != null && !memberSinceStr.trim().isEmpty() && !memberSinceStr.equals("Invalid Date")) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd,yyyy"); // Check this format carefully!
                    java.util.Date utilDate = sdf.parse(memberSinceStr);
                    memberSinceDate = new Date(utilDate.getTime());
                } catch (java.text.ParseException e) {
                    System.err.println("Error parsing member_since date: " + memberSinceStr + " - " + e.getMessage());
                }
            } else if (memberSinceStr != null && memberSinceStr.trim().isEmpty()) {
                 memberSinceDate = null;
            } else {
            }
            stmt.setDate(7, memberSinceDate);
            stmt.setString(8, userEmail);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                String memberSinceUpdatedJson = "";
                if (memberSinceDate != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd,yyyy");
                    memberSinceUpdatedJson = ", \"memberSinceUpdated\":\"" + sdf.format(memberSinceDate) + "\"";
                }
                jsonResponse = "{\"success\":\"true\", \"message\":\"Profile updated successfully!\"" + memberSinceUpdatedJson + "}";
            } else {
                jsonResponse = "{\"success\":\"false\", \"message\":\"Failed to update profile. User profile not found (should not happen if created on first visit).\"}";
            }

        } catch (ClassNotFoundException e) {
            jsonResponse = "{\"success\":\"false\", \"message\":\"Database driver not found: " + e.getMessage() + "\"}";
            System.err.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            jsonResponse = "{\"success\":\"false\", \"message\":\"Database error: " + e.getMessage() + "\"}";
            System.err.println("Database error updating profile: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
            response.getWriter().write(jsonResponse);
        }
    }
}