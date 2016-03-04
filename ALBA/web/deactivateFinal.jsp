<%-- 
    Document   : deactivateFinal
    Created on : Feb 29, 2016, 7:14:23 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email= (String)session.getAttribute( "sessionEmail" );
    String firstName= (String)session.getAttribute( "sessionFirstName" );
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    String sqlDeactivateUser = "UPDATE USERS SET Activated='0' WHERE Email='"+ email +"';";
    stmt.executeUpdate(sqlDeactivateUser);
    response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello <%= firstName%></h1>
    </body>
</html>
