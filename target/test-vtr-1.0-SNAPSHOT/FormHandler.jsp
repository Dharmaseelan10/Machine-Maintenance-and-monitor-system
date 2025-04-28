<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mycompany.test.vtr.EmailUtil" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    // Retrieve parameters from the request
String employeeId = request.getParameter("employeeId");
String product = request.getParameter("product");
String productSeries = request.getParameter("productSeries");
String machine = request.getParameter("machine");
String machineNo = request.getParameter("machineNo");
String trouble = request.getParameter("trouble");
String otherTrouble = request.getParameter("otherTrouble");

// Input validation
if (employeeId == null || product == null || productSeries == null || machine == null || machineNo == null || trouble == null) {
    session.setAttribute("errorMessage", "All fields are required.");
    response.sendRedirect("Form.jsp");
    return;
}

// Validate and format employee ID
if (employeeId.matches("^\\d{5}$")) {
    employeeId = "ME" + employeeId;
}

    Connection connection = null;
    try {
        connection = DBConnection.getConnection();

        // Check the status of the machine
        String statusQuery = "SELECT STATUS FROM VTR_LIST WHERE MACHINE = ? AND MACHINE_NO = ?";
        PreparedStatement statusStatement = connection.prepareStatement(statusQuery);
        statusStatement.setString(1, machine);
        statusStatement.setString(2, machineNo);
        ResultSet resultSet = statusStatement.executeQuery();

        // Check if the machine is in "Waiting" or "In Progress" status
        boolean isRestricted = false;
        while (resultSet.next()) {
            String status = resultSet.getString("STATUS");
            if ("Waiting".equals(status) || "In Progress".equals(status)) {
                isRestricted = true;
                break;
            }
        }

        // If the machine is restricted, redirect with an error message
        if (isRestricted) {
            session.setAttribute("errorMessage", "Cannot submit request: The machine is currently in troubleshooting status");
            response.sendRedirect("Form.jsp");
            return;
        }

        // Get the current timestamp
        java.sql.Timestamp timestamp = new java.sql.Timestamp(new Date().getTime());

        // Proceed with the insertion if the status is not restricted
        String query = "INSERT INTO VTR_LIST (EMPLOYEE_ID, PRODUCT, PRODUCT_SERIES, MACHINE, MACHINE_NO, TROUBLE_DETAILS, STATUS, CREATED_AT) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, employeeId);
        statement.setString(2, product);
        statement.setString(3, productSeries);
        statement.setString(4, machine);
        statement.setString(5, machineNo);
        statement.setString(6, "Other".equals(trouble) ? otherTrouble : trouble);
        statement.setString(7, "Waiting");
        statement.setTimestamp(8, timestamp); // Use setTimestamp for the timestamp

        statement.executeUpdate();
        
        // Set success message in session attribute
        session.setAttribute("successMessage", "Your troubleshoot request has been successfully submitted! The Vision team will address your request shortly. Thank you for your cooperation.");

        // Retrieve email addresses from the visionmember table
        List<String> emailRecipients = new ArrayList<>();
        String emailQuery = "SELECT email FROM visionmember"; // Query to get emails
        PreparedStatement emailStatement = connection.prepareStatement(emailQuery);
        ResultSet emailResultSet = emailStatement.executeQuery();

        while (emailResultSet.next()) {
            String email = emailResultSet.getString("email");
            emailRecipients.add(email); // Add each email to the list
        }

        // Join email addresses into a single string
        String emailTo = String.join(",", emailRecipients);
        
      String emailSubject = "New Troubleshoot Request Submitted";
String emailBody = String.format("Dear Vision Team,\n\n" +
                       "A new troubleshoot request has been submitted with the following details:\n" +
                       "-------------------------------------------------------------------------------\n" +
                       "Employee ID: %s\n" +
                       "Product: %s\n" +
                       "Product Series: %s\n" +
                       "Machine: %s\n" +
                       "Machine No: %s\n" +
                       "Trouble Details: %s \n" +
                       "Status: Waiting\n" +
                       "Created At: %s\n" +
                       "-------------------------------------------------------------------------------\n" +
                       "You can access the dashboard for more details at the following link:\n" +
                       "https://mme-sv0041:8442/Vision_VTR/Summary.jsp\n\n" +
                       "Thank you for your prompt attention to this matter.\n\n", 
                       employeeId, product, productSeries, machine, machineNo, 
                       "Other".equals(trouble) ? otherTrouble : trouble, timestamp);

// Send email notification
EmailUtil.sendEmail(emailTo, emailSubject, emailBody);
        // Redirect to Form.jsp
        response.sendRedirect("Form.jsp");
        
    } catch (SQLException e) {
        // Handle SQL exceptions
        session.setAttribute("errorMessage", "Error submitting request: " + e.getMessage());
        response.sendRedirect("Form.jsp");
    } finally {
        if (connection != null) {
            DBConnection.closeConnection(connection);
        }
    }
%>