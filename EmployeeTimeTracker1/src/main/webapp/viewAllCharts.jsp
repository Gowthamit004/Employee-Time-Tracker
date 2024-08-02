<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Charts</title>
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
            max-width: 600px;
            text-align: center;
            box-sizing: border-box;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        li {
            margin-bottom: 10px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
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
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Charts Overview</h2>
        <ul>
            <li><a href="AllDailyChart.jsp">View Daily Chart</a></li>
            <li><a href="AllWeeklyChart.jsp">View Weekly Chart</a></li>
            <li><a href="AllMonthlyChart.jsp">View Monthly Chart</a></li>
        </ul>
        <div class="button-container">
            <a href="dashboard.jsp" class="button">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
