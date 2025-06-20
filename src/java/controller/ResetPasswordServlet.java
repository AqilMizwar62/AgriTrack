package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updatePassword(email, password);
            userDAO.clearResetCode(email);
            request.setAttribute("message", "Password reset successful. Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to reset password. " + e.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
        }
    }
}