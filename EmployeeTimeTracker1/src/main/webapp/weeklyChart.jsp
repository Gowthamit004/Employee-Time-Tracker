<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weekly Tasks/Hours Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            max-width: 800px;
            box-sizing: border-box;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        canvas {
            display: block;
            margin: 0 auto;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Weekly Tasks/Hours Bar Chart for <%= username %></h2>
        <canvas id="weeklyChart" width="400" height="400"></canvas>
        <script>
            fetch('WeeklyChartServlet')
                .then(response => response.json())
                .then(data => {
                    const ctx = document.getElementById('weeklyChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: 'Tasks/Hours',
                                data: data.data,
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                })
                .catch(error => console.error('Error fetching chart data:', error));
        </script>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
