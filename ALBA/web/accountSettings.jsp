<%-- 
    Document   : accountSettings
    Created on : Apr 4, 2016, 6:10:19 PM
    Author     : armondluthens
--%>
<%
    String firstName= (String)session.getAttribute("sessionFirstName");
    String lastName= (String)session.getAttribute("sessionLastName");
    String email= (String)session.getAttribute("sessionEmail");
    String phone= (String)session.getAttribute("sessionPhone");
    String gender= (String)session.getAttribute("sessionGender");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Account Settings</title>
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
                if(form.password.value.length < 6){
                    alert("Error: Password must be at least 6 characters long");
                    form.password.focus();
                    return false;
                }
                return true; // validation was successful
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <% if(session.getAttribute("sessionRole").equals("User")){ %>
                <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } else{ %>
                <a href="managerProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } %>
        </div>
        
        <div class="create-user">
            <h1>User Settings</h1>
            <h6><span style="color: orangered;"> *</span> required field</h6>
            
            <form method="POST" action="updateAccount.jsp" onsubmit="return validateForm(this);">
            <div class="create-user-field">
                <p>E-mail Address<span style="color: orangered;"> *</span></p>
                <input type="email" name="emailAddress" value="<%= email %>" placeholder="john-doe@example.com" required readonly>
            </div>
            
            <div class="create-user-field">
                <p>First Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="firstName" value="<%= firstName%>" placeholder="John" required>
            </div>
            
            <div class="create-user-field">
                <p>Last Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="lastName" value="<%= lastName%>" placeholder="Doe" required>
            </div>

            <div class="create-user-field">
                <p>Phone Number<span style="color: orangered;"> *</span></p>
                <input type="number" name="phoneNumber" value="<%= phone%>" placeholder="5555555555" required>
            </div>
            
            <div class="create-user-field">
                <p>Gender<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="gender">
                        <%if(gender.equals("M")){ %>
                            <option selected="selected" value="M">Male</option>
                            <option value="F">Female</option>
                        <%} else{%>
                            <option value="M">Male</option>
                            <option selected="selected" value="F">Female</option>
                        <% } %>
                    </select>
                </div>
            </div>
            
            <input type="hidden" name="role" value="user">
            <div class="create-user-button">   
                <button type="submit">Update Account</button>
            </div>
            </form>
        </div>

    </body>
</html>
