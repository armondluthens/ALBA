<%-- 
    Document   : insertPart
    Created on : Mar 7, 2016, 7:39:49 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String partID = request.getParameter("partSelected");
    String insertPart= "UPDATE PRODUCTS SET Available='1' WHERE ProductID='" + partID + "';";
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    stmt.executeUpdate(insertPart);
    response.sendRedirect("managerProductPage.jsp");
%>
