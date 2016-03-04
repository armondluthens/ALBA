<%-- 
    Document   : userSignUp
    Created on : Feb 22, 2016, 6:01:46 PM
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
        <title>ALBA | User Sign Up</title>
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

                return true; // validation was successful
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <a href="index.jsp"><h1>ALBA, INC.</h1></a>
        </div>
        
        <div class="create-user">
            <h1>User Sign Up <span><%= enterValidEmail %></span></h1>
            <h6><span style="color: orangered;"> *</span> required field</h6>
            <h6><span style="color: orangered;"> **</span> password must be alphanumeric and at least 6 characters (only letters and numbers)</h6>
            
            <form method="POST" action="hello.jsp" onsubmit="return validateForm(this);">
            <div class="create-user-field">
                <p>First Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="firstName" value="<%= firstName%>" placeholder="John" required>
            </div>
            
            <div class="create-user-field">
                <p>Last Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="lastName" value="<%= lastName%>" placeholder="Doe" required>
            </div>
            
            <div class="create-user-field">
                <p>E-mail Address<span style="color: orangered;"> *</span></p>
                <input type="email" name="emailAddress" value="" placeholder="john-doe@example.com" required>
            </div>
            
            <div class="create-user-field">
                <p>Phone Number<span style="color: orangered;"> *</span></p>
                <input type="number" name="phoneNumber" value="<%= phone%>" placeholder="5555555555" required>
            </div>
            
            <div class="create-user-field">
                <p>Gender<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="gender">
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                    </select>
                </div>
            </div>
            
            <div class="create-user-field">
                <p>Password <span style="color: orangered;"> **</span></p></p>
                <input type="password" name="password" value="" required>
            </div>
            
            <div class="create-user-field">
                <p>Re-enter Password <span style="color: orangered;"> **</span></p></p>
                <input type="password" name="password2" value="" required>
            </div>
            <input type="hidden" name="formType" value="user">
            <div class="create-user-button">   
                <button type="submit">Create Account</button>
            </div>
            </form>
        </div>

    </body>
</html>

