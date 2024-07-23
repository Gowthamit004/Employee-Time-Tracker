package com.employeetimetracker.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.employeetimetracker.dao.TaskDAO;
import com.employeetimetracker.model.Task;
import com.employeetimetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private TaskDAO taskDAO;

    public void init() {
        taskDAO = new TaskDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            List<Task> tasks = taskDAO.getTasksByEmployee(user.getId());
            // Generate charts based on tasks
            // Example: request.setAttribute("dailyChart", generateDailyChart(tasks));
            request.setAttribute("tasks", tasks);
            request.getRequestDispatcher("report.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
    // private Chart generateDailyChart(List<Task> tasks) {
    // }
}
