<%-- 
    Document   : editPartFormValidate
    Created on : Mar 21, 2016, 2:10:11 PM
    Author     : armondluthens
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    
    String productName = request.getParameter("productName");
    String productID = request.getParameter("productID");
    String price = request.getParameter("price");
    String qty = request.getParameter("qty");
    String color = request.getParameter("color");
    String dimensions = request.getParameter("dimensions");
    String available=request.getParameter("available");
    String manufactureDate=request.getParameter("manufactureDate");
    String expirationDate=request.getParameter("expirationDate");
    String description = request.getParameter("description");
    String category=request.getParameter("category123");
    String supplier = request.getParameter("supplier123");
        
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String update= "UPDATE PRODUCTS SET productName='"+ productName +"', Price='"+ price +"', Qty='"+ qty +"', Description='"+ description +"', Available='"+ available +"', ManufactureDate='"+ manufactureDate +"', ExpirationDate='"+ expirationDate +"', Color='"+ color + "', Dimensions='"+ dimensions +"', Category='"+ category+ "', Supplier='"+ supplier +"' WHERE ProductID='"+ productID +"';";
    stmt.executeUpdate(update);
    response.sendRedirect("managerProductPage.jsp");
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
