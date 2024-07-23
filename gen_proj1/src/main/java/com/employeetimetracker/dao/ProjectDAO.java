package com.employeetimetracker.dao;

import com.employeetimetracker.model.Project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    // Add a new project to the database
    public void addProject(Project project) throws SQLException {
        String sql = "INSERT INTO projects (name, description) VALUES (?, ?)";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("SQL exception in addProject: " + e.getMessage());
            throw e;
        }
    }

    // Retrieve all projects from the database
    public List<Project> getAllProjects() throws SQLException {
        String sql = "SELECT * FROM projects";
        List<Project> projects = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setName(rs.getString("name"));
                project.setDescription(rs.getString("description"));
                projects.add(project);
            }
        } catch (SQLException e) {
            System.err.println("SQL exception in getAllProjects: " + e.getMessage());
            throw e;
        }
        return projects;
    }
}
