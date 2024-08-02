<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Tasks</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }
        .container {
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            width: 90%;
            max-width: 1000px;
            box-sizing: border-box;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        a {
            display: inline-block;
            padding: 8px 12px;
            color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
            border: 1px solid #4CAF50;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #4CAF50;
            color: white;
        }
        .button-container {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Tasks for <%= username %></h2>
        <table>
            <thead>
                <tr>
                    <th>Project</th>
                    <th>Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks");
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
            </tbody>
        </table>
        <div class="button-container">
            <a href="dashboard.jsp" class="button">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
