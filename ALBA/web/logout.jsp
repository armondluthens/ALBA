<%-- 
    Document   : logout
    Created on : Apr 11, 2016, 6:34:37 PM
    Author     : armondluthens
--%>
<%
    session.setAttribute("LoggedIn", "0");
    String redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
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
    </body>
</html>
