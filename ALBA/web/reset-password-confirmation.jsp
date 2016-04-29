<%-- 
    Document   : reset-password-confirmation
    Created on : Feb 24, 2016, 8:47:27 AM
    Author     : armondluthens
--%>

<%@page import="Armond_Test.PasswordEncryption"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String password = request.getParameter("password");
    String email = (String)session.getAttribute("sessionEmail");
    
    PasswordEncryption encryptor = new PasswordEncryption();
    String encryptedPassword = encryptor.encryptPassword(password);
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();


    String sqlChangePassword = "UPDATE USERS SET Password='"+ encryptedPassword +"' WHERE Email='"+ email +"';";
    stmt.executeUpdate(sqlChangePassword);
    response.sendRedirect("userProductPage.jsp");
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
