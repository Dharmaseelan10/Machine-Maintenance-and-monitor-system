<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.test.vtr.DBConnection" %>

<%
    String message = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String employeeId = request.getParameter("employeeId");
        String product = request.getParameter("product");
        String productSeries = request.getParameter("productSeries");
        String machine = request.getParameter("machine");
        String machineNo = request.getParameter("machineNo");
        String troubleDetails = request.getParameter("troubleDetails");
        String status = "Waiting"; // Default status

        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            String query = "INSERT INTO VTR_LIST (EMPLOYEE_ID, PRODUCT, PRODUCT_SERIES, MACHINE, MACHINE_NO, TROUBLE_DETAILS, STATUS) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, employeeId);
            statement.setString(2, product);
            statement.setString(3, productSeries);
            statement.setString(4, machine);
            statement.setString(5, machineNo);
            statement.setString(6, troubleDetails);
            statement.setString(7, status);
            statement.executeUpdate();
            message = "Entry added successfully!";
        } catch (SQLException e) {
            message = "Error adding entry: " + e.getMessage();
        } finally {
            if (connection != null) {
                DBConnection.closeConnection(connection);
            }
        }
    }
%>

<html>
<head>
    <title>Add Entry</title>
</head>
<body>
    <h2>Add New Entry</h2>
    <form method="post">
        <label>Employee ID:</label>
        <input type="text" name="employeeId" required><br>
        <label>Product:</label>
        <input type="text" name="product" required><br>
        <label>Product Series:</label>
        <input type="text" name="productSeries" required><br>
        <label>Machine:</label>
        <input type="text" name="machine" required><br>
        <label>Machine No:</label>
        <input type="text" name="machineNo" required><br>
        <label>Trouble Details:</label>
        <textarea name="troubleDetails" required></textarea><br>
        <button type="submit">Add Entry</button>
    </form>
    <p><%= message %></p>
    <a href="Maintenance.jsp">Back to Maintenance</a>
</body>
</html>