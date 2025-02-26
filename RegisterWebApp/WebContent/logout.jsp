<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Use the implicit session object directly
    if (session != null) {
        session.invalidate(); // Invalidate the session to log out the user
    }
    response.sendRedirect("login.jsp"); // Redirect to the login page
%>
