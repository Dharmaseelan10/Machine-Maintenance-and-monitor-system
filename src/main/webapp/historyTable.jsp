<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="bg-white shadow-md rounded p-6">
  
<div class="bg-blue-500 text-white p-2 rounded-t-lg mb-4"> <!-- Added mb-4 for margin-bottom -->
    <h3 class="text-lg">Request History</h3>
</div>
    <!-- Filtering Options -->
    <div class="mb-4">
        <button class="bg-blue-500 text-white px-4 py-2 rounded-md" onclick="filterTable('Waiting')">Waiting</button>
        <button class="bg-yellow-500 text-white px-4 py-2 rounded-md" onclick="filterTable('In Progress')">In Progress</button>
        <button class="bg-green-500 text-white px-4 py-2 rounded-md" onclick="filterTable('Solved')">Solved</button>
        
        <div class="mb-4 px-4 py-2 rounded-md float-right">
            <!-- Search Bar -->
            &nbsp; &nbsp;<input type="text" id="search-input" placeholder="Search...">
            <button id="search-button" class="text-black px-4 py-2 rounded-md outline outline-1 outline-gray">Search</button>
        </div>
    </div>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-overlay"></div>
        <div class="modal-content">
            <div class="product-details-container" style="display: none;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <h3 class="text-xl font-semibold mb-4">Requested Details</h3>
                    <button class="close" style="padding: 5px 10px; background-color: #f44336; color: white; border: none; border-radius: 5px; cursor: pointer; margin: 10px 0;">Close</button>
                </div>
                <table>
                    <tr>
                        <th>Employee ID:</th>
                        <td class="employeeId"></td>
                    </tr>
                    <tr>
                        <th>Series:</th>
                        <td class="series"></td>
                    </tr>
                    <tr>
                        <th>Machine No:</th>
                        <td class="machineNo"></td>
                    </tr>
                    <tr>
                        <th>Trouble Details:</th>
                        <td class="troubleDetails"></td>
                    </tr>
                    <tr>
                        <th>Status:</th>
                        <td class="status"></td>
                    </tr>
                    <tr>
                        <th>Attend By:</th>
                        <td class="attendBy"></td>
                    </tr>
                    <tr>
                        <th>Problem:</th>
                        <td class="problem"></td>
                    </tr>
                    <tr>
                        <th>Remarks:</th>
                        <td class="remarks" style="white-space: pre-wrap; word-wrap: break-word;"></td>
                    </tr>
                    <tr>
                        <th>Created At:</th>
                        <td class="createdAt"></td>
                    </tr>
                    <tr>
                        <th>Accepted At:</th>
                        <td class="acceptedAt"></td>
                    </tr>
                    <tr>
                        <th>Solved At:</th>
                        <td class="solvedAt"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <br>
    <table id="historyTable">
        <thead>
            <tr>
                <th>Employee<i class="fas fa-sort" onclick="sortTable(0)"></i></th>
                <th>Product</th>
                <th>Series <i class="fas fa-sort" onclick="sortTable(2)"></i></th>
                <th>Machine <i class="fas fa-sort" onclick="sortTable(3)"></i></th>
                <th>Trouble<i class="fas fa-sort" onclick="sortTable(4)"></i></th>
                <th>Status</th>
                <th class="attend-by">Attend By <i class="fas fa-sort" onclick="sortTable(6)"></i></th>
                <th class="problem">Problem</th>
                <th class="remarks">Remarks</th>
                <th>Created At <i class="fas fa-sort" onclick="sortTable(7)"></i></th>
                <th>Accepted At <i class="fas fa-sort" onclick="sortTable(8)"></i></th>
                <th>Solved At<i class="fas fa-sort" onclick="sortTable(9)"></i></th>
            </tr>
        </thead>
        
        <tbody>
            <%
                int recordsPerPage = 25; // Number of records per page
                int currentPage = 1; // Default to the first page
                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    currentPage = Integer.parseInt(pageParam);
                }
                int offset = (currentPage - 1) * recordsPerPage;

                Connection connection = null;
                try {
                    connection = DBConnection.getConnection();
                    String query = "SELECT * FROM (SELECT a.*, ROWNUM rnum FROM (SELECT * FROM VTR_LIST ORDER BY SOLVED_AT DESC) a WHERE ROWNUM <= ?) WHERE rnum > ?";
                    PreparedStatement statement = connection.prepareStatement(query);
statement.setInt(1, recordsPerPage + offset); // Total number of records to fetch
statement.setInt(2, offset); // Offset
                    ResultSet resultSet = statement.executeQuery();

                    while (resultSet.next()) {
            %>
            <tr onclick="showDetails('<%= resultSet.getString("EMPLOYEE_ID") %>','<%= resultSet.getString("PRODUCT_SERIES") %>','<%= resultSet.getString("MACHINE_NO") %>','<%= resultSet.getString("TROUBLE_DETAILS") %>','<%= resultSet.getString("STATUS") %>','<%= resultSet.getString("ATTEND_BY") %>','<%= resultSet.getString("PROBLEM") %>','<%= resultSet.getString("REMARKS") %>','<%= resultSet.getTimestamp("CREATED_AT") %>','<%= resultSet.getTimestamp("ACCEPTED_AT") %>','<%= resultSet.getTimestamp("SOLVED_AT") %>')">
                <td><%= resultSet.getString("EMPLOYEE_ID") %></td>
                <td><%= resultSet.getString("PRODUCT") %></td>
                <td><%= resultSet.getString("PRODUCT_SERIES") %></td>
                <td><%= resultSet.getString("MACHINE") %>-<%= resultSet.getString("MACHINE_NO") %></td>
                <td><%= resultSet.getString("TROUBLE_DETAILS") %></td>
                <td><%= resultSet.getString("STATUS") %></td>
                <td class="attend-by"><%= resultSet.getString("ATTEND_BY") %></td>
                <td class="problem"><%= resultSet.getString("PROBLEM") %></td>
                <td class="remarks"><%= resultSet.getString("REMARKS") %></td>
                <td><%= resultSet.getTimestamp("CREATED_AT") %></td>
                <td><%= resultSet.getTimestamp("ACCEPTED_AT") %></td>
                <td><%= resultSet.getTimestamp("SOLVED_AT") %></td>
            </tr>
            
<%
                    }
                    resultSet.close();
                    statement.close();
                } catch (SQLException e) {
                    out.println("Error retrieving data: " + e.getMessage());
                } finally {
                    if (connection != null) {
                        DBConnection.closeConnection(connection);
                    }
                }
            %>
        </tbody>
    </table>

    <div class="pagination">
        <%
            int totalRecords = 0;
            try {
                connection = DBConnection.getConnection();
                String countQuery = "SELECT COUNT(*) FROM VTR_LIST";
                PreparedStatement countStatement = connection.prepareStatement(countQuery);
                ResultSet countResultSet = countStatement.executeQuery();
                if (countResultSet.next()) {
                    totalRecords = countResultSet.getInt(1);
                }
                countResultSet.close();
                countStatement.close();
            } catch (SQLException e) {
                out.println("Error counting records: " + e.getMessage());
            } finally {
                if (connection != null) {
                    DBConnection.closeConnection(connection);
                }
            }

            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            for (int i = 1; i <= totalPages; i++) {
                if (i == currentPage) {
        %>
                    <span class="current-page"><%= i %></span>
        <%
                } else {
        %>
                    <a href="?page=<%= i %>" class="page-link"><%= i %></a>
        <%
                }
            }
        %>
    </div>
</div>
<script>
    function showDetails(employeeId, series, machineNo, troubleDetails, status, attendBy, problem, remarks, createdAt, acceptedAt, solvedAt) {
        var modal = document.getElementById("myModal");
        var modalContent = modal.querySelector(".modal-content");
        var productDetailsContainer = modalContent.querySelector(".product-details-container");
        productDetailsContainer.style.display = "block";

        var employeeIdTd = productDetailsContainer.querySelector(".employeeId");
        var seriesTd = productDetailsContainer.querySelector(".series");
        var machineNoTd = productDetailsContainer.querySelector(".machineNo");
        var troubleDetailsTd = productDetailsContainer.querySelector(".troubleDetails");
        var statusTd = productDetailsContainer.querySelector(".status");
        var attendByTd = productDetailsContainer.querySelector(".attendBy");
        var problemTd = productDetailsContainer.querySelector(".problem");
        var remarksTd = productDetailsContainer.querySelector(".remarks");
        var createdAtTd = productDetailsContainer.querySelector(".createdAt");
        var acceptedAtTd = productDetailsContainer.querySelector(".acceptedAt");
        var solvedAtTd = productDetailsContainer.querySelector(".solvedAt");

        employeeIdTd.textContent = employeeId;
        seriesTd.textContent = series;
        machineNoTd.textContent = machineNo;
        troubleDetailsTd.textContent = troubleDetails;
        statusTd.textContent = status;
        attendByTd.textContent = attendBy;
        problemTd.textContent = problem;
        remarksTd.textContent = remarks;
        createdAtTd.textContent = createdAt;
        acceptedAtTd.textContent = acceptedAt;
        solvedAtTd.textContent = solvedAt;

        modal.style.display = "block";
    }

    var closeButton = document.querySelector(".close");
    closeButton.addEventListener("click", function() {
        var modal = document.getElementById("myModal");
        modal.style.display = "none";
        var productDetailsContainer = modal.querySelector(".product-details-container");
        productDetailsContainer.style.display = "none";
    });

    const searchInput = document.getElementById('search-input');
    const searchButton = document.getElementById('search-button');
    const table = document.getElementById('historyTable');
    const tbody = table.tBodies[0];

    searchButton.addEventListener('click', () => {
        const searchValue = searchInput.value.toLowerCase();
        const rows = tbody.rows;

        if (searchValue === '') {
            filterTable('Solved');
        } else {
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.cells;
                let found = false;

                for (let j = 0; j < cells.length; j++) {
                    const cell = cells[j];
                    const cellText = cell.textContent.toLowerCase();

                    if (cellText.includes(searchValue)) {
                        found = true;
                        break;
                    }
                }

                row.style.display = found ? '' : 'none';
            }
        }
    });

    searchInput.addEventListener('keyup', () => {
        searchButton.click();
    });
</script>

<style>
    .modal {
        display: none; 
        position: fixed; 
        z-index: 1000; 
        left: 0; 
        top: 0; 
        width: 100%; 
        height: 100%; 
        overflow: auto; 
        background-color: rgba(0, 0, 0, 0.3); /* Reduced darkness */
    }

    .modal-overlay {
        position: absolute; 
        top: 0; 
        left: 0; 
        width: 100%; 
        height: 100%; 
        background-color: rgba(0, 0, 0, 0.3); /* Reduced darkness */
    }

    .modal-content {
        position: relative; 
        margin: auto; 
        padding: 20px; 
        background-color: white; 
        border-radius: 8px; 
        width: 80%; 
        max-width: 600px; 
        top: 50%; 
        transform: translateY(-50%); 
    }

    .close {
        cursor: pointer; 
    }
</style>

        
        
        
        