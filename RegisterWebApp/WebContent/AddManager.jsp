<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%
    // Check if session exists
    if (session == null || session.getAttribute("isLoggedIn") == null || !"P1".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Manager</title>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
    <!-- Include Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>

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

        input, select, button {
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

    <script>
        $(document).ready(function() {
            $('#developers').select2({
                placeholder: "Select Developers",
                width: '100%'
            });
        });
    </script>
</head>
<body>
    <h1>Assign Developers to a Project</h1>
    <c:if test="${not empty message}">
        <div style="color: green; font-weight: bold;">
            ${message}
        </div>
    </c:if>

    <div class="design">
        <form action="Add" method="post">
            <label for="developers">Select Developers:</label>
            <select name="developers" id="developers" multiple required>
                <% 
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

                        /* String sql = "SELECT DISTINCT e.empid, e.firstname, e.lastname " +  //this query for searching
                                     "FROM employees e " +
                                     "LEFT JOIN emp_manager_map em ON e.empid = em.empid " +
                                     "WHERE e.role = 'P2' " +
                                     "  AND e.employee_status = 'Active' " +
                                     "  AND (em.empid IS NULL OR em.status = 'Inactive')"; */
                        		
                        		
                        	String sql = "SELECT DISTINCT e.empid, e.firstname, e.lastname " +
							             "FROM employees e " +
							             "LEFT JOIN emp_manager_map em " +
							             "ON e.empid = em.empid " +
							             "AND em.status = 'Active' " +
							             "WHERE e.role = 'P2' " +
							             "AND e.employee_status = 'Active' " +
							             "AND (em.empid IS NULL " +
							             "OR NOT EXISTS ( " +
							             "SELECT 1 FROM emp_manager_map em2 " +
							             "WHERE em2.empid = e.empid " +
							             "AND em2.status = 'Active'))";


                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String empId = rs.getString("empid");
                            String name = rs.getString("firstname") + " " + rs.getString("lastname");
                %>
                            <option value="<%= empId %>"><%= name %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                    }
                %>
            </select><br><br>

            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required><br><br>

            <button type="submit">Assign Developers</button>
        </form>
    </div>

    <h2>Assigned Developers</h2>
    <table>
        <thead>
            <tr>
                <th>Manager ID</th>
                <th>Developer Name</th>
                <th>Start Date</th>
                <th>Status</th>
                <th>Insert Date</th>
                <th>Update Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
                Connection conn2 = null;
                PreparedStatement ps2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

                    String mapSql = "SELECT em.managerid, " +
                            "d.firstname AS developer_firstname, d.lastname AS developer_lastname, em.start_date, em.status, " +
                            "em.empid, em.insertdate, em.updatedate " +
                            "FROM emp_manager_map em " +
                            "JOIN employees d ON em.empid = d.empid " +
                            "WHERE em.status = 'Active'";
                    ps2 = conn2.prepareStatement(mapSql);
                    rs2 = ps2.executeQuery();

                    while (rs2.next()) {
                        String managerId = rs2.getString("managerid");
                        String developerName = rs2.getString("developer_firstname") + " " + rs2.getString("developer_lastname");
                        String startDate = rs2.getString("start_date");
                        String status = rs2.getString("status");
                        String insertDate = rs2.getString("insertdate");
                        String updateDate = rs2.getString("updatedate");
                        String developerId = rs2.getString("empid");
            %>
                        <tr>
                            <td><%= managerId %></td>
                            <td><%= developerName %></td>
                            <td><%= startDate %></td>
                            <td><%= status %></td>
                            <td><%= insertDate %></td>
                            <td><%= updateDate %></td>
                            <td>
                                <form action="Delete" method="post">
                                    <input type="hidden" name="developerId" value="<%= developerId %>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this developer?')">Delete</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs2 != null) try { rs2.close(); } catch (SQLException ignored) {}
                    if (ps2 != null) try { ps2.close(); } catch (SQLException ignored) {}
                    if (conn2 != null) try { conn2.close(); } catch (SQLException ignored) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
