<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Form</title>
</head>
<body>

<h1>Registration Form</h1>

    <form action="register" method="post">
    <label for="">First Name</label>
    <input type="text" placeholder="john" name="firstname" required> <br>

    <label for="">Last Name</label>
    <input type="text" placeholder="doe" name="lastname" required> <br>

    <label for="">Username</label>
    <input type="text" placeholder="johndoe" name="username" required> <br>

    <label for="">Password</label>
    <input type="password" placeholder="133131" name="password" required> <br>

    <label for="">Address</label>
    <textarea name="" id="" rols="30" cols="40" name="address"></textarea> <br>

    <label for="">Contact</label>
    <input type="number" placeholder="13323234" name="contact" required> <br>

    <input type="submit" value="submit">
    
    
    <h3>Already a User?  <a href="login.jsp"> Log in </a> </h3>
    

</form>

</body>
</html>