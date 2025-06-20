package controller;

import dao.UserDAO;
import util.EmailUtil;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Random;
import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.http.*;

public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String code = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = Timestamp.valueOf(LocalDateTime.now().plusMinutes(10));
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.setResetCode(email, code, expiry);
            EmailUtil.sendEmail(email, "Your Reset Code", "Your reset code is: " + code);
            request.setAttribute("email", email);
            request.getRequestDispatcher("verify_code.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to send reset code. " + e.getMessage());
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
        }
    }
}