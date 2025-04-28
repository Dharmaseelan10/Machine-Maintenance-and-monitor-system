<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.test.vtr.DBConnection" %>

<%
    String message = "";
    String employeeId = request.getParameter("id");

    Connection connection = null;

    try {
        connection = DBConnection.getConnection();
        String query = "DELETE FROM VTR_LIST WHERE EMPLOYEE_ID = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, employeeId);
        statement.executeUpdate();
        message = "Entry deleted successfully!";
    } catch (SQLException e) {
        message = "Error deleting entry: " + e.getMessage();
    } finally {
        if (connection != null) {
            DBConnection.closeConnection(connection);
        }
    }
%>

<html>
<head>
    <title>Delete Entry</title>
</head>
<body>
    <h2>Delete Entry</h2>
    <p><%= message %></p>
    <a href="Maintenance.jsp">Back to Maintenance</a>
</body>
</html>