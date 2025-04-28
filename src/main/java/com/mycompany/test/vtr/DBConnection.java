package com.mycompany.test.vtr;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class DBConnection {
    private static final String DATASOURCE_NAME = "jdbc/vtrDB";

    public static Connection getConnection() throws SQLException, NamingException {
        // Get the data source from the context
        DataSource dataSource = (DataSource) new InitialContext().lookup("java:comp/env/" + DATASOURCE_NAME);

        // Get a connection from the data source
        Connection connection = dataSource.getConnection();

        return connection;
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.err.println("Database connection closed ");
            } catch (SQLException e) {
                // Handle database exceptions here
                System.err.println("Error closing database connection: " + e.getMessage());
            }
        }
    }
}