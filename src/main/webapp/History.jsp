<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Vision Troubleshoot Request (VTR) System</title>
  <script src="css/tailwindcss.5"></script>
    <link href="css/all.min.css" rel="stylesheet"/>
     
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
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .page-link {
            margin: 0 5px;
            text-decoration: none;
            color: blue;
        }
        .current-page {
            margin: 0 5px;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-gray-100">
    <!-- Sidebar and Main Content -->
    <div class="flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        <!-- Main Content -->
        <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold">Vision Troubleshoot Request (VTR) System</h2>
                <div class="text-sm text-gray-500">
                    <a class="hover:underline" href="Form.jsp">Home</a> / <a class="hover:underline" href="Summary.jsp">Page 1</a> / <a class="hover:underline" href="History.jsp">Page 2</a>
                </div>
            </div>
            <!-- Request History table and filtering options -->
            <jsp:include page="historyTable.jsp" />
        </div>
    </div>
    <footer class="mt-10 text-center text-gray-500 text-sm">
        Murata Electronics (M) Sdn. Bhd. 2025 All rights reserved. V2.02-2025 <br/>
    </footer>
</body>

      <script>
       
 function sortTable(columnIndex) {
  var table = document.getElementById("historyTable");
  var rows = table.rows;
  var sortedRows = Array.prototype.slice.call(rows, 1); // Get all rows except the header row

  // Sort the rows based on the column index
  sortedRows.sort(function(a, b) {
    var aValue = a.cells[columnIndex].textContent;
    var bValue = b.cells[columnIndex].textContent;

    // Convert the values to dates if the column index is 9, 10, or 11
    if (columnIndex >= 9) {
      aValue = new Date(aValue);
      bValue = new Date(bValue);
    }

    // Sort in ascending order
    if (aValue < bValue) {
      return -1;
    } else if (aValue > bValue) {
      return 1;
    } else {
      return 0;
    }
  });

  // Remove all rows from the table except the header row
  for (var i = 1; i < rows.length; i++) {
    table.deleteRow(1);
  }

  // Add the sorted rows back to the table
  for (var i = 0; i < sortedRows.length; i++) {
    table.tBodies[0].appendChild(sortedRows[i]);
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
  // Call filterTable with 'Solved' status when the page loads
  document.addEventListener("DOMContentLoaded", function() {
    filterTable('Solved');
  });

  function filterTable(status) {
    var table = document.getElementById("historyTable");
    var rows = table.rows;
    var  productIndex = 1;  
    var attendByIndex = 6; // Index of "Attend By" column
    var problemIndex = 7;  // Index of "Problem" column
    var remarksIndex = 8;  // Index of "Remarks" column
    var createdAtIndex = 9; // Index of "Created At" column
    var acceptedAtIndex = 10; // Index of "Accepted At" column
    var solvedAtIndex = 11; // Index of "Solved At" column 
    // Hide or show columns based on the status
    if (status === "Waiting") {
      setColumnVisibility(table, productIndex, false); 
      setColumnVisibility(table, attendByIndex, false);
      setColumnVisibility(table, problemIndex, false);
      setColumnVisibility(table, remarksIndex, false);
      setColumnVisibility(table, createdAtIndex, true);
      setColumnVisibility(table, acceptedAtIndex, false);
      setColumnVisibility(table, solvedAtIndex, false);
    } else if (status === "In Progress") {
      setColumnVisibility(table, productIndex, false); 
      setColumnVisibility(table, attendByIndex, true);
      setColumnVisibility(table, problemIndex, false);
      setColumnVisibility(table, remarksIndex, false);
      setColumnVisibility(table, createdAtIndex, false);
      setColumnVisibility(table, acceptedAtIndex, true);
      setColumnVisibility(table, solvedAtIndex, false);
    } else if (status === "Solved") {
      setColumnVisibility(table, productIndex, false);  
      setColumnVisibility(table, attendByIndex, true);
      setColumnVisibility(table, problemIndex, true);
      setColumnVisibility(table, remarksIndex, true);
      setColumnVisibility(table, createdAtIndex, false);
      setColumnVisibility(table, acceptedAtIndex, false);
      setColumnVisibility(table, solvedAtIndex, true);
    }

    // Show or hide rows based on the status
    for (var i = 1; i < rows.length; i++) {
      var row = rows[i];
      var statusCell = row.cells[5].textContent;
      if (statusCell === status) {
        row.style.display = "";
      } else {
        row.style.display = "none";
      }
    }
  }

  function setColumnVisibility(table, columnIndex, isVisible) {
    var displayStyle = isVisible ? "" : "none";
    for (var i = 0; i < table.rows.length; i++) {
      var cell = table.rows[i].cells[columnIndex];
      if (cell) {
        cell.style.display = displayStyle;
      }
    }
  }
  
  
</script>
</body>
</html>