<%-- 
    Document   : hello
    Created on : Feb 22, 2016, 5:49:12 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("emailAddress");
    String phone = request.getParameter("phoneNumber");
    String gender = request.getParameter("gender");
    String password = request.getParameter("password");
    

    //INSERT VARIABABLE INTO DB
    //CALL METHOD TO EMAIL
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="hello.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="hello-user">
            <h1>Thank you for signing up, <%= firstName %></h1>
            <h3>You will be receiving an email shortly.</h3>
            <h3>First Name: <%= firstName %></h3>
            <h3>Last Name: <%= lastName %></h3>
            <h3>Email: <%= email %></h3>
            <h3>Phone: <%= phone %></h3>
            <h3>Gender: <%= gender %></h3>
            <h3>Password: <%= password %></h3>
            
        </div>

    </body>
</html>

