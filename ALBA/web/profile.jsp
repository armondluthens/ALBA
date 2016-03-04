<%-- 
    Document   : profile
    Created on : Feb 23, 2016, 4:45:06 PM
    Author     : armondluthens
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String email= "";
    String token= request.getParameter("token");
    String checkForEmail = "SELECT email FROM USERS WHERE UserID = '" + token + "';";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(checkForEmail);
    while(emailRs.next()){
        email = emailRs.getString("email");
    }
    session.setAttribute( "sessionEmail", email );
    
    String firstName="Unknown User";
    String getFirstName = "SELECT FirstName FROM USERS WHERE email = '"+ email +"'";
    ResultSet firstNameRs = stmt.executeQuery(getFirstName);
    while(firstNameRs.next()){
        firstName = firstNameRs.getString("FirstName");
    }
    session.setAttribute( "sessionFirstName", firstName );
    
    String role="Unknown Role";
    String getRole = "SELECT Role FROM USERS WHERE email = '"+ email +"'";
    ResultSet roleRs = stmt.executeQuery(getRole);
    while(roleRs.next()){
        role = roleRs.getString("Role");
    }
    
    /*
    HashMap<String, String> user = new HashMap<>();
    String curString;
    String[] userInformation= {"UserID", "FirstName", "LastName", "Gender", "Email", "Role" };
    String getUserInfo = "SELECT * FROM USERS WHERE email = '"+ email +"'";
    ResultSet getUserInfoRs = stmt.executeQuery(getUserInfo);
    while(getUserInfoRs.next()){
        for(int i=0; i< userInformation.length; i++){
            curString = getUserInfoRs.getString(userInformation[i]);
            user.put(userInformation[i], curString);
        }
    }
    session.setAttribute("sessionLastName", user.get("LastName") );
    session.setAttribute("sessionGender", user.get("Gender"));
    */
    if(role.equals("Unknown Role")){
        response.sendRedirect("index.jsp");
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
            <h1>Hello, <%= firstName %>.</h1>
            <h3>Role: <%= role %></h3>
            <!--
            
            -->
        </div>
            
        <div class="footer">
            <ul>
                <li><a href="deactivateAccount.jsp">Deactivate My Account</a></li>
                <li><a href="index.jsp">Log Out</a></li>
            </ul>
        </div>

    </body>
</html>
