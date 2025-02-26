package com.example;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

public class RegisterServlet extends HttpServlet {

    // Handle POST requests to process the registration form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String dateOfJoining = request.getParameter("date_of_joining");
        String contact = request.getParameter("contact");
        String role = request.getParameter("role");
        String employeeType = request.getParameter("employee_type");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String state = request.getParameter("state");
        String city = request.getParameter("city");

        // Retrieve the hobbies as an array of values
        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbies = hobbiesArray != null ? String.join(", ", hobbiesArray) : "";

        String employeeExitDate = null;
        String employeeStatus = "Active";

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("password_mismatch.jsp");
            return;
        }

        // Encrypt the password using BCrypt
        String encryptedPassword = PasswordUtil.hashPassword(password);

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

            // Generate empid
            String empId = "EMP" + String.format("%04d", System.currentTimeMillis() % 10000);

            // SQL query to insert employee data
            String sql = "INSERT INTO employees(empid, firstname, lastname, email, date_of_joining, contact, role, employee_type, " +
                    "address, gender, password, state, city, hobbies, employee_exit_date, employee_status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            // Set parameters for the SQL query
            ps.setString(1, empId); // empid
            ps.setString(2, firstname);
            ps.setString(3, lastname);
            ps.setString(4, email);
            ps.setString(5, dateOfJoining);
            ps.setString(6, contact);
            ps.setString(7, role);
            ps.setString(8, employeeType);
            ps.setString(9, address);
            ps.setString(10, gender);
            ps.setString(11, encryptedPassword); // Store the encrypted password
            ps.setString(12, state);
            ps.setString(13, city);
            ps.setString(14, hobbies); // Insert hobbies as a comma-separated string
            ps.setString(15, employeeExitDate);
            ps.setString(16, employeeStatus);

            // Execute the query
            int rowsInserted = ps.executeUpdate();

            // Redirect based on success or failure
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("failure.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("failure.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Handle GET requests to return a message or error
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Return an error message or redirect to a specific page
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported for this operation.");
    }

    // Utility method for password hashing
    public static class PasswordUtil {
        // Method to hash password using BCrypt
        public static String hashPassword(String password) {
            String salt = BCrypt.gensalt(12); // Strength factor is 12
            return BCrypt.hashpw(password, salt);
        }

        // Method to verify if the entered password matches the stored hash
        public static boolean verifyPassword(String enteredPassword, String storedHash) {
            return BCrypt.checkpw(enteredPassword, storedHash);
        }
    }
}
