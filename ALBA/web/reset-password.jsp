<%-- 
    Document   : forgot-password
    Created on : Feb 23, 2016, 7:30:15 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String token = request.getParameter("token");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Password Reset</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
        <script type="text/javascript">
            function validateForm(form){
                var re = /^[\w ]+$/; //regular expression to match only alphanumeric characters and spaces
                //PASSWORD VALIDATION
                if(form.password.value != form.password2.value) {
                    alert("Error: Passwords Do Not Match");
                    form.password.focus();
                    return false;
                }
                if(!re.test(form.password.value)) {
                    alert("Error: Input contains invalid characters");
                    form.password.focus();
                    return false;
                }

                return true; // validation was successful
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="create-user">
            <h1>Reset Password</h1>
            <form method="POST" action="reset-password-confirmation.jsp" onsubmit="return validateForm(this);">
  
            <div class="create-user-field">
                <p>New Password</p>
                <input type="password" name="password" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Re-enter Password</p>
                <input type="password" name="password2" value="" required>
            </div>
            <input type="hidden" name="token" value="<%= token %>">
            <div class="create-user-button">   
                <button type="submit">Reset Password</button>
            </div>
            </form>
        </div>

    </body>
</html>

