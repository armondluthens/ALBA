<%-- 
    Document   : forgot-password
    Created on : Feb 23, 2016, 7:40:56 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String enterValidEmail = "";
    
    String firstName = "";
    String lastName = "";
    String phone = "";
    String gender = "";
  
    if(request.getParameter("firstName") != null){
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        phone = request.getParameter("phoneNumber");
        gender = request.getParameter("gender");
        
        enterValidEmail = "-- Email Has Already Been Used";
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
        <title>ALBA | Forgot Password</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
        
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="create-user">
            <h1>Find Your Alba Account </h1>
            
            <form method="POST" action="forgot-password-confirmation.jsp" onsubmit="return validateForm(this);">
                <div class="create-user-field">
                    <p>E-mail Address</p>
                    <input type="email" name="emailAddress" value="" placeholder="john-doe@example.com" required>
                </div>

                <input type="hidden" name="formType" value="user">
                <div class="create-user-button">   
                    <button type="submit">Go, Go, Go!</button>
                </div>
            </form>
        </div>

    </body>
</html>
