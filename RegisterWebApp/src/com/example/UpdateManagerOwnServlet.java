package com.example;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class UpdateManagerOwnServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String empid = (String) session.getAttribute("empid");
        String targetEmpId = request.getParameter("targetEmpId");
        String[] selectedHobbies = request.getParameterValues("hobbies");
        String hobbies = (selectedHobbies != null) ? String.join(", ", selectedHobbies) : "";

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root")) {
            
                String contact = request.getParameter("contact");
                String address = request.getParameter("address");
                String state = request.getParameter("state");
                String city = request.getParameter("city");
                //String hobbies = request.getParameter("hobbies");

                String updateQuery = "UPDATE employees SET contact = ?, address = ?, state = ?, city = ?, hobbies = ? WHERE email = ?";
                String targetEmail = (String) session.getAttribute("email");

                try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                    ps.setString(1, contact);
                    ps.setString(2, address);
                    ps.setString(3, state);
                    ps.setString(4, city);
                    ps.setString(5, hobbies);
                    ps.setString(6, targetEmail);
                    ps.executeUpdate();
                }  

            request.setAttribute("successMessage", "Details updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating details.");
        }

        request.getRequestDispatcher("UpdateManagerOwn.jsp").forward(request, response);
    }
}