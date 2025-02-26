# Register WebApp

**Register WebApp** is a web application built using Java, JSP (Java Server Pages), and Servlets. It provides essential functionalities related to user management, including login, registration, password management, and employee data management. The application interfaces with a MySQL database for storing and retrieving information.

## Features

- **Login Page**: Allows registered users to log into the system with their credentials.
- **Registration Page**: New users can create an account by providing necessary details.
- **Change Password Page**: Registered users can change their password.
- **Add Developers Page**: Managers can assign new developers under them.
- **Update Employee Details Page**: Managers can update the details of employees assigned under them, they can also edit their own details. Employees can also edit their own details after login.

## Technologies Used

- **Backend**: Java JSP and Servlets
- **Frontend**: HTML, CSS and Javascript
- **Database**: MySQL

## Installation

To set up the project locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/YugantNakhawa/Internship-Projects.git
   ```

2. **Set Up Database**:
   - Ensure MySQL is installed and running.
   - Create a new database named `register_webapp` and run the queries.

3. **Software Installation and JARS**
   - Install Eclipse (Latest version) and download necessary JARS from https://mvnrepository.com/

      **JARS Required:**
         - servlet-api-2.5.jar
         - jsp-api-2.2.jar
         - jstl-1.2.jar
         - mysql-connector-java-8.0.13.jar

4. **Configure Database Connection**:
   - In the `web.xml` or database configuration file, update the MySQL connection details (username, password, URL).

5. **Deploy the Application**:
   - Use a Java servlet container like **Apache Tomcat** to deploy the application.
   - Start the Tomcat server and navigate to `http://localhost:8080/your-app-name` to access the web application.

