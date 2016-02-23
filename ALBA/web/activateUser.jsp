<%-- 
    Document   : activateUser
    Created on : Feb 23, 2016, 12:55:22 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String token = request.getParameter("token");
   
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String sqlActivateUser = "UPDATE USERS SET Activated='1' WHERE UserID='"+ token +"';";

    boolean validToken= false;
    String checkForToken = "SELECT UserID FROM USERS WHERE UserID = '"+ token +"'";
    String tokenReturnedFromSQL="";
    ResultSet tokenRs = stmt.executeQuery(checkForToken);
    while(tokenRs.next()){
        tokenReturnedFromSQL = tokenRs.getString("UserID");
        if(tokenReturnedFromSQL.equals(token)){
            validToken = true;
        }
    }
    
    if(validToken == true){
        stmt.executeUpdate(sqlActivateUser);
        response.sendRedirect("index.jsp");
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>

