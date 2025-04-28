package com.mycompany.test.vtr;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author MME11538
 */
@WebServlet("/DeleteVisionMemberServlet")
public class DeleteVisionMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            String query = "DELETE FROM visionmember WHERE ID = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, id);
            statement.executeUpdate();
            response.sendRedirect("ManageVisionMembers.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting member: " + e.getMessage());
        } catch (NamingException ex) {
            Logger.getLogger(DeleteVisionMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null) {
                DBConnection.closeConnection(connection);
            }
        }
    }
}