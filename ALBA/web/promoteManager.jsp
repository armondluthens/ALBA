<%-- 
    Document   : promoteManager
    Created on : Apr 7, 2016, 11:52:35 AM
    Author     : armondluthens
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%
    String managerEmail = request.getParameter("managerSelected");
    if(managerEmail.equals("")){
        response.sendRedirect("managerProductPage.jsp");
    }
    else{
        Statement stmt;
        Connection con;
        String url = "jdbc:mysql://localhost:3306/ALBA";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", ""); 
        stmt = con.createStatement();
    
        String promoteManagerToAdmin = "UPDATE USERS SET Role='Admin' WHERE Email='"+ managerEmail +"';";

        stmt.executeUpdate(promoteManagerToAdmin);
        response.sendRedirect("managerProductPage.jsp");
    }
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><%= managerEmail %></h1>
    </body>
</html>