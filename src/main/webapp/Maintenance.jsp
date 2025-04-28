<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<String[]> entries = new ArrayList<>();
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        connection = DBConnection.getConnection();
        
        // Query to fetch all entries without pagination
        String query = "SELECT * FROM VTR_LIST ORDER BY SOLVED_AT DESC";
        statement = connection.prepareStatement(query);
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String[] entry = new String[9]; // Change size to 9 to accommodate the new column
            entry[0] = resultSet.getString("EMPLOYEE_ID");
            //entry[1] = resultSet.getString("PRODUCT");
            entry[2] = resultSet.getString("PRODUCT_SERIES");
            entry[3] = resultSet.getString("MACHINE");
            entry[4] = resultSet.getString("MACHINE_NO");
            entry[5] = resultSet.getString("TROUBLE_DETAILS");
            entry[6] = resultSet.getString("PROBLEM");
            entry[7] = resultSet.getString("REMARKS"); // Correctly assign REMARKS to entry[7]
            entry[8] = resultSet.getString("SOLVED_AT"); // New column for solved_at
            entries.add(entry);
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log the exception
    } finally {
        // Close resources in the finally block
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        }
    }
%>

<html>
<head>
    <title>Vision Troubleshoot Request (VTR) System</title>
    <script src="css/tailwindcss.5"></script>
    <link href="css/all.min.css" rel="stylesheet"/> <!-- Ensure Tailwind CSS is included -->
    <style>
        /* styles for the table and filtering options */
        table {
            border-collapse: collapse;
            width: 100%;
            box-sizing: border-box;
            font-family: sans-serif;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            table-layout: fixed;
            font-size: 13px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 5px;
            text-align: left;
            word-wrap: break-word;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .remarks {
            max-width: 200px; /* adjust the width as needed */
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        <!-- Main Content -->
        <div class="flex-grow p-6 ml-4" style="margin-left: 20%; padding: 20px;">
            <div class="flex justify-between items-center mb-4">
    <h2 class="text-2xl font-bold">Maintenance Page</h2>
    <a class="bg-red-500 text-white px-4 py-2 rounded-md" href="logout.jsp">Logout</a>
</div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <div class="bg-blue-500 text-white p-2 rounded-t-lg mb-4">
                    <h2 class="text-lg">Entries List</h2>
                </div>
               
                <!-- Search Input -->
<div class="mb-4 flex justify-end">
     <!-- Button to Manage Vision Members -->
    <a href="ManageVisionMembers.jsp" class="bg-green-500 text-white px-4 py-2 rounded-md ml-4">Vision Members</a>
    <button class="bg-yellow-500 text-white px-4 py-2 rounded-md ml-4" onclick="downloadTableData()">Download as CSV</button>
    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for keywords..." class="border rounded p-2 w-64 ml-4" />
    
   
</div>
                <table class="min-w-full bg-white" id="maintenanceTable">
                    <thead>
                        <tr>
                            <th class="py-2 px-4 border-b">Employee ID</th>
                           
                            <th class="py-2 px-4 border-b">Product Series</th>
                            <th class="py-2 px-4 border-b">Machine</th>
                            <th class="py-2 px-4 border-b">Machine No</th>
                            <th class="py-2 px-4 border-b">Trouble Details</th>
                            <th class="py-2 px-4 border-b">Problem</th>
                            <th class="py-2 px-4 border-b">Remarks</th>
                            <th class="py-2 px-4 border-b">Solved At</th> <!-- New column header -->
                            <th class="py-2 px-4 border-b">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (String[] entry : entries) {
                        %>
                        <tr>
                            <td class="py-2 px-4 border-b"><%= entry[0] %></td>
                            
                            <td class="py-2 px-4 border-b"><%= entry[2] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[3] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[4] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[5] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[6] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[7] %></td>
                            <td class="py-2 px-4 border-b"><%= entry[8] %></td> <!-- Display solved_at data -->
                            <td class="py-2 px-4 border-b">
                                <a href="EditEntry.jsp?id=<%= entry[0] %>" class="text-blue-500 hover:underline">Edit</a>
                                <a href="javascript:void(0);" onclick="deleteEntry('<%= entry[0] %>')" class="text-red-500 hover:underline">Delete</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <footer class="mt-10 text-center text-gray-500 text-sm">
                Murata Electronics (M) Sdn. Bhd. 2025 All rights reserved. V2.02-2025 <br/>
            </footer>
        </div>
    </div>
    <script>
        function deleteEntry(employeeId) {
            if (confirm("Are you sure you want to delete this entry?")) {
                // Create an AJAX request to delete the entry
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "DeleteEntry.jsp", true); // Assuming you have a DeleteEntry.jsp to handle deletion
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // Reload the page to see the changes
                        location.reload();
                    }
                };
                xhr.send("id=" + employeeId);
            }
        }

        function searchTable() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("maintenanceTable");
            var rows = table.getElementsByTagName("tr");

            // Loop through all table rows, except the first (header row)
            for (var i = 1; i < rows.length; i++) {
                var cells = rows[i].getElementsByTagName("td");
                var rowContainsKeyword = false;

                // Loop through each cell in the row
                for (var j = 0; j < cells.length; j++) {
                    if (cells[j]) {
                        var cellValue = cells[j].textContent || cells[j].innerText;
                        if (cellValue.toLowerCase().indexOf(filter) > -1) {
                            rowContainsKeyword = true;
                            break; // No need to check other cells if one matches
                        }
                    }
                }

                // Show or hide the row based on whether it contains the search keyword
                rows[i].style.display = rowContainsKeyword ? "" : "none";
            }
        }
        
         function downloadTableData() {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", "downloadTableData.jsp", true);
  xhr.onload = function() {
    if (xhr.status === 200) {
      var csvContent = xhr.responseText;
      var encodedUri = encodeURI("data:text/csv;charset=utf-8," + csvContent);
      var link = document.createElement("a");
      link.setAttribute("href", encodedUri);
      link.setAttribute("download", "VTR_LIST.csv");
      link.click();
    }
  };
  xhr.send();
}
    </script>
</body>
</html>