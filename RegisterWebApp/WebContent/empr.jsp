<!DOCTYPE html>
<html lang="en">
<head>
    <title>Employee Registration</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="js/script.js"></script>
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
</head>
<body>
    <h2>Employee Registration Form</h2>

    <div class="design">
        <form action="reg" method="post">
            <!-- Required Fields -->
            <div class="form-group">
                <label for="firstname">First Name:</label>
                <input type="text" id="firstname" name="firstname" placeholder="Firstname" oninput="updateEmail(); validateName(this, 'firstname-error'); validatePasswordStrength();" required pattern="[A-Za-z]+">
                <span id="firstname-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="lastname">Last Name:</label>
                <input type="text" id="lastname" name="lastname" placeholder="Lastname" oninput="updateEmail(); validateName(this, 'lastname-error'); validatePasswordStrength();" pattern="[A-Za-z]+">
                <span id="lastname-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="firstname.lastname@contexio.co.in" oninput="validatePasswordStrength();" readonly required>
            </div>

            <div class="form-group">
                <label for="date_of_joining">Date of Joining:</label>
                <input type="date" name="date_of_joining" id="date_of_joining" placeholder="yyyy-mm-dd" oninput="validatePasswordStrength();" required>
            </div>

            <div class="form-group">
                <label for="contact">Contact Number:</label>
                <input type="text" name="contact" id="contact" placeholder="Enter 10-digit mobile number" maxlength="10" required pattern="^[0-9]{10}$" oninput="validateContact(); validatePasswordStrength();">
                <span id="contact-error" class="error-message"></span>
            </div>
            
            <div class="form-group">
                <label for="role">Role:</label>
                <select name="role" id="role" required>
                    <option value="P1">P1</option>
                    <option value="P2">P2</option>
                </select>
            </div> 

            <div class="form-group-radio">
                <label>Gender:</label>
                <label><input type="radio" name="gender" value="Male" required> Male</label>
                <label><input type="radio" name="gender" value="Female" required> Female</label>
                <label><input type="radio" name="gender" value="other" required> Other</label>
            </div><br><br>

            <div class="form-group">
                <label for="employee_type">Employee Type:</label>
                <select name="employee_type" id="employee_type" required>
                    <option value="Contract">Contract</option>
                    <option value="Permanent">Permanent</option>
                </select>
            </div> 

            <div class="form-group">
                <label for="state">State:</label>
                <select name="state" id="state" required>
                    <option value="Maharashtra">Maharashtra</option>
                    <option value="Tamil Nadu">Tamil Nadu</option>
                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                    <option value="Goa">Goa</option>
                    <option value="Haryana">Haryana</option>
                </select>
            </div> <br>

            <div class="form-group">
                <label for="city">City:</label>
                <select name="city" id="city" required>
                    <option value="">Select City</option>
                </select>
            </div> <br>

            <div class="form-group-hobbies">
                <label>Hobbies:</label>
                <label><input type="checkbox" name="hobbies" value="Reading"> Reading</label>
                <label><input type="checkbox" name="hobbies" value="Music"> Music</label>
                <label><input type="checkbox" name="hobbies" value="Sports"> Sports</label>
                <label><input type="checkbox" name="hobbies" value="Gaming"> Gaming</label>
                <label><input type="checkbox" name="hobbies" value="Coding"> Coding</label>
            </div> <br>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea name="address" id="address"></textarea>
                <span id="address-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" placeholder="Password (min 8 characters)" required pattern=".{8,}" oninput="validatePassword(); validatePasswordStrength();">
                <span id="password-error" class="error-message"></span>
                <span id="password-strength" class="password-strength"></span>
                
            </div>

            <div class="form-group">
                <label for="confirm_password">Confirm Password:</label>
                <input type="password" name="confirm_password" id="confirm_password" placeholder="Confirm Password" required pattern=".{8,}" oninput="validatePassword(); validatePasswordStrength();">
                <span id="confirm-password-error" class="error-message"></span>
            </div>

            

            <div class="form-group">
                <label><input type="checkbox" name="terms" required> I agree to the Terms and Conditions</label>
            </div>

            <button type="submit" id="register-button">Submit</button> <br>
            
            <h3>Already a User? <a href="login.jsp">Log in</a></h3>
            
        </form>
    </div>

   <script>
    // Function to validate password strength
    function validatePasswordStrength() {
        const password = document.getElementById("password").value;
        const firstname = document.getElementById("firstname").value.trim();
        const lastname = document.getElementById("lastname").value.trim();
        const email = document.getElementById("email").value.trim();
        const doj = document.getElementById("date_of_joining").value; // Use original date input
        const formattedDoj = doj.substring(8, 10) + doj.substring(5, 7) + doj.substring(0, 4);
        
        
        
        //line1
        //const date_of_joining = document.getElementById("date_of_joining").value.toLowerCase();
        

        const contact = document.getElementById("contact").value.trim();
        const address = document.getElementById("address").value.toLowerCase();
        const state = document.getElementById("state").value.trim();
        const pattern = /^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8}$/;

        let strengthMessage = "";
        let strengthClass = "";

        const strengthSpan = document.getElementById("password-strength");

        // Only validate and show password strength if there is input in the password field
        if (password === "") {
            strengthSpan.textContent = ""; // Clear message if password field is empty
            strengthSpan.className = ""; // Clear the class
            return "empty"; // Return a special value for empty password
        }

        // Weak password logic
        const firstnameLower = firstname.toLowerCase();
        const lastnameLower = lastname.toLowerCase();
        if (password.toLowerCase().includes(firstnameLower) || 
            password.toLowerCase().includes(lastnameLower) || 
            password.includes(firstname) || 
            password.includes(lastname) || password.length < 8) {
            strengthMessage = "Weak password: Contains personal details, you can't register with a weak password";
            strengthClass = "weak";
        }
        // Check if firstname or lastname is in all caps
        else if (password.includes(firstname.toUpperCase()) || 
                 password.includes(lastname.toUpperCase())) {
            strengthMessage = "Weak password: Contains personal details, you can't register with a weak password";
            strengthClass = "weak";
        }
        // Medium password logic
        else if (
            (email.includes("contexio") && password.toLowerCase().includes("contexio")) ||
            password.includes(formattedDoj) ||
            password.includes(contact) ||
            password.toLowerCase().includes(address.toLowerCase()) ||
            password.toLowerCase().includes(state.toLowerCase())
        ) {
            strengthMessage = "Medium password: Will work, but please improve";
            strengthClass = "medium";
        }
        // Strong password logic
        else {
            // Check if all optional fields are empty to avoid false strong results
            if (!firstname && !lastname && !email && !date_of_joining && !contact && !address && !state && !pattern.test(password)) {
                strengthMessage = "Strong password: No personal details detected, but the form is empty";
                strengthClass = "weak"; // Consider weak if no form fields entered
            
                if (password.length < 8) { // the logic
                    strengthMessage = "Too short, Improve";
                    strengthClass = "weak";
                }
            
            } else {
                strengthMessage = "Strong password: No personal details detected";
                strengthClass = "strong";
            }
        }

        strengthSpan.textContent = strengthMessage;
        strengthSpan.className = strengthClass;

        return strengthClass; // Return the strength class for further validation
    }

    // Add event listener for the password input field to trigger validation on input
    document.getElementById("password").addEventListener("input", function() {
        const strengthClass = validatePasswordStrength();
        
        // Disable the register button if password is weak
        document.getElementById("register-button").disabled = (strengthClass === "weak");
    });

    // Add event listener for the submit button to prevent form submission if password is weak
    document.getElementById("register-button").addEventListener("click", function(event) {
        const strengthClass = validatePasswordStrength();

        // Prevent form submission if the password is weak
        if (strengthClass === "weak") {
            event.preventDefault(); // Prevent form submission
            // Optionally, display a message on the page instead of using alert
            const message = document.getElementById("password-message");
            message.textContent = "Please improve your password strength.";
            message.style.color = "red"; // Style the message as an error
        }
    });

    // Optional: Disable the register button initially
    document.getElementById("register-button").disabled = true;
    
    
    function updateEmail() {
        const firstname = document.getElementById("firstname").value.trim();
        const lastname = document.getElementById("lastname").value.trim();
        const emailField = document.getElementById("email");

        // Generate email based on available names
        if (firstname && lastname) {
            emailField.value = firstname.toLowerCase() + "." + lastname.toLowerCase() + "@contexio.co.in";
        } else if (firstname) {
            emailField.value = firstname.toLowerCase() + "@contexio.co.in";
        } else {
            emailField.value = ""; // Clear the email if firstname is empty
        }
    }

    // Function to check the password and confirm password match
    function validatePassword() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirm_password").value;

        // Password validation: 1 uppercase letter, 1 special character, min 8 characters
        const passwordRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;

        if (password && !passwordRegex.test(password)) {
            document.getElementById("password-error").innerText = "Password must contain at least 1 uppercase letter, 1 special character, and be at least 8 characters long.";
        } else {
            document.getElementById("password-error").innerText = "";
        }

        // Check if passwords match
        if (password !== confirmPassword) {
            document.getElementById("confirm-password-error").innerText = "Passwords do not match!";
        } else {
            document.getElementById("confirm-password-error").innerText = "";
        }
    }

    // Function to check contact number for digits only and valid length
    function validateContact() {
        const contact = document.getElementById("contact").value;
        const regex = /^[6-9][0-9]{9}$/;
        if (contact && !regex.test(contact)) {
            document.getElementById("contact-error").innerText = "Please enter a valid 10-digit number (first digit should be from 6-9)";
            document.getElementById("contact").value = contact.substring(0, 10); // Limit to 10 digits
        } else {
            document.getElementById("contact-error").innerText = "";
        }
    }

    // Function to validate letters only for firstname and lastname
    function validateName(inputField, errorField) {
        const nameValue = inputField.value.trim();
        const regex = /^[A-Za-z]+$/;
        if (nameValue && !regex.test(nameValue)) {
            document.getElementById(errorField).innerText = "Only letters are allowed!";
        } else {
            document.getElementById(errorField).innerText = "";
        }
    }

    // Function to validate address (only letters, numbers, spaces, and commas allowed)
    function validateAddress() {
        const address = document.getElementById("address").value;
        const regex = /^[A-Za-z0-9]+$/; // Allows letters, numbers, spaces, and commas
        if (address && !regex.test(address)) {
            document.getElementById("address-error").innerText = "Address cannot contain special characters!";
        } else {
            document.getElementById("address-error").innerText = "";
        }
    }

    $(document).ready(function () {
        // Initialize select2 for state and city dropdowns
        $('#state').select2();
        $('#city').select2();

        // City data based on selected state
        var city_data = {
            "Maharashtra": ["Mumbai", "Pune", "Nagpur","Nashik","Kolhapur"],
            "Tamil Nadu": ["Chennai","Madurai","Vellore"],
            "Madhya Pradesh": ["Bhopal", "Indore", "Gwalior"],
            "Goa": ["Panaji", "Madgaon", "Mapusa"],
            "Haryana": ["Gurugram", "Ambala","Sonipat"]
        };

        // Update city dropdown when state is selected
        $('#state').change(function () {
            var selectedState = $(this).val();
            var cities = city_data[selectedState] || [];
            
            // Clear existing cities and add default "Select City" option
            $('#city').empty().append('<option value="">Select City</option>');

            // Add cities for selected state
            $.each(cities, function (i, city) {
                $('#city').append('<option value="' + city + '">' + city + '</option>');
            });

            // Trigger select2 update
            $('#city').trigger('change');
        });
    });

    // Validate if the password and confirm password match
    /*function validatePassword() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirm_password").value;
        const confirmPasswordError = document.getElementById("confirm-password-error");

        if (password !== confirmPassword) {
            confirmPasswordError.textContent = "Passwords do not match.";
            confirmPasswordError.style.color = "red";
        } else {
            confirmPasswordError.textContent = "";
        }
    }*/
</script>

<!-- Add this somewhere in your HTML for error messaging -->
<div id="password-message"></div>

</body>
</html>
