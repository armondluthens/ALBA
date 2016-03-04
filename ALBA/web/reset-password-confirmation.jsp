<%-- 
    Document   : reset-password-confirmation
    Created on : Feb 24, 2016, 8:47:27 AM
    Author     : armondluthens
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String token = request.getParameter("token");
    String password = request.getParameter("password");
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();

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
    String sqlChangePassword = "UPDATE USERS SET Password='"+ password +"' WHERE UserID='"+ token +"';";
    if(validToken == true){
        stmt.executeUpdate(sqlChangePassword);
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
