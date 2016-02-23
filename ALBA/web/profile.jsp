<%-- 
    Document   : profile
    Created on : Feb 23, 2016, 4:45:06 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName="Null User";
    String email= request.getParameter("email");
    String password= request.getParameter("password");
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    boolean validUser= false;
    String checkForEmail = "SELECT email FROM USERS WHERE email = '" + email + "' AND password = '"+ password+"' ";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(checkForEmail);
    while(emailRs.next()){
        emailReturnedFromSQL = emailRs.getString("email");
        if(emailReturnedFromSQL.equals(email)){
            validUser = true;
        }
    }
    
    String redirectURL = "";
    if(validUser == true){
        firstName="Michael Franti";
        
        String getFirstName = "SELECT FirstName FROM USERS WHERE email = '" + email + "'";
        String firstNameReturnedFromSQL="";
        ResultSet firstNameRs = stmt.executeQuery(getFirstName);
        while(firstNameRs.next()){
            firstName = firstNameRs.getString("FirstName");
        }
        
    }
    else{
        redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>Thank You!</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="hello.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="hello-user">
            <h1>Hello, <%= firstName %>.</h1>
            <h3>Create your profile.</h3>
            <!--
            
            -->
        </div>

    </body>
</html>
