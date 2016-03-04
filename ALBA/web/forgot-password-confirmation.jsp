<%-- 
    Document   : forgot-password-confirmation
    Created on : Feb 23, 2016, 7:48:26 PM
    Author     : armondluthens
--%>

<%@page import="Armond_Test.ResetPasswordEmail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.sql.*" %>
<%@page import="Armond_Test.TokenGenerator"%>
<%@page import="Armond_Test.EmailConfirmation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String formType = request.getParameter("formType");
    String email = request.getParameter("emailAddress");
    //String token = TokenGenerator.generate();
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String token = "";
    String getToken = "SELECT UserID FROM USERS WHERE email = '"+ email +"'";
    ResultSet tokenRs = stmt.executeQuery(getToken);
    while(tokenRs.next()){
        token = tokenRs.getString("UserID");
    }
    
    boolean validEmail= false;
    String checkForEmail = "SELECT email FROM USERS WHERE email = '"+ email +"'";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(checkForEmail);
    while(emailRs.next()){
        emailReturnedFromSQL = emailRs.getString("email");
        if(emailReturnedFromSQL.equals(email)){
            validEmail = true;
        }
    }
   
    if(validEmail == true){
        ResetPasswordEmail resetPassword = new ResetPasswordEmail();
        resetPassword.sendActivation(email, "User", token);
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
        <title>Password Reset</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="hello.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        <div class="hello-user">
            <h3><%= email%>, you will be receiving an email shortly to reset your password.</h3>  
        </div>

    </body>
</html>