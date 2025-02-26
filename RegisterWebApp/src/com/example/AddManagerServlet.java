package com.example;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddManagerServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    String managerId = (String) session.getAttribute("empId");
	    String[] developers = request.getParameterValues("developers");  // Array of selected developers
	    String startDate = request.getParameter("startDate");

	    if (managerId == null || developers == null || startDate == null) {
	        response.sendRedirect("error.jsp");
	        return;
	    }

	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

	        // Loop through each developer to check if a record already exists
	        String checkQuery = "SELECT COUNT(*) FROM emp_manager_map WHERE empid = ? AND managerid = ? AND start_date = ?";
	        String updateQuery = "UPDATE emp_manager_map SET status = 'Active', updatedate = NOW() WHERE empid = ? AND managerid = ? AND start_date = ?";
	        String insertQuery = "INSERT INTO emp_manager_map (managerid, empid, status, start_date) VALUES (?, ?, 'Active', ?)";

	        for (String developer : developers) {
	            // First, check if the record exists for this developer and manager with the same start date
	            ps = conn.prepareStatement(checkQuery);
	            ps.setString(1, developer);
	            ps.setString(2, managerId);
	            ps.setString(3, startDate);
	            rs = ps.executeQuery();

	            if (rs.next() && rs.getInt(1) > 0) {
	                // If record exists, perform UPDATE
	                ps.close();  // Close previous PreparedStatement
	                ps = conn.prepareStatement(updateQuery);
	                ps.setString(1, developer);
	                ps.setString(2, managerId);
	                ps.setString(3, startDate);
	                ps.executeUpdate();  // Update existing record
	            } else {
	                // If no record exists, perform INSERT
	                ps.close();  // Close previous PreparedStatement
	                ps = conn.prepareStatement(insertQuery);
	                ps.setString(1, managerId);
	                ps.setString(2, developer);
	                ps.setString(3, startDate);
	                ps.executeUpdate();  // Insert new record
	            }
	        }

	        // Set success message and forward to the same page
	        request.setAttribute("message", "Developers assigned successfully!");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("AddManager.jsp");
	        dispatcher.forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    } finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
	        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
	    }
	}

}
