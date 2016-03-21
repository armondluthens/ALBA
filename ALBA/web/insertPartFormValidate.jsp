<%-- 
    Document   : insertPartFormValidate
    Created on : Mar 11, 2016, 9:40:20 AM
    Author     : armondluthens
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
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
        
        Statement stmt;
        Connection con;
        String url = "jdbc:mysql://localhost:3306/ALBA";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", ""); 
        stmt = con.createStatement();
        
        String sqlInsertPart = "INSERT INTO PRODUCTS (ProductID, ProductName, Price, Qty, Description, Available, ManufactureDate, ExpirationDate, Color, Dimensions)";
        String sqlInsertPartValues = "VALUES ('"+ productID +"','"+ productName +"','"+ price +"','"+ qty +"','"+ description +"','"+ available +"','"+ manufactureDate +"', '"+ expirationDate +"', '"+ color + "', '"+ dimensions +"');";
        
        boolean invalidID= false;
        String checkForID = "SELECT ProductID FROM PRODUCTS WHERE ProductID = '"+ productID +"'";
        String idReturnedFromSQL="";
        ResultSet idRs = stmt.executeQuery(checkForID);
        while(idRs.next()){
            idReturnedFromSQL = idRs.getString("ProductID");
            if(idReturnedFromSQL.equals(productID)){
                invalidID = true;
            }
        }
        String redirectURL="";
        if(invalidID == true){ 
            redirectURL = "insertPartForm.jsp?&productName=" + productName + "&qty=" + qty + "&color=" + color + "&dimensions=" + dimensions;
            response.sendRedirect(redirectURL);
        }
        else{
            stmt.executeUpdate(sqlInsertPart + sqlInsertPartValues);
            redirectURL = "managerProductPage.jsp";
            response.sendRedirect(redirectURL);
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><%= productID %></h1>
        <h1><%= productName %></h1>
        <h1><%= color %></h1>
        <h1><%= dimensions %></h1>
        <h1><%= manufactureDate %></h1>
    </body>
</html>
