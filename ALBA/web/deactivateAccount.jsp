<%-- 
    Document   : deactivateAccount
    Created on : Feb 24, 2016, 9:41:21 AM
    Author     : armondluthens
--%>

<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email= (String)session.getAttribute( "sessionEmail" );
    String firstName= (String)session.getAttribute( "sessionFirstName" );
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>Deactivate Account</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="hello.css">
    </head>
    <body>
        <div class="title-top">
            <% if(session.getAttribute("sessionRole").equals("User")){ %>
                <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } else{ %>
                <a href="managerProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } %>
        </div>
        
        <div class="deactivate">
            <h1>Are you sure you want to deactivate your account?</h1>
            <div class="deactivate-button">
                <a href="deactivateFinal.jsp">YES</a>
            </div>
            <div class="deactivate-button">
                <a href="profile.jsp">NO</a>
            </div>
        </div>
            
        <div class="footer">
            <ul>
                <li><a href="deactivateAccount.jsp">Deactivate My Account</a></li>
                <li><a href="#">Development Team</a></li>
            </ul>
        </div>
       
    </body>
</html>
