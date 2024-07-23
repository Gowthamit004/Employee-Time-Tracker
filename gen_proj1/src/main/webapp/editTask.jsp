<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
</head>
<body>
    <h2>Edit Task</h2>
    <%
        int taskId = Integer.parseInt(request.getParameter("id"));
        String projectId = "", date = "", timeDuration = "", taskCategory = "", description = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeetimetracker", "root", "mypass");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE id = ?;");
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                projectId = rs.getString("projectId");
                date = rs.getString("date");
                timeDuration = rs.getString("timeDuration");
                taskCategory = rs.getString("taskCategory");
                description = rs.getString("description");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <form action="tasks?action=edit" method="post">
        <input type="hidden" id="id" name="id" value="<%= taskId %>">
        
        <label for="projectId">Project ID:</label>
        <input type="text" id="projectId" name="projectId" value="<%= projectId %>" required><br><br>
        
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="<%= date %>" required><br><br>
        
        <label for="timeDuration">Time Duration:</label>
        <input type="text" id="timeDuration" name="timeDuration" value="<%= timeDuration %>" required><br><br>
        
        <label for="taskCategory">Task Category:</label>
        <input type="text" id="taskCategory" name="taskCategory" value="<%= taskCategory %>" required><br><br>
        
        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description %></textarea><br><br>
        
        <input type="submit" value="Update Task">
    </form>
    <form action="tasks?action=delete" method="post">
		<input type="hidden" id="id" name="id" value="<%= taskId %>">
    	<input type="submit" value="Delete Task">
    </form>
      <a href='dashboard.jsp'>Back</a>
</body>
</html>
