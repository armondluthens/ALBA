<%-- 
    Document   : managerSignUp
    Created on : Feb 22, 2016, 6:01:18 PM
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
        <title>ALBA</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
        <script>
            function validateForm() {
                var errorCount=0;
                var phone = document.forms["createUser"]["phoneNumber"].value;
                var phoneStr = String(phone);
                var phoneLen = phoneStr.length;
                var password = document.forms["createUser"]["password"].value;
                var password2 = document.forms["createUser"]["reenterPassword"].value;
                
                if (phoneLen !== 10) {
                    errorCount++;
                }
                if(password !== password2){
                    errorCount++;
                }
                if(errorCount> 0){
                    alert("Errors Detected");
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="create-user">
            <h1>Manager Sign Up</h1>
            
            <form name="createUser" action="hello.jsp" onsubmit="return validateForm()" method="post">
            <div class="create-user-field">
                <p>First Name</p>
                <input type="text" name="firstName" value="" placeholder="John" required>
            </div>
            
            <div class="create-user-field">
                <p>Last Name</p>
                <input type="text" name="lastName" value="" placeholder="Doe" required>
            </div>
            
            <div class="create-user-field">
                <p>E-mail Address</p>
                <input type="email" name="emailAddress" value="" placeholder="john-doe@example.com" required>
            </div>
            
            <div class="create-user-field">
                <p>Phone Number</p>
                <input type="number" name="phoneNumber" value="" placeholder="5555555555" required>
            </div>
            
            <div class="create-user-field">
                <p>Gender</p>
                <div class="gender-field">
                    <select name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>
            </div>
            
            <div class="create-user-field">
                <p>Password</p>
                <input type="password" name="password" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Re-enter Password</p>
                <input type="password" name="reenterPassword" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Manager Code</p>
                <input type="text" name="Code" value="" required>
            </div>
            
            <div class="create-user-button">
                
                <button type="submit">Create Account</button>
                
            </div>
            </form>
        </div>
        
    </body>
</html>

