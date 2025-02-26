package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class ManagerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String empId = (String) session.getAttribute("empId");

        // Check if empId exists in session and if the user is an active manager
        if (empId != null) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Establish DB connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

                // Query to check if the user is an active manager
                String sql = "SELECT manager_status FROM managers WHERE empid = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, empId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String managerStatus = rs.getString("manager_status");

                    // If the manager is active, show the manager dashboard
                    if ("Active".equalsIgnoreCase(managerStatus)) {
                        request.getRequestDispatcher("managerDashboard.jsp").forward(request, response);
                    } else {
                        // If the manager is inactive, redirect to the login page
                        session.invalidate(); // Invalidate the session
                        response.sendRedirect("login.jsp?error=inactive_manager");
                    }
                } else {
                    // If no manager record is found for the empid, redirect to login page
                    response.sendRedirect("login.jsp?error=no_manager_found");
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
        } else {
            // If empId is not in the session, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
}
