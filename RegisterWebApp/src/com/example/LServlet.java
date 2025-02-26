package com.example;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

public class LServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("username"); // User's email
        String password = request.getParameter("password"); // User's password

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please enter both username and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

            // Query to retrieve employee details based on the email
            String sql = "SELECT empid, password, employee_status, date_of_joining, employee_exit_date, role, firstname, lastname FROM employees WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String empId = rs.getString("empid");
                String storedHash = rs.getString("password");
                String employeeStatus = rs.getString("employee_status");
                String dateOfJoining = rs.getString("date_of_joining");
                String role = rs.getString("role"); // Role of the user (P1 or P2)
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String exitDateSql = rs.getString("employee_exit_date");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");

                // Verify employment dates and status
                if (dateOfJoining != null) {
                    try {
                        LocalDate doj = LocalDate.parse(dateOfJoining, formatter);
                        if (doj.isAfter(LocalDate.now())) {
                            request.setAttribute("errorMessage", "You are not allowed to log in based on your employment status.");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                            return;
                        }
                    } catch (DateTimeParseException e) {
                        e.printStackTrace();
                    }
                }

                if (exitDateSql != null) {
                    try {
                        LocalDate doe = LocalDate.parse(exitDateSql, formatter);
                        if (doe.isBefore(LocalDate.now())) {
                            request.setAttribute("errorMessage", "You are not allowed to log in based on your employment status.");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                            return;
                        }
                    } catch (DateTimeParseException e) {
                        e.printStackTrace();
                    }
                }
                
             // Check if employee is inactive
                if ("Inactive".equalsIgnoreCase(employeeStatus)) {
                    request.setAttribute("errorMessage", "Your account is inactive. Please contact the administrator.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                // Verify the password
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("empId", empId); // Store employee ID in session
                    session.setAttribute("email", email); // Store email in session
                    session.setAttribute("role", role);   // Store role in session
                    session.setAttribute("firstname", firstname);
                    session.setAttribute("lastname", lastname);
                    session.setAttribute("isLoggedIn", true);

                    response.sendRedirect("dashboard.jsp"); // Redirect to the dashboard
                } else {
                    request.setAttribute("errorMessage", "Incorrect password. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "No user found with this email.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login_error.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static class PasswordUtil {
        public static String hashPassword(String password) {
            String salt = BCrypt.gensalt(12);
            return BCrypt.hashpw(password, salt);
        }

        public static boolean verifyPassword(String enteredPassword, String storedHash) {
            return BCrypt.checkpw(enteredPassword, storedHash);
        }
    }
}
