<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<html>
<head>
    <title>Vision Troubleshoot Request (VTR) System</title>
    <script src="css/tailwindcss.5"></script>
    <link href="css/cloudfare.css" rel="stylesheet"/>
</head>
<body class="bg-gray-100">
    <div class="flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        <!-- Main Content -->
        <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold">Vision Troubleshoot Request (VTR) System</h2>
                <div class="text-sm text-gray-500">
                    <a class="hover:underline" href="Form.jsp">Home</a> / 
                    <a class="hover:underline" href="Summary.jsp">Page 1</a> / 
                    <a class="hover:underline" href="History.jsp">Page 2</a>
                    <a class="bg-red-500 text-white px-4 py-2 rounded-md ml-4" href="logout.jsp">Logout</a>
                </div>
            </div>
            <div class="bg-white p-4 shadow-md rounded-md">
                <div class="bg-blue-500 text-white p-2 rounded-t-lg mb-4">
                    <h3 class="text-lg">Request Summary</h3>
                </div>
                <%
                int waitingCount = 0;
                int inProgressCount = 0;
                Connection connection = null;
                try {
                    connection = DBConnection.getConnection();
                    String query = "SELECT * FROM vtr_list WHERE STATUS != 'Solved'";
                    PreparedStatement statement = connection.prepareStatement(query);
                    ResultSet resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        String status = resultSet.getString("STATUS");
                        if (status.equals("Waiting")) {
                            waitingCount++;
                        } else if (status.equals("In Progress")) {
                            inProgressCount++;
                        }
                    }
                } catch (SQLException e) {
                    System.out.println("Error retrieving data: " + e.getMessage());
                } finally {
                    DBConnection.closeConnection(connection);
                }
                %>

                <div class="flex mb-4">
                    <div class="flex items-center bg-red-200 text-red-800 px-4 py-2 rounded-md mr-4">
                        <span>Waiting</span>
                        <span class="ml-2 bg-red-500 text-white px-2 py-1 rounded-full"><%= waitingCount %></span>
                    </div>
                    <div class="flex items-center bg-yellow-200 text-yellow-800 px-4 py-2 rounded-md">
                        <span>In-progress</span>
                        <span class="ml-2 bg-yellow-500 text-white px-2 py-1 rounded-full"><%= inProgressCount %></span>
                    </div>
                </div>
                <div class="grid grid-cols-3 gap-4">
                <%
                try {
                    connection = DBConnection.getConnection();
                    String query = "SELECT * FROM vtr_list WHERE STATUS != 'Solved' ORDER BY CREATED_AT ASC";
                    PreparedStatement statement = connection.prepareStatement(query);
                    ResultSet resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        String id = resultSet.getString("ID");
                        String employeeId = resultSet.getString("EMPLOYEE_ID");
                        String product = resultSet.getString("PRODUCT");
                        String productSeries = resultSet.getString("PRODUCT_SERIES");
                        String machine = resultSet.getString("MACHINE");
                        String machineNo = resultSet.getString("MACHINE_NO");
                        String troubleDetails = resultSet.getString("TROUBLE_DETAILS");
                        String status = resultSet.getString("STATUS");
                        String createdAt = resultSet.getString("CREATED_AT");
                        String acceptedAt = resultSet.getString("ACCEPTED_AT");
                        String attendBy = resultSet.getString("ATTEND_BY");

                        // Calculate waiting time
                        long waitingTime = 0;
                        if (createdAt != null && !createdAt.trim().isEmpty()) {
                            waitingTime = System.currentTimeMillis() - java.sql.Timestamp.valueOf(createdAt).getTime();
                        }

                        // Determine container class based on status
                        String containerClass = "";
                        if (status.equals("Waiting")) {
                            containerClass = "bg-red-100";
                        } else if (status.equals("In Progress")) {
                            containerClass = "bg-yellow-100";
                        }
                %>
                <div id="container-<%= id %>" class="p-4 shadow-md rounded-md <%= containerClass %> cursor-pointer" 
                     style="background-color: <%= status.equals("Waiting") ? "#FFC5C5" : "#FFFFCC" %>; transition: max-height 0.3s ease-out; overflow: hidden; max-height: 100px;"
                     data-created-at="<%= createdAt %>" 
                     data-accepted-at="<%= acceptedAt %>" 
                     data-status="<%= status %>">
                    <div class="flex justify-between items-center mb-4">
                        <h4 class="text-lg font-bold"><%= productSeries %> -<%= machineNo %></h4>
                        <span class="waiting-time text-sm text-gray-500"></span>
                    </div>
                    <div class="flex justify-between items-center mb-4">
                        <p><strong>Trouble Detail:</strong> <%= troubleDetails %></p>
                        <% if (status.equals("In Progress")) { %>
                            <span class="troubleshooting-time text-sm text-gray-500"></span>
                        <% } %>
                    </div>

                    <!-- Hidden content initially -->
                    <div id="details-<%= id %>" class="hidden">
                        <p><strong>Employee ID:</strong> <%= employeeId %></p>
                        <p><strong>Product:</strong> <%= product %> - <%= productSeries %></p>   
                        <p><strong>Machine Details:</strong> <%= machine %> - <%= machineNo %></p>    
                        <hr class="my-2"/>

                        <% if (status.equals("In Progress")) { %>
                            <p><strong>Accepted At:</strong> <%= acceptedAt %></p>
                        <% } %>

                        <% if (status.equals("Waiting")) { %>
                            <div class="flex items-center mt-2">
                                <label class="mr-2" for="attend-<%= id %>">Attend:</label>
                                <select class="border rounded-md p-1 flex-1" id="attend-<%= id %>" data-id="<%= id %>">
                                    <option value="">Select Attend</option>
                                </select>
                            </div>
                            <button class="bg-green-500 text-white px-4 py-2 rounded-md mt-2" onclick="acceptRequest('<%= id %>')">Accept</button>
                        <% } else if (status.equals("In Progress")) { %>
                            <p><strong>Attend By:</strong> <%= attendBy %></p>
                            <div class="mt-2">
                                <p><strong>Problem:</strong> 
                                    <select class="border rounded-md p-1 flex-1" id="problem-<%= id %>">
                                        <option value="">Select Problem</option>
                                        <option value="Overjudge">Overjudge</option>
                                        <option value="Leakage">Leakage</option>
                                        <option value="Vision Sample">Vision Sample</option>
                                        <option value="Camera Abnormal">Camera Abnormal</option>
                                        <option value="Other">Other</option>
                                    </select>
                                    <input class="border rounded-md p-1 flex-1" id="problem-other-<%= id %>" type="text" style="display: none;">
                                </p>
                                <p><strong>Remarks:</strong> <input class="border rounded-md p-1 flex-1" id="remarks-<%= id %>" type="text" /></p>
                            </div>
                            <button class="bg-green-500 text-white px-4 py-2 rounded-md mt-2" onclick="completeRequest('<%= id %>')">Complete</button>
                        <% } %>
                    </div>
                </div>
                <%
                    }
                } catch (SQLException e) {
                    System.out.println("Error retrieving data: " + e.getMessage());
                } finally {
                    DBConnection.closeConnection(connection);
                }
                %>

                </div>
            </div>
            <footer class="mt-10 text-center text-gray-500 text-sm">
                Murata Electronics (M) Sdn. Bhd. 2025 All rights reserved. V2.02-2025 <br/>
            </footer>
        </div>
    </div>
</body>
</html>
<%!
    public String formatTime(long time) {
        long hours = time / (1000 * 60 * 60);
        long minutes = (time % (1000 * 60 * 60)) / (1000 * 60);
        long seconds = (time % (1000 * 60)) / 1000;

        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }
%>
<script>
    // Fetch attendees from the servlet
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('[id^="attend-"]').forEach(select => {
        const id = select.getAttribute('data-id');
        fetch('VisionTeam')
            .then(response => response.json())
            .then(data => {
                console.log("Data received from VisionTeam servlet:", data); // Log the received data
                data.forEach(attendee => {
                    const option = document.createElement('option');
                    option.value = attendee;
                    option.textContent = attendee;
                    select.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching attendees:', error));
    });
});
    document.querySelectorAll('[id^="container-"]').forEach(container => {
        container.addEventListener('click', function(event) {
            event.stopPropagation();
            const details = this.querySelector('[id^="details-"]');
            if (details) {
                details.classList.toggle('hidden');
                this.style.maxHeight = details.classList.contains('hidden') ? '100px' : '500px';
            }
        });
    });

    document.querySelectorAll('input, button, select').forEach(element => {
        element.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    });

    

    function updateLiveTime() {
        document.querySelectorAll('[id^="container-"]').forEach(container => {
            const createdAt = container.getAttribute('data-created-at');
            const acceptedAt = container.getAttribute('data-accepted-at');
            const status = container.getAttribute('data-status');

            if (createdAt) {
                const waitingTime = Date.now() - new Date(createdAt).getTime();
                const waitingTimeElement = container.querySelector('.waiting-time');
                if (waitingTimeElement) {
                    waitingTimeElement.innerHTML = " " + formatTime(waitingTime);
                }
            }

            if (status === "In Progress" && acceptedAt) {
                const troubleshootingTime = Date.now() - new Date(acceptedAt).getTime();
                const troubleshootingTimeElement = container.querySelector('.troubleshooting-time');
                if (troubleshootingTimeElement) {
                    troubleshootingTimeElement.innerHTML = " " + formatTime(troubleshootingTime);
                }
            }
        });
    }

    function formatTime(time) {
        const hours = Math.floor(time / (1000 * 60 * 60));
        const minutes = Math.floor((time % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((time % (1000 * 60)) / 1000);
        return String(hours).padStart(2, '0') + ":" + String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');
    }

    setInterval(updateLiveTime, 1000);

    function acceptRequest(id) {
        console.log("Accept request clicked for id: " + id);
        var attend = document.getElementById("attend-" + id).value;
        if (attend === "") {
            alert("Please select attendent");
            return;
        }

        fetch("${pageContext.request.contextPath}/UpdateStatusServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "id=" + id + "&status=In Progress&attend=" + attend
        })
        .then(response => {
            if (response.ok) {
                window.location.reload();
                var container = document.getElementById("container-" + id);
                if (container) {
                    container.style.backgroundColor = "#FFFFCC";
                    container.classList.remove("bg-red-100");
                    container.classList.add("bg-yellow-100");
                }
                var waitingTime = document.getElementById("waiting-time-" + id);
                if (waitingTime) {
                    waitingTime.innerHTML = " Troubleshooting Time: " + waitingTime.innerHTML.split(":")[1];
                }
                var problem = document.getElementById("problem-" + id);
                if (problem) {
                    problem.style.display = "block";
                }
                var remarks = document.getElementById("remarks-" + id);
                if (remarks) {
                    remarks.style.display = "block";
                }
                var statusCell = document.getElementById("status-" + id);
                if (statusCell) {
                    statusCell.innerHTML = "In Progress";
                }
                var waitingCount = document.getElementById("waiting-count");
                var inProgressCount = document.getElementById("in-progress-count");
                if (waitingCount && inProgressCount) {
                    waitingCount.innerHTML = parseInt(waitingCount.innerHTML) - 1;
                    inProgressCount.innerHTML = parseInt(inProgressCount.innerHTML) + 1;
                }
            } else {
                alert("Error updating status: " + response.statusText);
            }
        })
        .catch(error => {
            console.error("Error accepting request: " + error);
            alert("Error accepting request: " + error);
        });
    }

    function completeRequest(id) {
        console.log("Complete request clicked for id: " + id);
        var problem = document.getElementById("problem-" + id).value;
        var remarks = document.getElementById("remarks-" + id).value;

        if (problem === "" || remarks === "") {
            alert("Please enter problem and remarks");
            return;
        }

        fetch("${pageContext.request.contextPath}/UpdateStatusServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "id=" + id + "&status=Solved&problem=" + problem + "&remarks=" + remarks
        })
        .then(response => {
            if (response.ok) {
                window.location.reload();
                var container = document.getElementById("container-" + id);
                if (container) {
                    container.style.backgroundColor = "#C6F4D6";
                    container.classList.remove("bg-yellow-100");
                    container.classList.add("bg-green-100");
                }
                var statusCell = document.getElementById("status-" + id);
                if (statusCell) {
                    statusCell.innerHTML = "Solved";
                }
                var inProgressCount = document.getElementById("in-progress-count");
                var solvedCount = document.getElementById("solved-count");
                if (inProgressCount && solvedCount) {
                    inProgressCount.innerHTML = parseInt(inProgressCount.innerHTML) - 1;
                    solvedCount.innerHTML = parseInt(solvedCount.innerHTML) + 1;
                }
            } else {
                alert("Error updating status: " + response.statusText);
            }
        })
        .catch(error => {
            console.error("Error completing request: " + error);
            alert("Error completing request: " + error);
        });
    }
</script>