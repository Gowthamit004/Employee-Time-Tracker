<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
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
            padding: 30px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            width: 90%;
            max-width: 600px;
            text-align: center;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }
        a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #4CAF50;
            font-size: 18px;
            margin-bottom: 10px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #4CAF50;
            color: white;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("username") %></h2>
        <%
            if ("Admin".equals(role)) {
        %>
        <a href="viewAllTasks.jsp">View All Tasks</a>
        <a href="viewAllCharts.jsp">View All Charts</a>
        <a href="register.jsp">Registration</a>
        <%
            } else {
        %>
        <a href="taskPage.jsp">Task Management</a>
        <a href="associaterPage.jsp">View Associater</a>
        <%
            }
        %>
        <a href="LogoutServlet" class="button">Logout</a>
    </div>
</body>
</html>
<%
    }
%>
