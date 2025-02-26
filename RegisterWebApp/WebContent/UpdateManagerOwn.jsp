<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>


<%@ page import="java.sql.*" %>
<%
    // Check session validity
    if (session == null || session.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    
    String empid = (String) session.getAttribute("empId");
    String role = (String) session.getAttribute("role");
    System.out.println(empid);
    String targetEmpId = empid;
    String targetEmail = null;
    
    
    // Variables for employee details
    String firstname = "", lastname = "", email = "", dateOfJoining = "", employeeType = "",
           empExitDate = "", contact = "", address = "", state = "", city = "",
           hobbies = "", gender = "", employeeStatus = "", employeeRole = "";
 
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root")) {
        PreparedStatement ps;
        ps = conn.prepareStatement("SELECT * FROM employees WHERE empid = ?");
        ps.setString(1, targetEmpId);
        
         ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            firstname = rs.getString("firstname");
            lastname = rs.getString("lastname");
            email = rs.getString("email");
            dateOfJoining = rs.getString("dateOfJoining");
            contact = rs.getString("contact");
            address = rs.getString("address");
            state = rs.getString("state");
            city = rs.getString("city");
            hobbies = rs.getString("hobbies");
            gender = rs.getString("gender");
            employeeType = rs.getString("employeeType");
            empExitDate = rs.getString("empExitDate");
            employeeStatus = rs.getString("status");
            employeeRole = rs.getString("role");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/ufs.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<title>Edit Employee Details</title>
</head>
<body>


 <% 
    String loggedInManagerId = (String) session.getAttribute("empId"); // Get logged-in manager ID
%>

 <form action="update" method="post">
<h1>Update your Details</h1>
<input type="hidden" name="targetEmpId" value="<%= targetEmpId %>">
 
        <c:if test="${not empty successMessage}">
<p style="color: green;">${successMessage}</p>
</c:if>
<c:if test="${not empty errorMessage}">
<p style="color: red;">${errorMessage}</p>
</c:if>
 
<label>First Name:</label>
<input type="text" value="<%= firstname %>" disabled> <br>
 
<label>Last Name:</label>
<input type="text" value="<%= lastname %>" disabled> <br>
 
<label>Email:</label>
<input type="text" value="<%= email %>" disabled><br>

<label>Date of Joining:</label>
<input type="text" value="<%= dateOfJoining %>" disabled><br>
 
<label>Gender:</label>
<input type="text" value="<%= gender %>" disabled><br>

<label for="contact">Contact:</label>
<input type="text" id="contact" name="contact" value="<%= contact %>"><br>
 
        <label for="address">Address:</label>
<textarea id="address" name="address"><%= address %></textarea><br>
 
        <label for="state">State:</label>
<select id="state" name="state" onchange="updateCities();" required>
            <option value="">Select State</option>
            <option value="Andhra Pradesh">Andhra Pradesh</option>
            <option value="Uttar Pradesh">Uttar Pradesh</option>
            <option value="Maharashtra">Maharashtra</option>
            <option value="Delhi">Delhi</option>
            <option value="Karnataka">Karnataka</option>
        </select><br><br>

        <label for="city">City:</label>
        <select id="city" name="city" required>
            <option value="">Select City</option>
        </select><br><br>


<label for="role">Role:</label>
<input type="text" value="<%= role %>" disabled><br>
 
 <label for="employeeType">Employee Type:</label>
<input type="text" value="<%= employeeType %>" disabled><br>
 
        <label for="hobbies">Hobbies:</label>
<label><input type="checkbox" name="hobbies" value="Reading" <%= hobbies.contains("Reading") ? "checked" : "" %>> Reading</label>
<label><input type="checkbox" name="hobbies" value="Travelling" <%= hobbies.contains("Travelling") ? "checked" : "" %>> Travelling</label>
<label><input type="checkbox" name="hobbies" value="Singing" <%= hobbies.contains("Singing") ? "checked" : "" %>> Singing</label>
<label><input type="checkbox" name="hobbies" value="Dancing" <%= hobbies.contains("Dancing") ? "checked" : "" %>> Dancing</label>
<label><input type="checkbox" name="hobbies" value="Sports" <%= hobbies.contains("Sports") ? "checked" : "" %>> Sports</label>
 <br>

 
        <button type="submit">Update</button>
</form>
</body>
</html>



