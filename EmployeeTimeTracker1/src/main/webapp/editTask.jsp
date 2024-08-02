<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve task ResultSet from request attributes
    ResultSet task = (ResultSet) request.getAttribute("task");

    // Check if task ResultSet is not null
    if (task != null) {
        task.next(); // Move to the first row (if necessary)
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-top: 0;
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a {
            text-decoration: none;
            color: #4CAF50;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Task</h2>
        <form action="EditTaskServlet" method="post">
            <input type="hidden" name="taskId" value="<%= task.getInt("task_id") %>">
            
            <label for="project">Project:</label>
            <input type="text" id="project" name="project" value="<%= task.getString("project") %>" required>
            
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" value="<%= task.getDate("date") != null ? task.getDate("date").toLocalDate() : "" %>" required>
            
            <label for="startTime">Start Time:</label>
            <input type="time" id="startTime" name="startTime" value="<%= task.getTime("start_time") != null ? task.getTime("start_time").toLocalTime() : "" %>" required>
            
            <label for="endTime">End Time:</label>
            <input type="time" id="endTime" name="endTime" value="<%= task.getTime("end_time") != null ? task.getTime("end_time").toLocalTime() : "" %>" required>
            
            <label for="category">Category:</label>
            <input type="text" id="category" name="category" value="<%= task.getString("category") %>" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required><%= task.getString("description") %></textarea>
            
            <input type="submit" value="Update Task">
        </form>
        <a href="taskPage.jsp">Back to Task Management</a>
    </div>
</body>
</html>
<%
    } else {
        out.println("Task not found.");
    }
%>
