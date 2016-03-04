<%-- 
    Document   : hello
    Created on : Feb 22, 2016, 5:49:12 PM
    Author     : armondluthens
--%>

<%@page import="Armond_Test.PasswordEncryption"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.sql.*" %>
<%@page import="Armond_Test.TokenGenerator"%>
<%@page import="Armond_Test.EmailConfirmation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String formType = request.getParameter("formType");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("emailAddress");
    String phone = request.getParameter("phoneNumber");
    String gender = request.getParameter("gender");
    String password = request.getParameter("password");
    String code = request.getParameter("Code");
    String token = TokenGenerator.generate();
    String fullName= firstName + " " + lastName;
    String role="";
    
    //ENCRYPT PASSWORD
    PasswordEncryption encryptor = new PasswordEncryption();
    String encryptedPassword = encryptor.encryptPassword(password);
    
    boolean validCode = false;
    if(formType.equals("user")){
        role = "User";
        validCode = true;
    }
    else if(formType.equals("manager")){
        role = "Manager";
    }
    else{
        role = "Admin";
    }
    
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    if(formType.equals("admin")){
        String checkForAdminCode = "SELECT Code FROM ADMIN_CODES WHERE Code = '"+ code +"' AND FirstName='" +firstName + "' AND LastName= '"+ lastName + "'; ";
        String codeFromSQL="";
        ResultSet codeRs = stmt.executeQuery(checkForAdminCode);
        while(codeRs.next()){
            codeFromSQL = codeRs.getString("Code");
            if(codeFromSQL.equals(code)){
                validCode = true;
            }
        }
    }
    
    if(formType.equals("manager")){
        String checkForManagerCode = "SELECT Code FROM MANAGER_CODES WHERE Code = '"+ code +"' AND FirstName='" +firstName + "' AND LastName= '"+ lastName + "'; ";
        String codeFromSQL="";
        ResultSet codeRs = stmt.executeQuery(checkForManagerCode);
        while(codeRs.next()){
            codeFromSQL = codeRs.getString("Code");
            if(codeFromSQL.equals(code)){
                validCode = true;
            }
        }
    }
    
    boolean invalidEmail= false;
    String checkForEmail = "SELECT email FROM USERS WHERE email = '"+ email +"'";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(checkForEmail);
    while(emailRs.next()){
        emailReturnedFromSQL = emailRs.getString("email");
        if(emailReturnedFromSQL.equals(email)){
            invalidEmail = true;
        }
    }
    //String sqlInsertNewUser = "INSERT INTO USER (username, first_name, last_name, phone, email, password, confirmed)";
    //String sqlInsertValues = "VALUES ('user','"+firstName+"','"+lastName+"','"+phone+"','"+email+"','"+password+"', 1);";
    
    String sqlInsertNewUser2 = "INSERT INTO USERS (UserID, FirstName, LastName, Gender, Phone, Email, Password, Activated, Role)";
    String sqlInsertValues2 = "VALUES ('"+ token +"','"+firstName+"','"+lastName+"','"+ gender +"','"+ phone +"','"+ email +"', '"+ encryptedPassword +"', '0', '"+ role +"');";

    String redirectURL = "";
    //IF EMAIL ALREADY EXISTS IN DATABASE
    if(invalidEmail == true || validCode == false){
        if(formType.equals("user")){
            redirectURL = "userSignUp.jsp?&firstName=" + firstName + "&lastName=" + lastName + "&phoneNumber=" + phone + "&gender=" + gender;
            response.sendRedirect(redirectURL);
        }
        else if(formType.equals("manager")){
            redirectURL = "managerSignUp.jsp?&first=" + firstName + "&lastName=" + lastName + "&phoneNumber=" + phone + "&gender=" + gender + "&code=" + code;
            response.sendRedirect(redirectURL);
        }
        else{
            redirectURL = "adminSignUp.jsp?&first=" + firstName + "&lastName=" + lastName + "&phoneNumber=" + phone + "&gender=" + gender + "&code=" + code;
            response.sendRedirect(redirectURL);
        }
    }
    else{
        //INSERT RECORD INTO DATABASE
        stmt.executeUpdate(sqlInsertNewUser2 + sqlInsertValues2);
        EmailConfirmation emailTest = new EmailConfirmation();
        emailTest.sendActivation(email, fullName, token);
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
        <title>Thank You!</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="hello.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
        </div>
        
        <div class="hello-user">
            <h1>Thank you for signing up, <%= firstName %>.</h1>
            <h3>You will be receiving an email shortly.</h3>
            
            <h3>Form Type: <%= formType %></h3>
            <h3>Last Name: <%= lastName %></h3>
            <h3>Email: <%= email %></h3>
            <h3>Phone: <%= phone %></h3>
            <h3>Gender: <%= gender %></h3>
            <h3>Password: <%= password %></h3>
            <h3>Code: <%= code %></h3>
            
        </div>

    </body>
</html>

