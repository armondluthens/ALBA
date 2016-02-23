<%-- 
    Document   : hello
    Created on : Feb 22, 2016, 5:49:12 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName = request.getParameter("firstName");
    String gender = request.getParameter("gender");
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
        </div>

    </body>
</html>

