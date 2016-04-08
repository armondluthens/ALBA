<%-- 
    Document   : submitDefect
    Created on : Apr 7, 2016, 12:42:22 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
/**********************************************************************
 *  Variables Passed In
 ***********************************************************************/
    String email= (String)session.getAttribute("sessionEmail");
    String claimNum= request.getParameter("claimNum");
    String productID= request.getParameter("productID");
    String date= request.getParameter("datePurchased");
    String category= request.getParameter("category");
    String description= request.getParameter("defectDescription");
    String reviewed= "0";

/**********************************************************************
*   Connect To Database
***********************************************************************/
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();

/**********************************************************************
 *  
***********************************************************************/
    String submitClaim = "INSERT INTO DEFECT (ProductID, DateReceived, Description, Category, Email, Reviewed, ClaimNum)";
    String submitClaim2 = "VALUES ('"+ productID +"','"+ date +"','"+ description +"','"+ category +"','"+ email +"','"+ reviewed+"','"+ claimNum +"');";
        
    String redirectURL="";

    stmt.executeUpdate(submitClaim + submitClaim2);
    redirectURL = "userProductPage.jsp";
    response.sendRedirect(redirectURL);
%>

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
