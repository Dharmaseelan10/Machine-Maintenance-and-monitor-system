<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>

<html>
<head>
    <title>Add Vision Member</title>
    <link href="css/cloudfare.css" rel="stylesheet"/>
    <script src="css/tailwindcss.5"></script>
</head>
<body class="bg-gray-100">
    <div class="flex">
        <jsp:include page="sidebar.jsp" />
        <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
            <h2 class="text-2xl font-bold mb-4">Add New Vision Member</h2>
            <form action="AddVisionMemberServlet" method="post" class="bg-white p-4 shadow-md rounded">
                <div class="mb-4">
                    <label for="name" class="block text-gray-700">Name:</label>
                    <input type="text" id="name" name="name" required class="border rounded p-2 w-full">
                </div>
                <div class="mb-4">
                    <label for="email" class="block text-gray-700">Email:</label>
                    <input type="email" id="email" name="email" required class="border rounded p-2 w-full">
                </div>
                <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded">Add Member</button>
            </form>
            <br>
            <a href="ManageVisionMembers.jsp" class="bg-gray-500 text-white px-4 py-2 rounded">Back to Members List</a>
        </div>
    </div>
</body>
</html>