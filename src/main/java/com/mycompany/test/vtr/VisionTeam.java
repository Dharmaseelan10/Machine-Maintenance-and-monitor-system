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

@WebServlet("/VisionTeam")
public class VisionTeam extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(VisionTeam.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        System.out.println("VisionTeam servlet accessed");
        Connection connection = null;
        ResultSet resultSet = null;

      try {
    connection = DBConnection.getConnection();
    if (connection == null) {
        LOGGER.log(Level.SEVERE, "Failed to establish database connection.");
        out.println("Error: Unable to connect to the database.");
        return;
    }

    String query = "SELECT name FROM visionmember";
    PreparedStatement statement = connection.prepareStatement(query);
    resultSet = statement.executeQuery();

    // Create a StringBuilder to hold the JSON array
    StringBuilder jsonResponse = new StringBuilder();
    jsonResponse.append("[");

    boolean first = true;
    while (resultSet.next()) {
        if (!first) {
            jsonResponse.append(",");
        }
        String name = resultSet.getString("name");
        jsonResponse.append("\"").append(name).append("\"");
        
        // Print the name retrieved from the database
        System.out.println("Retrieved attendee: " + name);
        
        first = false;
    }
    jsonResponse.append("]");

    // Log the retrieved data
    LOGGER.log(Level.INFO, "Retrieved attendees: {0}", jsonResponse.toString());

    // Write the JSON response
    out.print(jsonResponse.toString());
} catch (SQLException e) {
    LOGGER.log(Level.SEVERE, "SQL error: {0}", e.getMessage());
    out.println("Error retrieving attendees: " + e.getMessage());
} catch (NamingException ex) {
    LOGGER.log(Level.SEVERE, "Naming exception: {0}", ex.getMessage());
} finally {
    if (resultSet != null) {
        try {
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (connection != null) {
        DBConnection.closeConnection(connection);
    }
}
    }
}