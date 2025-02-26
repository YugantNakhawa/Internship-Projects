<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session == null || session.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String empId = (String) session.getAttribute("empId");
    session.setAttribute("empId", empId);
    String firstname = (String) session.getAttribute("firstname");
    String lastname = (String) session.getAttribute("lastname");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role"); // Get role from session
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
</head>



<style>
    
    .password-strength {
            display: inline-block;
            margin-left: 10px;
            font-weight: bold;
        }
        .weak {
            color: red;
        }
        .medium {
            color: orange;
        }
        .strong {
            color: green;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
        
        @charset "ISO-8859-1";

body {
    background-color: #67a4e1; /* Subtle light gray background */
    font-family: 'Arial', sans-serif;
    text-align: center;
    margin: 0;
    padding: 0;
}

h2 {
    color: #ffffff; /* Dark gray for heading */
    margin-bottom: 20px;
}

/* Form container styling */
.design {
    width: 60%;
    margin: 0 auto;
    background-color: #ffffff; /* White background for form */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* Light shadow for form */
    border-radius: 10px; /* Rounded corners */
    padding: 20px;
    align-items: center;
    justify-content: center;
}

form {
    margin: 0;
}

/* Input fields styling */
input, select, textarea, button {
   width: 100%;
   max-width: 400px;
   margin: 9px 0; /* Reduced margin between input and label */
   padding: 9px; /* Reduced padding */
   border: 1px solid #ced4da; /* Subtle border */
   border-radius: 5px; /* Rounded edges */
   font-size: 14px;
   box-sizing: border-box;
   display: inline-block; /* Aligns input field next to label */
}

textarea {
   resize: none; /* Prevent resizing of textarea */
}

/* Buttons */
button {
   background-color: #007bff; /* Primary blue */
   color: white;
   border: none;
   cursor: pointer;
   transition: background-color 0.3s;
}

button:hover {
   background-color: #0056b3; /* Darker blue on hover */
}

/* Labels and groupings */
label {
   font-size: 14px;
   font-weight: bold;
   margin-bottom: 2px; /* Reduced margin for labels */
   color: #495057; /* Subtle dark text */
   display: inline-block; /* Aligns label to the left */
   margin-right: 10px; /* Space between label and input */
   padding: 3px;
}

input[type="radio"], input[type="checkbox"] {
   width: auto;
   margin-right: 5px; /* Close spacing between input and label */
}

/* Group items in a grid layout */
.form-group {
   margin: 0; /* No additional margin for form group */
   padding-left: 0; /* Remove any extra left padding */
   display: flex;
   align-items: center; /* Align label and input in a single line */
   flex-direction: column; /* Allow multiple lines of content */
}

.error-message {
   color: red;
   font-size: 0.9em;
   display: block; /* Ensures the error message appears below the field */
   margin-top: 5px; /* Space between input field and error message */
   font-weight: bold;
}

input.error {
   border-color: red; /* Highlight the input with red border on error */
}

.form-group {
   margin-bottom: 15px;
}

input.error + .error-message {
   display: block;
}

.form-group input.error {
   border-color: red;
}

textarea.error {
   border-color: red;
}

.weak {
    color: red;
}

.medium {
    color: yellow;
}

.strong {
    color: green;
    }
    
    </style>

</style>




<body>
    <h1>Welcome, <%= firstname + " " + lastname %>, Email: <%= email %></h1>
    <hr>
    <div class="design">
    <div class="form-group">
    
 
    
    
    
    <a href="ChangePassword.jsp"><button type="button">Change Password</button></a>
    <a href="update_employee.jsp"><button type="button">Update Employee Details</button></a>
    <% if ("P1".equalsIgnoreCase(role)) { %>
        <a href="AddManager.jsp"><button type="button">Assign Developers</button></a>
        <a href="UpdateManagerOwn.jsp"><button type="button">Update your details</button></a><br>
    <% } %>
    <hr>
    <a href="logout.jsp"><button type="button" style: "background:color: green"; color:"white" >Logout</button></a>
    </div>
    </div>
</body>
</html>
