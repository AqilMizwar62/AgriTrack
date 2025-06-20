package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3308/agritrack", "root", "admin11"
            );

            // First check if user exists
            String checkSql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // User exists - show popup and stay on signup page
                out.println("<script type=\"text/javascript\">");
                out.println("alert('User with this email already exists!');");
                out.println("window.location='Signup.jsp';"); // Redirect back to signup page
                out.println("</script>");
                return;
            }

            // If user doesn't exist, proceed with registration
            String insertSql = "INSERT INTO users (email, password) VALUES (?, ?)";
            PreparedStatement insertPs = conn.prepareStatement(insertSql);
            insertPs.setString(1, email);
            insertPs.setString(2, password); // Storing plain text password (not recommended)
            
            int result = insertPs.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login.jsp?signup=success");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registration failed. Please try again.');");
                out.println("window.location='signup.jsp';");
                out.println("</script>");
            }

            // Close resources
            insertPs.close();
            checkPs.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('An error occurred. Please try again.');");
            out.println("window.location='signup.jsp';");
            out.println("</script>");
        } finally {
            out.close();
        }
    }
}