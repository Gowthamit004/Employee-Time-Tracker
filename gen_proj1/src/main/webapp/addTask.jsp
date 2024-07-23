<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
</head>
<body>
    <h2>Add Task</h2>
    <form action="tasks?action=add" method="post">
        <label for="projectId">Project ID:</label>
        <input type="text" id="projectId" name="projectId" required><br><br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br><br>
        <label for="timeDuration">Time Duration:</label>
        <input type="text" id="timeDuration" name="timeDuration" required><br><br>
        <label for="taskCategory">Task Category:</label>
        <input type="text" id="taskCategory" name="taskCategory" required><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br><br>
        <input type="submit" value="Add Task">
    </form>
      <a href='dashboard.jsp'>Back</a>
</body>
</html>
