<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <title>Admin Login</title>

    <link rel="stylesheet" href="css/style.css">

</head>

<body>

<header>

    <h1>Admin Login</h1>

    <p>College Complaint Management System</p>

</header>

<div class="container">

    <h2>Administrator Login</h2>

    <% if ("1".equals(request.getParameter("error"))) { %>

        <p style="color:red;">
            Invalid username or password
        </p>

    <% } %>

    <form action="adminLogin" method="post">

        <label>Username</label>

        <input type="text"
               name="username"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               required>

        <button type="submit" class="btn">
            Login
        </button>

    </form>

    <br>

    <a href="index.html" class="btn">
        Back to Home
    </a>

</div>

</body>
</html>