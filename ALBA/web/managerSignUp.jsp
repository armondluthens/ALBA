<%-- 
    Document   : managerSignUp
    Created on : Feb 22, 2016, 6:01:18 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String enterValidEmail = "";
    
    String firstName = "";
    String lastName = "";
    String phone = "";
    String gender = "";
    String code = "";
    
    if(request.getParameter("firstName") != null){
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        phone = request.getParameter("phoneNumber");
        gender = request.getParameter("gender");
        code = request.getParameter("code");
        
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
        <title>ALBA | Manager Sign Up</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
        <script type="text/javascript">
            function validateForm(form){
                var re = /^[\w ]+$/; //regular expression to match only alphanumeric characters and spaces
                //FIRST NAME VALIDATION
                if(form.firstName.value.length > 30) {
                    alert("First Name Must be less than 30 characters");
                    form.password.focus();
                    return false;
                }
                if(!re.test(form.firstName.value)) {
                    alert("Error: Input contains invalid characters");
                    form.password.focus();
                    return false;
                }
                
                //LAST NAME VALIDATION
                if(form.lastName.value.length > 30) {
                    alert("Last name must be less than 30 characters");
                    form.password.focus();
                    return false;
                }
                if(!re.test(form.lastName.value)) {
                    alert("Error: Input contains invalid characters");
                    form.password.focus();
                    return false;
                }
                
                //PHONE NUMBER VALIDATION
                if(form.phoneNumber.value.length != 10){
                    alert("Error: Phone number is invalid");
                    form.phoneNumber.focus();
                    return false;
                }
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
                //MANAGER CODE VALIDATION
                var codeNum = form.Code.value;
                var codeString = String(codeNum);
                var firstDigit = codeString.charAt(0);
                
                if(firstDigit != "1") {
                    alert("Error: Invalid Manager Code");
                    form.password.focus();
                    return false;
                }
                if(codeString.length != 5){
                    alert("Error: Invalid Manager Code");
                    form.password.focus();
                    return false;
                }

                return true; // validation was successful
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC. <span><%= enterValidEmail %></h1>
        </div>
        
        <div class="create-user">
            <h1>Manager Sign Up</h1>
            
            <form method="POST" action="hello.jsp" onsubmit="return validateForm(this);">
            <div class="create-user-field">
                <p>First Name</p>
                <input type="text" name="firstName" value="<%= firstName %>" placeholder="John" required>
            </div>
            
            <div class="create-user-field">
                <p>Last Name</p>
                <input type="text" name="lastName" value="<%= lastName %>" placeholder="Doe" required>
            </div>
            
            <div class="create-user-field">
                <p>E-mail Address</p>
                <input type="email" name="emailAddress" value="" placeholder="john-doe@example.com" required>
            </div>
            
            <div class="create-user-field">
                <p>Phone Number</p>
                <input type="number" name="phoneNumber" value="<%= phone %>" placeholder="5555555555" required>
            </div>
            
            <div class="create-user-field">
                <p>Gender</p>
                <div class="gender-field">
                    <select name="gender">
                        <option value="<%= gender %>">Male</option>
                        <option value="<%= gender %>">Female</option>
                    </select>
                </div>
            </div>
            
            <div class="create-user-field">
                <p>Password</p>
                <input type="password" name="password" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Re-enter Password</p>
                <input type="password" name="password2" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Manager Code</p>
                <input type="number" name="Code" value="<%= code %>" required>
            </div>
            <input type="hidden" name="formType" value="manager">
            <div class="create-user-button">
                <button type="submit">Create Account</button>
            </div>
            </form>
        </div>
        
    </body>
</html>

