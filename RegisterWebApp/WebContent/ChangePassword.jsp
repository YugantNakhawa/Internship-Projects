<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%
    // Check if session exists
    if (session == null || session.getAttribute("isLoggedIn") == null || session.getAttribute("role") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

	String email = (String) session.getAttribute("email");
	String firstname = "", lastname = "", dateOfJoining = "", contact = "", address = "", state = "";
	
	// Connect to the database and fetch employee details
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");
	    String sql = "SELECT firstname, lastname, date_of_joining, contact, address, state FROM employees WHERE email = ?";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ps.setString(1, email);
	    ResultSet rs = ps.executeQuery();
	
	    if (rs.next()) {
	        firstname = rs.getString("firstname");
	        lastname = rs.getString("lastname");
	        dateOfJoining = rs.getString("date_of_joining");
	        contact = rs.getString("contact");
	        address = rs.getString("address");
	        state = rs.getString("state");
	    }
	    conn.close();
	} catch (Exception e) {
	    e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <script src="js/script.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>


<script>
        function validatePasswordStrength() {
            const newPassword = document.getElementById("newPassword").value;
            const firstname = "<%= firstname.toLowerCase() %>";
            const lastname = "<%= lastname.toLowerCase() %>";
            const dateOfJoining = "<%= dateOfJoining %>";
            const formattedDoj = dateOfJoining.substring(8, 10) + dateOfJoining.substring(5, 7) + dateOfJoining.substring(0, 4);
            const contact = "<%= contact %>";
            const address = "<%= address.toLowerCase() %>";
            const state = "<%= state.toLowerCase() %>";
            const contexio = "contexio".toLowerCase();
            
         // Defining the criteria for password validation
            const hasUppercase = /[A-Z]/.test(newPassword);
            const hasLowercase = /[a-z]/.test(newPassword);
            const hasNumber = /[0-9]/.test(newPassword);
            const hasSpecialChar = /[@$!%*?&#]/.test(newPassword);
            const isAtLeast8Chars = newPassword.length >= 8;

            //let strength = "Strong password";

            if (newPassword.toLowerCase().includes(firstname) || newPassword.toLowerCase().includes(lastname)) {
                strength = "Weak password";
            } else if (
                newPassword.toLowerCase().includes(contexio) ||
                newPassword.includes(formattedDoj) ||
                newPassword.includes(contact) ||
                newPassword.toLowerCase().includes(address) ||
                newPassword.toLowerCase().includes(state)
            ) {
                strength = "Medium password";
            }
            
            else{
            	strength = "Strong password";
            }
            
         // Check basic password criteria
            if (!isAtLeast8Chars || !hasUppercase || !hasLowercase || !hasNumber || !hasSpecialChar) {
                strength = "Weak password";
            }

            const strengthIndicator = document.getElementById("passwordStrength");
            strengthIndicator.textContent = strength;

            if (strength === "Weak password") {
                strengthIndicator.style.color = "red";
            } else if (strength === "Medium password") {
                strengthIndicator.style.color = "orange";
            } else {
                strengthIndicator.style.color = "green";
            }
        }
        
        
        // find this function
    // Add event listener for the password input field to trigger validation on input
	document.getElementById("newPassword").addEventListener("input", function() {
	    // Validate password strength and get the result
	    validatePasswordStrength();
	
	    // Get the password strength text
	    const strengthIndicator = document.getElementById("passwordStrength").textContent;
	
	    // Disable the button if the password is weak
	    document.getElementById("submit").disabled = (strengthIndicator === "Weak password");
	});

        
    </script>

<style>
        .message {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid transparent;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }
        .success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        
        
    </style>

<body>
    <h2>Change Password</h2>
    
    <!-- Display message if present -->
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
            String messageClass = message.contains("successfully") ? "success" : "error";
    %>
        <div class="message <%= messageClass %>">
            <%= message %>
        </div>
    <%
        }
    %>
    
    <div class="design">
        <form action="Change" method="post">
            <div class="form-group">
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" oninput="validatePassword();" required>
            </div>
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" oninput="validatePasswordStrength();" required>
                <p id="passwordStrength" style="font-weight: bold; margin-top: 5px;"></p>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm New Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" id="submit">Change Password</button>
        </form>
    </div>
</body>
</html>
