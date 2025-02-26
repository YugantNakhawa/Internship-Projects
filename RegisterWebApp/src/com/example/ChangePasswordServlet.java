package com.example;

import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from the request
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Retrieve email from session
        String email = (String) request.getSession().getAttribute("email");

        if (email == null) {
            request.setAttribute("message", "User not logged in.");
            forwardToPage(request, response, "ChangePassword.jsp");
            return;
        }

        if (currentPassword == null || newPassword == null || confirmPassword == null || 
            currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("message", "Please fill out all fields.");
            forwardToPage(request, response, "ChangePassword.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "New password and confirm password do not match.");
            forwardToPage(request, response, "ChangePassword.jsp");
            return;
        }

        // Database connection and password update
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Retrieve the current hashed password
            String sql = "SELECT password FROM employees WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String storedPassword = rs.getString("password");

                        // Verify the current password
                        if (PasswordUtil.verifyPassword(currentPassword, storedPassword)) {
                            // Hash the new password
                            String newEncryptedPassword = PasswordUtil.hashPassword(newPassword);

                            // Update the password in the database
                            String updateSql = "UPDATE employees SET password = ? WHERE email = ?";
                            try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                                updatePs.setString(1, newEncryptedPassword);
                                updatePs.setString(2, email);
                                int rowsUpdated = updatePs.executeUpdate();

                                if (rowsUpdated > 0) {
                                    request.setAttribute("message", "Your password has been changed successfully.");
                                } else {
                                    request.setAttribute("message", "Error updating password.");
                                }
                                forwardToPage(request, response, "ChangePassword.jsp");
                            }
                        } else {
                            request.setAttribute("message", "Current password is incorrect.");
                            forwardToPage(request, response, "ChangePassword.jsp");
                        }
                    } else {
                        request.setAttribute("message", "User not found.");
                        forwardToPage(request, response, "ChangePassword.jsp");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your request.");
            forwardToPage(request, response, "ChangePassword.jsp");
        }
    }

    private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    public static class PasswordUtil {
        public static String hashPassword(String password) {
            return BCrypt.hashpw(password, BCrypt.gensalt(12));
        }

        public static boolean verifyPassword(String enteredPassword, String storedHash) {
            return BCrypt.checkpw(enteredPassword, storedHash);
        }
    }
}
