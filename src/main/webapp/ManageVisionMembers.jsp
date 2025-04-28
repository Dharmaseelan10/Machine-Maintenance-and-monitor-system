<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Manage Vision Members</title>
    <link href="css/cloudfare.css" rel="stylesheet"/>
    <script src="css/tailwindcss.5"></script>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this member?");
        }
    </script>
</head>
<body class="bg-gray-100">
    <div class="flex">
        <jsp:include page="sidebar.jsp" />
        <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
            <h2 class="text-2xl font-bold mb-4">Manage Vision Members</h2>
            
            <!-- Back Button -->
            <a href="Maintenance.jsp" class="bg-gray-500 text-white px-4 py-2 rounded mb-4 inline-block">Back to Maintenance</a>

            <table class="min-w-full bg-white border border-gray-300">
                <thead>
                    <tr>
                        <th class="border px-4 py-2">#</th> <!-- Numbering column -->
                        <th class="border px-4 py-2">Name</th>
                        <th class="border px-4 py-2">Email</th> <!-- New Email Column -->
                        <th class="border px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<String[]> members = new ArrayList<>();
                    Connection connection = null;
                    try {
                        connection = DBConnection.getConnection();
                        String query = "SELECT * FROM visionmember"; // Ensure your table has an email column
                        PreparedStatement statement = connection.prepareStatement(query);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            String id = resultSet.getString("ID");
                            String name = resultSet.getString("name");
                            String email = resultSet.getString("email"); // Fetch email from the result set
                            members.add(new String[]{id, name, email}); // Add email to the member array
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (connection != null) {
                            DBConnection.closeConnection(connection);
                        }
                    }

                    // Loop through members and display them with numbering
                    int count = 1; // Initialize counter for numbering
                    for (String[] member : members) {
                %>
                    <tr>
                        <td class="border px-4 py-2"><%= count++ %></td> <!-- Display numbering -->
                        <td class="border px-4 py-2"><%= member[1] %></td>
                        <td class="border px-4 py-2"><%= member[2] %></td> <!-- Display email -->
                        <td class="border px-4 py-2">
                            <form action="DeleteVisionMemberServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                                <input type="hidden" name="id" value="<%= member[0] %>">
                                <button type="submit" class="bg-red-500 text-white px-2 py-1 rounded">Delete</button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <br>
            <a href="AddVisionMember.jsp" class="bg-green-500 text-white px-4 py-2 rounded">Add New Member</a>
        </div>
    </div>
</body>
</html>