<%-- 
    Document   : approveManager
    Created on : Apr 21, 2016, 9:51:26 PM
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
    
        String approveManager = "UPDATE USERS SET AdminApproved='1' WHERE Email='"+ managerEmail +"';";

        stmt.executeUpdate(approveManager);
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
        <h1>Hello World!</h1>
    </body>
</html>
