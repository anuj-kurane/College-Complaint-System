<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.collegecomplaint.model.Complaint" %>

<!DOCTYPE html>
<html>

<head>
    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>
        .stats {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 15px;
            margin: 25px 0;
        }

        .stat-card {
            padding: 22px 12px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 3px 10px #d5dce5;
        }

        .stat-card h3 {
            font-size: 16px;
            margin-bottom: 12px;
        }

        .stat-card p {
            font-size: 32px;
            font-weight: bold;
            margin: 0;
        }

        .total {
            background: #e8f0fe;
            color: #174ea6;
        }

        .pending {
            background: #fff3cd;
            color: #946200;
        }

        .progress {
            background: #dcecff;
            color: #174ea6;
        }

        .resolved {
            background: #ddf5e5;
            color: #187443;
        }

        .dashboard {
            width: 95%;
            max-width: 1200px;
        }

        .filter-bar {
            margin: 20px 0;
            text-align: left;
        }

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

        td select {
            padding: 8px;
            max-width: 150px;
        }

        .update-form {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }

        .update-btn {
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        @media (max-width: 700px) {
            .stats {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }
    </style>
</head>

<body>

<header>
    <h1>Admin Dashboard</h1>
    <p>College Complaint Management System</p>
</header>

<div class="container dashboard">

    <div class="stats">

        <div class="stat-card total">
            <h3>Total Complaints</h3>
            <p><%= request.getAttribute("total") %></p>
        </div>

        <div class="stat-card pending">
            <h3>Pending</h3>
            <p><%= request.getAttribute("pending") %></p>
        </div>

        <div class="stat-card progress">
            <h3>In Progress</h3>
            <p><%= request.getAttribute("inProgress") %></p>
        </div>

        <div class="stat-card resolved">
            <h3>Resolved</h3>
            <p><%= request.getAttribute("resolved") %></p>
        </div>

    </div>

    <h2>All Complaints</h2>

    <div class="filter-bar">
        <label for="statusFilter">Filter by Status:</label>

        <select id="statusFilter" onchange="filterComplaints()">
            <option value="">All Statuses</option>
            <option value="Pending">Pending</option>
            <option value="In Progress">In Progress</option>
            
        </select>
    </div>

    <p>
        Welcome, <b><%= session.getAttribute("admin") %></b>
    </p>

    <a href="<%= request.getContextPath() %>/logout"
       class="btn admin-btn">
        Logout
    </a>

    <div class="table-wrapper">

        <table id="complaintTable">

            <tr>
                <th>ID</th>
                <th>Student Name</th>
                <th>Roll No</th>
                <th>Category</th>
                <th>Description</th>
                <th>Status / Update</th>
            </tr>

            <%
                List<Complaint> complaints =
                    (List<Complaint>) request.getAttribute("complaints");

                if (complaints != null && !complaints.isEmpty()) {

                    for (Complaint c : complaints) {
                        String currentStatus = c.getStatus() == null
                                ? "Pending" : c.getStatus();
            %>

            <tr class="complaint-row"
                data-status="<%= currentStatus %>">

                <td><%= c.getId() %></td>

                <td><%= c.getStudentName() %></td>

                <td><%= c.getRollNo() %></td>

                <td><%= c.getCategory() %></td>

                <td><%= c.getDescription() %></td>

                <td>
                    <form action="<%= request.getContextPath() %>/updateStatus"
                          method="post"
                          class="update-form">

                        <input type="hidden"
                               name="id"
                               value="<%= c.getId() %>">

                        <select name="status" required>
                            <option value="Pending"
                                <%= "Pending".equals(currentStatus)
                                    ? "selected" : "" %>>
                                Pending
                            </option>

                            <option value="In Progress"
                                <%= "In Progress".equals(currentStatus)
                                    ? "selected" : "" %>>
                                In Progress
                            </option>

                            <option value="Resolved"
                                <%= "Resolved".equals(currentStatus)
                                    ? "selected" : "" %>>
                                Resolved
                            </option>
                        </select>

                        <button type="submit"
                                class="btn update-btn">
                            Update
                        </button>

                    </form>
                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>
                <td colspan="6">No active complaints. All complaints are resolved!</td>
            </tr>

            <%
                }
            %>

        </table>

    </div>

    <p id="noMatchingComplaints"
       style="display:none; text-align:center; margin-top:15px;">
        No complaints match the selected status.
    </p>

</div>

<script>
function filterComplaints() {

    var status = document.getElementById("statusFilter").value;
    var rows = document.querySelectorAll(".complaint-row");
    var visible = 0;

    rows.forEach(function(row) {

        var currentStatus = row.getAttribute("data-status");

        if (status === "" || currentStatus === status) {
            row.style.display = "";
            visible++;
        } else {
            row.style.display = "none";
        }
    });

    var message = document.getElementById("noMatchingComplaints");

    message.style.display =
        rows.length > 0 && visible === 0 ? "block" : "none";
}
</script>

</body>
</html>	