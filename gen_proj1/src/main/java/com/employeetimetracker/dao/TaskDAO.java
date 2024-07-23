package com.employeetimetracker.dao;

import com.employeetimetracker.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    // Add a new task to the database
    public void addTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (employeeId, projectId, date, timeDuration, taskCategory, description) VALUES (?, ?, ?, ?, ?, ?)	";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, task.getEmployeeId());
            stmt.setInt(2, task.getProjectId());
            stmt.setDate(3, new java.sql.Date(task.getDate().getTime()));
            stmt.setString(4, task.getTimeDuration());
            stmt.setString(5, task.getTaskCategory());
            stmt.setString(6, task.getDescription());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("SQL exception in addTask: " + e.getMessage());
            throw e;
        }
    }

    // Update an existing task in the database
    public void updateTask(Task task) throws SQLException {
        String sql = "UPDATE tasks SET projectId = ?, date = ?, timeDuration = ?, taskCategory = ?, description = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, task.getProjectId());
            stmt.setDate(2, new java.sql.Date(task.getDate().getTime()));
            stmt.setString(3, task.getTimeDuration());
            stmt.setString(4, task.getTaskCategory());
            stmt.setString(5, task.getDescription());
            stmt.setInt(6, task.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("SQL exception in updateTask: " + e.getMessage());
            throw e;
        }
    }

    // Delete a task from the database
    public void deleteTask(int taskId) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id = ?";
        try {
        	Connection conn = DatabaseUtil.getConnection(); 
        	PreparedStatement stmt = conn.prepareStatement("DELETE FROM tasks WHERE id = ?");
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("SQL exception in deleteTask: " + e.getMessage());
            throw e;
        }
    }

    // Retrieve tasks assigned to a specific employee
    public List<Task> getTasksByEmployee(int employeeId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE employeeId = ?";
        List<Task> tasks = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, employeeId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setEmployeeId(rs.getInt("employeeId"));
                task.setProjectId(rs.getInt("projectId"));
                task.setDate(rs.getDate("date"));
                task.setTimeDuration(rs.getString("timeDuration"));
                task.setTaskCategory(rs.getString("taskCategory"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            System.err.println("SQL exception in getTasksByEmployee: " + e.getMessage());
            throw e;
        }
        return tasks;
    }
}
