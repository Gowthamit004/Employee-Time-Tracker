package com.employeetimetracker.dao;

import com.employeetimetracker.model.Role;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    // Retrieve all roles from the database
    public List<Role> getAllRoles() throws SQLException {
        String sql = "SELECT * FROM roles";
        List<Role> roles = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setRoleName(rs.getString("roleName"));
                roles.add(role);
            }
        } catch (SQLException e) {
            System.err.println("SQL exception in getAllRoles: " + e.getMessage());
            throw e;
        }
        return roles;
    }
}
