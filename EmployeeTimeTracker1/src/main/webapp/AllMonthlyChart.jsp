<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Tasks/Hours Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 900px;
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
        canvas {
            display: block;
            margin: 0 auto;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Monthly Tasks/Hours Bar Chart</h2>
        <canvas id="ALLMonthlyChart" width="600" height="400"></canvas>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
    <script>
        fetch('AllMonthlyChartServlet')
        .then(response => response.json())
        .then(data => {
            console.log("Data received from servlet:", data); // Debugging log

            const ctx = document.getElementById('ALLMonthlyChart').getContext('2d');

            const labels = new Set();
            const datasetMap = {};

            // Process userTasks to get labels and datasetMap
            for (const [username, userData] of Object.entries(data.userTasks)) {
                datasetMap[username] = [];
                userData.labels.forEach((day, index) => {
                    labels.add(day);
                    datasetMap[username].push({
                        x: day,
                        y: userData.data[index]
                    });
                });
            }

            // Convert labels Set to an array and sort it
            const sortedLabels = Array.from(labels).sort();

            // Prepare datasets
            const datasets = Object.keys(datasetMap).map(username => ({
                label: username,
                data: sortedLabels.map(day => {
                    const entry = datasetMap[username].find(point => point.x === day);
                    return entry ? entry.y : 0; // Handle missing data points
                }),
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }));

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: sortedLabels,
                    datasets: datasets
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Monthly Tasks/Hours'
                        }
                    },
                    scales: {
                        x: {
                            type: 'category',
                            title: {
                                display: true,
                                text: 'Date'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Hours'
                            }
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error("Error fetching data:", error); // Debugging log
        });
    </script>
</body>
</html>
<%
    }
%>
