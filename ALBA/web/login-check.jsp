<%-- 
    Document   : login-check
    Created on : Feb 24, 2016, 10:11:48 AM
    Author     : armondluthens
--%>
<%@page import="Armond_Test.PasswordEncryption"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%
    String email= request.getParameter("email");
    String password= request.getParameter("password");
    String redirectURL = "";
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    //CHECK FOR EMAIL IN DB
    String getEmail = "SELECT Email FROM USERS WHERE Email = '" + email + "';";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(getEmail);
    while(emailRs.next()){
        emailReturnedFromSQL = emailRs.getString("Email");
    }
    if(emailReturnedFromSQL.equals("")){
        //password="";
        redirectURL = "index.jsp?&invalidLoginAttempt=1";
        response.sendRedirect(redirectURL);
    }
    else{
        String getPassword = "SELECT password FROM USERS WHERE email = '" + email + "';";
        String passwordReturnedFromSQL="";
        ResultSet passRs = stmt.executeQuery(getPassword);
        while(passRs.next()){
            passwordReturnedFromSQL = passRs.getString("Password");
        }
        //DECRYPT PASSWORD
        PasswordEncryption decryptor = new PasswordEncryption();
        String decryptedPassword = decryptor.decryptPassword(passwordReturnedFromSQL);

        String getActivation = "SELECT activated FROM USERS WHERE email = '" + email + "';";
        String activationReturnedFromSQL="";
        ResultSet actRs = stmt.executeQuery(getActivation);
        while(actRs.next()){
            activationReturnedFromSQL = actRs.getString("Activated");
        }

        String getRole = "SELECT Role FROM USERS WHERE email = '" + email + "';";
        String roleReturnedFromSQL="";
        ResultSet roleRs = stmt.executeQuery(getRole);
        while(roleRs.next()){
            roleReturnedFromSQL = roleRs.getString("Role");
        }

        boolean validUser= false;
        if(password.equals(decryptedPassword)  && activationReturnedFromSQL.equals("1")){
            validUser = true;
        }

        String checkForToken = "SELECT UserID FROM USERS WHERE email = '"+ email +"'";
        String token="";
        ResultSet tokenRs = stmt.executeQuery(checkForToken);
        while(tokenRs.next()){
            token = tokenRs.getString("UserID");
        }

        if(validUser == true){
            if(roleReturnedFromSQL.equals("Manager") ||roleReturnedFromSQL.equals("Admin")){
                session.setAttribute("LoggedIn", "1");
                redirectURL = "managerProductPage.jsp?&token=" + token;
                //redirectURL = "userProductPage.jsp?&token=" + token;
                response.sendRedirect(redirectURL);
            }
            else{
                session.setAttribute("LoggedIn", "1");
                redirectURL = "userProductPage.jsp?&token=" + token;
                //redirectURL = "managerProductPage.jsp?&token=" + token;
                response.sendRedirect(redirectURL);
            }
        }
        else{
            redirectURL = "index.jsp?&invalidLoginAttempt=1";
            response.sendRedirect(redirectURL);
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <input type="hidden" name="emailInput" value="<%= email %>">
        <input type="hidden" name="invalidInput" value="1">
    </body>
</html>
