<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report</title>
</head>
<body>
    <h2>Report</h2>
    <div id="reportContainer">
        <!-- Placeholder for charts and report data -->
        <h3>Task Summary</h3>
        <table border="1z">
            <tr>
                <th>Date</th>
                <th>Project</th>
                <th>Task Category</th>
                <th>Time Duration</th>
            </tr>
            <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeetimetracker", "root", "mypass");
                PreparedStatement ps = con.prepareStatement("SELECT distinct(employeeid) FROM tasks ;");
                ResultSet rs = ps.executeQuery(); 		
                while (rs.next()) {
					out.println("<tr>");
					out.println("<td>" + rs.getInt("id") + "</td>");
					out.println("<td>" + rs.getInt("projectId") + "</td>");
					out.println("<td>" + rs.getDate("date") + "</td>");
					out.println("<td>" + rs.getString("timeDuration") + "</td>");
					out.println("<td>" + rs.getString("taskCategory") + "</td>");
					out.println("<td>" + rs.getString("description") + "</td>");
					out.println("<td><a href='edit?id=" + rs.getInt("id") + "'>Edit</a> | <a href='delete?id=" + rs.getInt("id") + "'>Delete</a></td>");
					out.println("</tr>");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </table>
    </div>
      <a href='dashboard.jsp'>Back</a>
</body>
</html>
