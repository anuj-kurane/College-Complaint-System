<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.collegecomplaint.model.Complaint" %>

<!DOCTYPE html>
<html>

<head>

    <title>Complaint Status</title>

    <link rel="stylesheet" href="css/style.css">

    <style>

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background: #174ea6;
            color: white;
        }

    </style>

</head>

<body>

<header>

    <h1>Complaint Status</h1>

    <p>College Complaint Management System</p>

</header>

<div class="container">

    <h2>Check Your Complaint</h2>

    <form action="checkStatus" method="post">

        <label>Enter Roll Number</label>

        <input type="text"
               name="roll_no"
               required>

        <button type="submit" class="btn">
            Check Status
        </button>

    </form>

    <%
        List<Complaint> complaints =
            (List<Complaint>) request.getAttribute("complaints");

        if (complaints != null) {

            if (complaints.isEmpty()) {
    %>

        <p style="color:red; margin-top:20px;">
            No complaints found for this roll number.
        </p>

    <%
            } else {
    %>

        <table>

            <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Description</th>
                <th>Status</th>
            </tr>

    <%
                for (Complaint c : complaints) {
    %>

            <tr>

                <td><%= c.getId() %></td>

                <td><%= c.getCategory() %></td>

                <td><%= c.getDescription() %></td>

                <td><b><%= c.getStatus() %></b></td>

            </tr>

    <%
                }
    %>

        </table>

    <%
            }
        }
    %>

    <br>

    <a href="index.html" class="btn">
        Back to Home
    </a>

</div>

</body>

</html>