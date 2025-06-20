package controller;

import dao.UserDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import javax.servlet.*;
import javax.servlet.http.*;

public class VerifyCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        UserDAO userDAO = new UserDAO();
        try {
            String realCode = userDAO.getResetCode(email);
            Timestamp expiry = userDAO.getResetCodeExpiry(email);
            if (realCode != null && realCode.equals(code) && expiry != null && expiry.after(Timestamp.valueOf(LocalDateTime.now()))) {
                request.setAttribute("email", email);
                request.getRequestDispatcher("reset_password.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid or expired code.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("verify_code.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Verification failed. " + e.getMessage());
            request.getRequestDispatcher("verify_code.jsp").forward(request, response);
        }
    }
}