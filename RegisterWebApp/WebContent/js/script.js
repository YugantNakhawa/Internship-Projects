// Function to update the email field dynamically
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
                "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
                "Delhi": ["Delhi"],
                "Karnataka": ["Bangalore", "Mysore", "Mangalore"],
                "Gujarat": ["Ahmedabad", "Surat", "Vadodara"],
                "Uttarakhand": ["Dehradun", "Haridwar"]
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
        
        
        
        
        /*
        function validatePasswordStrength() {
            const firstname = document.getElementById("firstname").value.toLowerCase();
            const lastname = document.getElementById("lastname").value.toLowerCase();
            const email = document.getElementById("email").value.toLowerCase();
            const contact = document.getElementById("contact").value.toLowerCase();
            const dateOfJoining = document.querySelector("input[name='date_of_joining']").value.toLowerCase();
            const address = document.getElementById("address").value.toLowerCase();
            const state = document.getElementById("state").value.toLowerCase();
            const password = document.getElementById("password").value;
            const suggestions = document.getElementById("passwordWarning");
            const submitButton = document.querySelector("button[type='submit']");

            if (!password) {
                suggestions.textContent = "";
                submitButton.disabled = true; // Disable submit if password is empty
                return;
            }

            if (password.includes(firstname) || password.includes(lastname)) {
                suggestions.textContent = "Weak password: Avoid using your name or lastname in the password.";
                suggestions.style.color = "red";
                submitButton.disabled = true;
                alert("Weak password: Avoid using your name or lastname in the password."); // Popup message
            } else if (password.includes(email) || password.includes(contact) || password.includes(dateOfJoining) || password.includes(address) || password.includes(state)) {
                suggestions.textContent = "Moderate password: Avoid using easily guessed personal details.";
                suggestions.style.color = "orange";
                submitButton.disabled = false;
            } else {
                suggestions.textContent = "Strong password: Good choice!";
                suggestions.style.color = "green";
                submitButton.disabled = false;
            }
        }

*/