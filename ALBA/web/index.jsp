<%-- 
    Document   : index
    Created on : Feb 22, 2016, 5:44:40 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>JUICE</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="login-page.css">
        <link rel="stylesheet" href="login-page-media.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
                <div class="username">
                    <input type="text" name="email" value="" placeholder="john-doe@example.com">
                    
                    <div class="check">
                        <input type="checkbox" name="new-item" value="new">
                        
                    </div>
                    <p>Remember Me</p>
                    
                </div>
                <div class="password">
                    <input type="password" name="password" value="">
                    <p><a href="#">Forgot Password</a></p>
                </div>
                <div class="login-button">
                        <button type="submit">Sign In</button>
                </div>
        </div>
        
        <div class="signup">
            <h1>New to ALBA? Join Today!</h1>
            <div class="signup-button">
                <a href="userSignUp.jsp">Sign Up As User</a>
            </div>
            <div class="signup-button">
                <a href="managerSignUp.jsp">Sign Up As Manager</a>
            </div>
            <div class="signup-button">
                <a href="adminSignUp.jsp">Sign Up As Administrator</a>
            </div>
        </div>
        
        <div class="footer">
            <ul>
                <li><a href="#">Membership Types</a></li>
                <li><a href="#">Development Team</a></li>
            </ul>
        </div>

    </body>
</html>
