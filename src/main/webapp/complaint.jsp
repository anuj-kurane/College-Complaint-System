
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header>
    <h1>Submit a Complaint</h1>
    <p>Tell us about the issue you are facing.</p>
</header>

<div class="container">
    <h2>Complaint Form</h2>
    
<% if ("1".equals(request.getParameter("success"))) { %>
    <p style="color: green; font-weight: bold;">
        Complaint submitted successfully!
    </p>
<% } %>

    <form action="submitComplaint" method="post">

        <label>Student Name</label>
        <input type="text" name="student_name" required>

        <label>Roll Number</label>
        <input type="text" name="roll_no" required>

        <label>Complaint Category</label>
        <select name="category" required>
            <option value="">Select Category</option>
            <option value="Classroom">Classroom</option>
            <option value="Computer Lab">Computer Lab</option>
            <option value="Cleanliness">Cleanliness</option>
            <option value="Faculty">Faculty</option>
            <option value="Library">Library</option>
            <option value="Other">Other</option>
        </select>

        <label>Complaint Description</label>
        <textarea name="description" required></textarea>

        <button type="submit" class="btn">Submit Complaint</button>
        <a href="index.html" class="btn admin-btn">Back Home</a>

    </form>
</div>

</body>
</html>		