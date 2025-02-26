<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login Page</title>
    <script src="js/script.js"></script>
    <style>
        @charset "ISO-8859-1";

        body {
            background-color: #67a4e1; /* Subtle light gray background */
            font-family: 'Arial', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
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
        input[type="submit"] {
            background-color: #007bff; /* Primary blue */
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Labels */
        label {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 2px; /* Reduced margin for labels */
            color: #495057; /* Subtle dark text */
            display: inline-block; /* Aligns label to the left */
            margin-right: 10px; /* Space between label and input */
            padding: 3px;
        }

        /* Error message */
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

    </style>
</head>
<body>
    <h1>Login Page</h1>
    <div class="design">
        <form action="login" method="post" onsubmit="return validateLoginForm()">
            <label for="username">Email</label>
            <input type="text" id="username" name="username" placeholder="Enter Email" required>
            <div id="username-error" class="error-message"></div>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter Password" required>
            <div id="password-error" class="error-message"></div>

            <input type="submit" value="Login">

            <h3>Haven't Registered? <a href="empr.jsp">Create a new Account</a></h3>

            <% 
                // Check if there's an error message and display it
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { 
            %>
                <div class="error-message"><%= errorMessage %></div>
            <% } %>
        </form>
    </div>

    <script>
        // Validation function for the login form
        function validateLoginForm() {
            let username = document.getElementById("username").value;
            let password = document.getElementById("password").value;

            
            // Basic validation
            if (username == "" || password == "") {
                alert("Both fields are required.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
