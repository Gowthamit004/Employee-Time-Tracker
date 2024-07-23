package com.employeetimetracker.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.employeetimetracker.dao.RoleDAO;
import com.employeetimetracker.model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/roles")
public class RoleServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private RoleDAO roleDAO;

    public void init() {
        roleDAO = new RoleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Role> roles = roleDAO.getAllRoles();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("roles.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
