<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Check session validity
    if (session == null || session.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String empid = (String) session.getAttribute("empid");
    String role = (String) session.getAttribute("role");

    String targetEmpId = empid;
    String targetEmail = null;

    // Allow search for P1 role
    if ("P1".equals(role)) {
        String searchEmpId = request.getParameter("searchEmpId");
        if (searchEmpId != null && !searchEmpId.trim().isEmpty()) {
            targetEmpId = searchEmpId;
        }
    } else if ("P2".equals(role)) {
        targetEmail = (String) session.getAttribute("email");
    }

    // Variables for employee details
    String firstname = "", lastname = "", email = "", date_of_joining = "", employeeType = "",
           employeeExitDate = "", contact = "", address = "", state = "", city = "",
           hobbies = "", gender = "", employeeStatus = "", employeeRole = "";

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root")) {
        PreparedStatement ps;
        if ("P1".equals(role)) {
            ps = conn.prepareStatement("SELECT * FROM employees WHERE empid = ?");
            ps.setString(1, targetEmpId);
        } else { // P2
            ps = conn.prepareStatement("SELECT * FROM employees WHERE email = ?");
            ps.setString(1, targetEmail);
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            firstname = rs.getString("firstname");
            lastname = rs.getString("lastname");
            email = rs.getString("email");
            date_of_joining = rs.getString("date_of_joining");
            contact = rs.getString("contact");
            address = rs.getString("address");
            state = rs.getString("state");
            city = rs.getString("city");
            hobbies = rs.getString("hobbies");
            gender = rs.getString("gender");
            employeeType = rs.getString("employee_type");
            employeeExitDate = rs.getString("employee_exit_date");
            employeeStatus = rs.getString("employee_status");
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
    <title>Edit Employee Details</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <style>
        body {
            background-color: #67a4e1;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
            color: #333;
        }

        h1 {
            color: #ffffff;
            margin: 20px 0;
        }

        .design {
            width: 60%;
            margin: 20px auto;
            background-color: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }

        form {
            margin: 20px 0;
        }

        input, select, button, textarea {
            width: 100%;
            max-width: 400px;
            margin: 10px auto;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
            display: block;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
    </style>
    
</head>
<body>
    <h1>Edit Employee Details</h1>


	 <div class="design">
	 
	 
    <% if ("P1".equals(role)) { %>
    <form method="get">
        <label for="searchEmpId">Search Employee by ID:</label>
        <input type="text" id="searchEmpId" name="searchEmpId" value="<%= targetEmpId %>">
        <button type="submit">Search</button>
    </form>
    <% } %>
    
    
    //please check this code
    
    <% if ("P1".equals(role)) { %>
    <form method="get">
    <label for="searchEmpId">Select Employee:</label>
    <select name="searchEmpId" id="searchEmpId">
        <% 
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Load JDBC driver and connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

                // Query to fetch developers with specific role and active status
                String sql = "SELECT DISTINCT e.empid, e.firstname, e.lastname " +
                             "FROM employees e " +
                             "LEFT JOIN emp_manager_map em ON e.empid = em.empid " +
                             "WHERE e.role = 'P2' " +
                             "AND em.status = 'Active'";

                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                // Populate the dropdown with employee data
                while (rs.next()) {
                    String empId = rs.getString("empid");
                    String name = rs.getString("firstname") + " " + rs.getString("lastname");
        %>
                    <option value="<%= empId %>"><%= name %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log the error for debugging
        %>
                <option value="">Error loading data</option>
        <%
            } finally {
                // Close resources to prevent memory leaks
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </select><br><br>
    <button type="submit">Search</button>
</form>
<% } %>
    

    <form action="update" method="post">
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
        <input type="text" value="<%= date_of_joining %>" disabled><br>

        <label>Gender:</label>
        <input type="text" value="<%= gender %>" disabled><br>

        <% if ("P1".equals(role)) { %>
        
        
        <label>Contact:</label>
        <input type="text" value="<%= contact %>" disabled><br>
        
        <label>Address:</label>
        <input type="text" value="<%= address %>" disabled><br>
        
        <label>State:</label>
        <input type="text" value="<%= state %>" disabled><br>
        
        <label>City:</label>
        <input type="text" value="<%= city %>" disabled><br>
        
        <label for="hobbies">Hobbies:</label>
        <textarea id="hobbies" name="hobbies" disabled><%= hobbies %></textarea><br>
        
        <label for="employee_status">Status:</label>
        <select name="employee_status" id="employee_status">
            <option value="Active" <%= "Active".equals(employeeStatus) ? "selected" : "" %>>Active</option>
            <option value="Inactive" <%= "Inactive".equals(employeeStatus) ? "selected" : "" %>>Inactive</option>
        </select><br>
        
        <label for="employee_type">Employee Type:</label>
        <select name="employee_type" id="employee_type">
            <option value="Contract" <%= "Contract".equals(employeeType) ? "selected" : "" %>>Contract</option>
            <option value="Permanent" <%= "Permanent".equals(employeeType) ? "selected" : "" %>>Permanent</option>
        </select><br>

        <label for="role">Role:</label>
        <select name="role" id="role">
            <option value="P1" <%= "P1".equals(employeeRole) ? "selected" : "" %>>P1</option>
            <option value="P2" <%= "P2".equals(employeeRole) ? "selected" : "" %>>P2</option>
        </select><br>

        <label for="employeeExitDate">Exit Date:</label>
        <input type="date" id="employeeExitDate" name="employeeExitDate" value="<%= employeeExitDate %>"><br>
        <% } 
        
        
        else if ("P2".equals(role)) { %>
        
        
        <label>Role:</label>
        <input type="text" value="<%= role %>" disabled><br>
        
        <label>Status:</label>
        <input type="text" value="<%= employeeStatus %>" disabled><br>
        
        <label>Employee Type:</label>
        <input type="text" value="<%= employeeType %>" disabled><br>
        
        <label>Exit Date:</label>
        <input type="text" value="<%= employeeExitDate %>" disabled><br>
        
        <label for="contact">Contact:</label>
        <input type="text" id="contact" name="contact" value="<%= contact %>"><br>

        <label for="address">Address:</label>
        <textarea id="address" name="address"><%= address %></textarea><br>

        <label for="state">State:</label>
        <select name="state" id="state" required>
            <option value="Maharashtra" <%= "Maharashtra".equals(state) ? "selected" : "" %>>Maharashtra</option>
            <option value="Tamil Nadu" <%= "Tamil Nadu".equals(state) ? "selected" : "" %>>Tamil Nadu</option>
            <option value="Madhya Pradesh" <%= "Madhya Pradesh".equals(state) ? "selected" : "" %>>Madhya Pradesh</option>
            <option value="Goa" <%= "Goa".equals(state) ? "selected" : "" %>>Goa</option>
            <option value="Haryana" <%= "Haryana".equals(state) ? "selected" : "" %>>Haryana</option>
        </select><br> <br>

        <label for="city">City:</label>
        <select name="city" id="city" required>
            <option value="<%= city %>" selected><%= city.isEmpty() ? "Select City" : city %></option>
        </select><br>
        

        <label for="hobbies">Hobbies:</label>
         <label><input type="checkbox" name="hobbies" value="Reading" <%= hobbies.contains("Reading") ? "checked" : "" %>> Reading</label>
		 <label><input type="checkbox" name="hobbies" value="Music" <%= hobbies.contains("Music") ? "checked" : "" %>> Music</label>
		 <label><input type="checkbox" name="hobbies" value="Sports" <%= hobbies.contains("Sports") ? "checked" : "" %>> Sports</label>
		 <label><input type="checkbox" name="hobbies" value="Gaming" <%= hobbies.contains("Gaming") ? "checked" : "" %>> Gaming</label>
		 <label><input type="checkbox" name="hobbies" value="Coding" <%= hobbies.contains("Coding") ? "checked" : "" %>> Coding</label>
        <% } %> <br>

        <button type="submit">Update</button>
        </div>
    </form>
    
    <script>
        $(document).ready(function () {
            // Initialize select2
            $('#state').select2();
            $('#city').select2();

            // City data
            var city_data = {
                "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik", "Kolhapur"],
                "Tamil Nadu": ["Chennai", "Madurai", "Vellore"],
                "Madhya Pradesh": ["Bhopal", "Indore", "Gwalior"],
                "Goa": ["Panaji", "Madgaon", "Mapusa"],
                "Haryana": ["Gurugram", "Ambala", "Sonipat"]
            };

            // Populate cities based on state
            $('#state').change(function () {
                var selectedState = $(this).val();
                var cities = city_data[selectedState] || [];

                $('#city').empty().append('<option value="">Select City</option>');
                $.each(cities, function (index, city) {
                    $('#city').append('<option value="' + city + '">' + city + '</option>');
                });

                $('#city').trigger('change');
            });
        });
    </script>
    
</body>
</html>