package com.mycompany.test.vtr;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet("/AddVisionMemberServlet")
public class AddVisionMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email"); // Retrieve the email parameter
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            String query = "INSERT INTO visionmember (name, email) VALUES (?, ?)"; // Update query to include email
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.setString(2, email); // Set the email parameter
            statement.executeUpdate();
            response.sendRedirect("ManageVisionMembers.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error adding member: " + e.getMessage());
        } catch (NamingException ex) {
            Logger.getLogger(AddVisionMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null) {
                DBConnection.closeConnection(connection);
            }
        }
    }
}