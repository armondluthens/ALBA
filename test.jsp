<%-- 
    Document   : test
    Created on : Feb 18, 2016, 10:58:57 PM
    Author     : Samuel
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.sql.*" %>


<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    
        <h1>Hello World!</h1>
        <jsp:declaration>

Statement stmt;
Connection con;
String url = "jdbc:mysql://localhost:3306/sedatabase";

</jsp:declaration>

<%

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", ""); 

stmt = con.createStatement();
ResultSet result = stmt.executeQuery("Select AdminID FROM admins");


 while(result.next())
  {
      int AdminID = result.getInt("AdminID");
 %>
<tr>
<td><b><font color='#663300'><%=AdminID%></font></b></td>
</tr>
<%
    }
   
%>



        
        
    
</html>
