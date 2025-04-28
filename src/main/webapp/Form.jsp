<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<html>
<!-- Notification Container -->
  <div id="notification-container">
    <%-- Success Message --%>
   <% if (session.getAttribute("successMessage") != null) { %>
<div id="successMessage" class="text-white relative p-2" 
     style="position: fixed; bottom: 0; left: 0; width: 100%; z-index: 1; background-color: rgba(52, 199, 89, 0.8);">
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
         style="position: fixed; bottom: 0; left: 0; width: 100%; z-index: 1; background-color: red;">
        <span class="absolute top-2 right-2 cursor-pointer" onclick="closeMessage('errorMessage')">
            &times;
        </span>
        <%= session.getAttribute("errorMessage") %>
    </div>
    <% session.removeAttribute("errorMessage"); // Remove after displaying %> 
<% } %>

  

  <script>
    function closeMessage(messageId) {
      document.getElementById(messageId).style.display = "none";
    }
  </script>
<head>
  <title>
    Vision Troubleshoot Request (VTR) System
  </title>
  <script src="css/tailwindcss.5">
  <link href="css/icon.css" rel="stylesheet"/>
  <link href="css/cloudfare.css" rel="stylesheet"/>
  </div></script>
</head>
<body class="bg-gray-100">
      <div class="flex">
    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp" />
    <!-- Main Content -->
 <div class="w-4/5 p-6" style="margin-left: 20%; padding: 20px;">
      <div class="flex justify-between items-center mb-4">
    <h2 class="text-2xl font-bold">
      Vision Troubleshoot Request (VTR) System
    </h2>

  </div>
  <div class="bg-white p-6 rounded-lg shadow-md">
    <div class="bg-blue-500 text-white p-2 rounded-t-lg">
      <h2 class="text-lg">
        Request Form
      </h2>
    </div>

    <form class="p-4" name="requestForm" action="FormHandler.jsp" method="post">
      <div class="mb-4">
    <label class="block text-gray-700">
        Employee ID
    </label>
    <input class="w-full p-2 border rounded" type="text" name="employeeId" placeholder="Enter Employee ID E.g: ME10000" required oninput="this.value = this.value.toUpperCase()" maxlength="7" />
</div>
<div class="mb-4">
  <label class="block text-gray-700">Product</label>
  <select class="w-full p-2 border rounded" id="product" name="product" required>
    <option value="">Select Product</option>
    <option value="LQW">LQW</option>
    <option value="DLW">DLW</option>
    <option value="PLT">PLT</option>
    <option value="LQH">LQH</option>
  </select>
</div>

<div class="mb-4">
  <label class="block text-gray-700">Product Series</label>
  <select class="w-full p-2 border rounded" id="product-series" name="productSeries" required>
    <!-- Populated dynamically based on product selection -->
  </select>
</div>

<div class="mb-4">
  <label class="block text-gray-700">Machine</label>
  <select class="w-full p-2 border rounded" id="machine" name="machine" required>
    <!-- Populated dynamically based on product series selection -->
  </select>
</div>

<div class="mb-4">
  <label class="block text-gray-700">Machine No</label>
  <select class="w-full p-2 border rounded" id="machine-no" name="machineNo" required>
    <!-- Populated dynamically based on machine selection -->
  </select>
</div>
          <div class="mb-4">
            <label class="block text-gray-700">
              Trouble Details
            </label>   <br style="line-height: 0.5;">
           <div class="flex items-center mb-2" style="font-size: 15px;">
              <input class="mr-2" name="trouble" type="radio" value="Leakage" required />
             Leakage
            </div>
            <div class="flex items-center mb-2" style="font-size: 15px;">
              <input class="mr-2" name="trouble" type="radio" value="Overjudge" />
             Overjudge 
            </div>
           <div class="flex items-center mb-2" style="font-size: 15px;">
              <input class="mr-2" name="trouble" type="radio" value="Vision Sample" />
              Vision Sample
            </div>
            <div class="flex items-center mb-2" style="font-size: 15px;">
              <input class="mr-2" name="trouble" type="radio" value="Camera Abnormal" />
              Camera Abnormal
            </div>
            <div class="flex items-center mb-2" style="font-size: 15px;">
              <input class="mr-2" name="trouble" type="radio" value="Other" />
              Other
              <input class="ml-2 p-2 border rounded w-2/4" type="text" name="otherTrouble"  />
            </div>
          </div>
            <script src="formScript.js"></script> 
         <button class="bg-blue-500 text-white p-2 rounded">
        Submit
      </button>
    </form>
  </div>
  <footer class="mt-10 text-center text-gray-500 text-sm">
        Murata Electronics (M) Sdn. Bhd. 2025 All rights reserved. V2.02-2025 <br/>
    </footer>
</div>
</body>
</html>
