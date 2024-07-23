<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks</title>
</head>
<body>
    <h2>View Tasks</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Project ID</th>
            <th>Date</th>
            <th>Time Duration</th>
            <th>Task Category</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeetimetracker", "root", "mypass");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks;");
                ResultSet rs = ps.executeQuery(); 	

                while (rs.next()) {
					out.println("<tr>");
					out.println("<td>" + rs.getInt("id") + "</td>");
					out.println("<td>" + rs.getInt("projectId") + "</td>");
					out.println("<td>" + rs.getDate("date") + "</td>");
					out.println("<td>" + rs.getString("timeDuration") + "</td>");
					out.println("<td>" + rs.getString("taskCategory") + "</td>");
					out.println("<td>" + rs.getString("description") + "</td>");
					out.println("<td>"
						    + "<a href='editTask.jsp?id=" + rs.getInt("id") + "'>Modify</a>"+ "</td>");
					out.println("</tr>");
					
                }
                con.close();
                
                

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
    <br/>
  <a href='dashboard.jsp'>Back</a>
</body>
</html>
