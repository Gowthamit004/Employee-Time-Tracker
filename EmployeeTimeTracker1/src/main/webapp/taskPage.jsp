<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get the session
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    // Retrieve username from the session
    String username = (String) session.getAttribute("username");
    int userId = 0;
    String dbUrl = "jdbc:mysql://localhost:3306/EmployeeTaskTracker";
    String dbUser = "root";
    String dbPass = "mypass";

    // Query to get user_id from username
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT user_id FROM Users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            userId = rs.getInt("user_id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        h2 {
            color: #00698f;
        }
        form {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="date"], input[type="time"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #3e8e41;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f0f0f0;
        }
        a {
            text-decoration: none;
            color: #337ab7;
        }
        a:hover {
            color: #23527c;
        }
    </style>
</head>
<body>
    <h2><center>Task Management for <%= username %></center></h2>
    <form action="TaskServlet" method="get">
        <input type="hidden" name="userId" value="<%= userId %>">
        <label for="project">Project:</label>
        <input type="text" id="project" name="project"><br><br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date"><br><br>
        <label for="startTime">Start Time:</label>
        <input type="time" id="startTime" name="startTime"><br><br>
        <label for="endTime">End Time:</label>
        <input type="time" id="endTime" name="endTime"><br><br>
        <label for="category">Category:</label>
        <input type="text" id="category" name="category"><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description"></textarea><br><br>
        <input type="submit" value="Add Task">
    </form>
    <h3>Your Tasks</h3>
    <table border="1">
        <tr>
            <th>Project</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Category</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks WHERE employee_id=?");
                               ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("project") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getTime("start_time") %></td>
            <td><%= rs.getTime("end_time") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("description") %></td>
            <td>
                <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>">Edit</a>
                <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>">Delete</a>
            </td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>