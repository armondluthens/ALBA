<%-- 
    Document   : successfulPurchase
    Created on : Mar 7, 2016, 8:31:00 PM
    Author     : armondluthens
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Armond_Test.ShoppingCart"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    ArrayList<ShoppingCart> currentCart = new ArrayList();
    currentCart= (ArrayList)session.getAttribute("myCart");
    
    String productID = "";
    String qtySelected="";
    int qty=0;
    int sizeOfCart = currentCart.size();
    for(int i=0; i< sizeOfCart; i++){
        ShoppingCart temp = new ShoppingCart();
        temp =  currentCart.get(i);
        qtySelected= temp.getQty();
        qty = Integer.parseInt(qtySelected);
        productID = temp.getID();
        
        String getQuantity = "SELECT Qty FROM PRODUCTS WHERE ProductID='" + productID + "';";
        String qtyReturned="";
        ResultSet qtyRs = stmt.executeQuery(getQuantity);
        while(qtyRs.next()){ 
            qtyReturned = qtyRs.getString("Qty");
        }
        int qtyFromDB = Integer.parseInt(qtyReturned);
        int finalQty = qtyFromDB - qty;
        String updateQty= "UPDATE PRODUCTS SET Qty='"+ finalQty + "' WHERE ProductID='" + productID + "';";
        stmt.executeUpdate(updateQty);
    }
    
    currentCart.clear();
    currentCart = null;
    session.setAttribute("myCart", currentCart);
  
%>
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
            <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
        </div>
        
        <div class="hello-user">
            <h1>Thank you for your purchase, <%= session.getAttribute("sessionFirstName") %>.</h1>
            <h3>You will be receiving an email shortly detailing your order and shipping information.</h3>
        </div>

    </body>
</html>
