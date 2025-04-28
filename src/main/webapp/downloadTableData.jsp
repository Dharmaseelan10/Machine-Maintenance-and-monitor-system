<%@ page import="com.mycompany.test.vtr.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/csv; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  response.setContentType("text/csv");
  response.setHeader("Content-Disposition", "attachment; filename=\"VTR_Report.csv\"");
  
  Connection connection = null;
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  
  try {
    connection = DBConnection.getConnection();
    String query = "SELECT * FROM VTR_LIST";
    PreparedStatement statement = connection.prepareStatement(query);
    ResultSet resultSet = statement.executeQuery();

    // Print CSV headers
    out.print("Employee ID,Product,Product Series,Machine No,Trouble Details,Status,Attend By,Problem,Created At,Accepted At,Solved At,Remarks\n");

    while (resultSet.next()) {
      out.print("\"" + resultSet.getString("EMPLOYEE_ID") + "\",");
      out.print("\"" + resultSet.getString("PRODUCT") + "\",");
      out.print("\"" + resultSet.getString("PRODUCT_SERIES") + "\",");
      out.print("\"" + resultSet.getString("MACHINE_NO") + "\",");
      out.print("\"" + resultSet.getString("TROUBLE_DETAILS") + "\",");
      out.print("\"" + resultSet.getString("STATUS") + "\",");
      out.print("\"" + resultSet.getString("ATTEND_BY") + "\",");
      out.print("\"" + resultSet.getString("PROBLEM") + "\",");
      
      // Format timestamps
      out.print("\"" + (resultSet.getTimestamp("CREATED_AT") != null ? dateFormat.format(resultSet.getTimestamp("CREATED_AT")) : "") + "\",");
      out.print("\"" + (resultSet.getTimestamp("ACCEPTED_AT") != null ? dateFormat.format(resultSet.getTimestamp("ACCEPTED_AT")) : "") + "\",");
      out.print("\"" + (resultSet.getTimestamp("SOLVED_AT") != null ? dateFormat.format(resultSet.getTimestamp("SOLVED_AT")) : "") + "\",");
      out.print("\"" + (resultSet.getString("REMARKS") != null ? resultSet.getString("REMARKS") : "") + "\"\n");
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