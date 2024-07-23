package com.employeetimetracker.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@WebServlet("/tasks")
public class TaskServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private TaskDAO taskDAO;

    public void init() {
        taskDAO = new TaskDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addTask(request, response);
                    break;
                case "edit":
                    editTask(request, response);
                    break;
                case "delete":
                    deleteTask(request, response);
                    break;
                default:
                    response.sendRedirect("viewTasks.jsp");
                    break;
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String dateStr = request.getParameter("date");
        Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        String timeDuration = request.getParameter("timeDuration");
        String taskCategory = request.getParameter("taskCategory");
        String description = request.getParameter("description");

        Task task = new Task();
        task.setEmployeeId(user.getId());
        task.setProjectId(projectId);
        task.setDate(date);
        task.setTimeDuration(timeDuration);
        task.setTaskCategory(taskCategory);
        task.setDescription(description);

        taskDAO.addTask(task);
        response.sendRedirect("dashboard.jsp");
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String dateStr = request.getParameter("date");
        Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        String timeDuration = request.getParameter("timeDuration");
        String taskCategory = request.getParameter("taskCategory");
        String description = request.getParameter("description");

        Task task = new Task();
        task.setId(taskId);
        task.setProjectId(projectId);
        task.setDate(date);
        task.setTimeDuration(timeDuration);
        task.setTaskCategory(taskCategory);
        task.setDescription(description);

        taskDAO.updateTask(task);
        response.sendRedirect("viewTasks.jsp");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
    	int taskId = Integer.parseInt(request.getParameter("id"));
        taskDAO.deleteTask(taskId);
        response.sendRedirect("viewTasks.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null) {
            response.sendRedirect("login.jsp?error=You must log in first");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp?error=You must log in first");
            return;
        }

        try {
            List<Task> tasks = taskDAO.getTasksByEmployee(user.getId());
            request.setAttribute("tasks", tasks);
            request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
