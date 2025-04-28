package com.mycompany.test.vtr;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateStatusServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(UpdateStatusServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        String attend = request.getParameter("attend");
        String problem = request.getParameter("problem");
        String remarks = request.getParameter("remarks");

        if (id == null || status == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().println("Missing required parameters");
            return;
        }

        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            if ("Solved".equalsIgnoreCase(status)) {

                // Update the STATUS, PROBLEM, REMARKS, and SOLVED_AT columns
                try (PreparedStatement updateStmt = connection.prepareStatement(
                        "UPDATE vtr_list SET STATUS = ?, PROBLEM = ?, REMARKS = ?, SOLVED_AT = ? WHERE ID = ?")) {
                    updateStmt.setString(1, status);
                    updateStmt.setString(2, problem);
                    updateStmt.setString(3, remarks);
                    updateStmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                    updateStmt.setString(5, id);
                    updateStmt.executeUpdate();
                }
            } else if ("In Progress".equalsIgnoreCase(status)) {
                // Update the STATUS, ATTEND_BY, and ACCEPTED_AT columns
                try (PreparedStatement updateStmt = connection.prepareStatement(
                        "UPDATE vtr_list SET STATUS = ?, ATTEND_BY = ?, ACCEPTED_AT = ? WHERE ID = ?")) {
                    updateStmt.setString(1, status);
                    updateStmt.setString(2, attend);
                    updateStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                    updateStmt.setString(4, id);
                    updateStmt.executeUpdate();
                }
            }

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating status", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Error updating status: " + e.getMessage());
        } catch (NamingException ex) {
            Logger.getLogger(UpdateStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DBConnection.closeConnection(connection);
        }
    }

    
}