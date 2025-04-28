<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.test.vtr.DBConnection" %>

<%
    String message = "";
    String employeeId = request.getParameter("id");
    String product = "";
    String productSeries = "";
    String machine = "";
    String machineNo = "";
    String troubleDetails = "";
    String problem = "";
    String remarks = "";

    Connection connection = null;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        product = request.getParameter("product");
        productSeries = request.getParameter("productSeries");
        machine = request.getParameter("machine");
        machineNo = request.getParameter("machineNo");
        troubleDetails = request.getParameter("troubleDetails");
        problem = request.getParameter("problem");
        remarks = request.getParameter("remarks");

        try {
            connection = DBConnection.getConnection();
            String query = "UPDATE VTR_LIST SET PRODUCT = ?, PRODUCT_SERIES = ?, MACHINE = ?, MACHINE_NO = ?, TROUBLE_DETAILS = ?, PROBLEM= ?, REMARKS = ? WHERE EMPLOYEE_ID = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, product);
            statement.setString(2, productSeries);
            statement.setString(3, machine);
            statement.setString(4, machineNo);
            statement.setString(5, troubleDetails);
            statement.setString(6, problem);
            statement.setString(7, remarks);
            statement.setString(8, employeeId);
            statement.executeUpdate();
            message = "Entry updated successfully!";
        } catch (SQLException e) {
            message = "Error updating entry: " + e.getMessage();
        } finally {
            if (connection != null) {
                DBConnection.closeConnection(connection);
            }
        }
    } else {
        try {
            connection = DBConnection.getConnection();
            String query = "SELECT * FROM VTR_LIST WHERE EMPLOYEE_ID = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, employeeId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                product = resultSet.getString("PRODUCT");
                productSeries = resultSet.getString("PRODUCT_SERIES");
                machine = resultSet.getString("MACHINE");
                machineNo = resultSet.getString("MACHINE_NO");
                troubleDetails = resultSet.getString("TROUBLE_DETAILS");
                problem = resultSet.getString("PROBLEM");
                remarks = resultSet.getString("REMARKS");
            }
        } catch (SQLException e) {
            message = "Error retrieving entry: " + e.getMessage();
        } finally {
            if (connection != null) {
                DBConnection.closeConnection(connection);
            }
        }
    }
%>

<html>
<head>
    <title>Edit Entry</title>
    <link href="css/all.min.css" rel="stylesheet"/>
    <link href="css/tailwindcss.css" rel="stylesheet"/>
    <script src="css/tailwindcss.5"></script>
    <style>
        /* Add any additional custom styles here */
    </style>
    <script>
        function closeMessage(messageId) {
            document.getElementById(messageId).style.display = "none";
        }
    </script>
</head>
<body class="bg-gray-100">
    <div id="notification-container">
        <%-- Success Message --%>
        <% if (session.getAttribute("successMessage") != null) { %>
            <div id="successMessage" class="text-white relative p-2" 
                 style="position: fixed; top: 0; left: 0; width: 100%; z-index: 1; background-color: rgba(52, 199, 89, 0.8);">
                <span class="absolute top-2 right-2 cursor-pointer" onclick="closeMessage('successMessage')">
                    &times; <%-- Simple 'X' for close --%>
                </span>
                <%= session.getAttribute("successMessage") %>
            </div>
            <% session.removeAttribute("successMessage"); // Remove after displaying %>
        <% } %>

        <%-- Error Message --%>
        <% if (session.getAttribute("errorMessage") != null) { %>
            <div id="errorMessage" class="bg-red-500 text-white relative p-2" 
                 style="position: fixed; top: 0; left: 0; width: 100%; z-index: 1;">
                <span class="absolute top-2 right-2 cursor-pointer" onclick="closeMessage('errorMessage')">
                    &times;
                </span>
                <%= session.getAttribute("errorMessage") %>
            </div>
            <% session.removeAttribute("errorMessage"); // Remove after displaying %> 
        <% } %>
    </div>

    <div class="flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        <!-- Main Content -->
        <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold">Edit Entry</h2>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <form class="p-4" method="post">
                    <div class="mb-4">
                        <label class="block text-gray-700">Product:</label>
                        <input class="w-full p-2 border rounded" type="text" name="product" value="<%= product %>" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Product Series:</label>
                        <input class="w-full p-2 border rounded" type="text" name="productSeries" value="<%= productSeries %>" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Machine:</label>
                        <input class="w-full p-2 border rounded" type="text" name="machine" value="<%= machine %>" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Machine No:</label>
                        <input class="w-full p-2 border rounded" type="text" name="machineNo" value="<%= machineNo %>" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Trouble Details:</label>
                        <textarea class="w-full p-2 border rounded" name="troubleDetails" required><%= troubleDetails %></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Problem:</label>
                        <textarea class="w-full p-2 border rounded" name="problem" required><%= problem %></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700">Remarks:</label>
                        <textarea class="w-full p-2 border rounded" name="remarks" required><%= remarks %></textarea>
                    </div>
                    <button class="bg-blue-500 text-white p-2 rounded" type="submit">Update Entry</button> <a href="Maintenance.jsp" class="bg-blue-500 text-white p-2 rounded">Back to Maintenance</a>
                </form>
                <p class="text-red-500"><%= message %></p>
                
            </div>
        </div>
    </div>
    <footer class="mt-10 text-center text-gray-500 text-sm">
        Murata Electronics (M) Sdn. Bhd. 2025 All rights reserved. V2.02-2025 <br/>
    </footer>
</body>
</html>