<%-- 
    Document   : add-to-cart
    Created on : Mar 9, 2016, 5:34:13 PM
    Author     : armondluthens
--%>


<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="Armond_Test.ShoppingCart"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String qtySelected = request.getParameter("qtySelected");
    String productName = request.getParameter("name");
    int qty = Integer.parseInt(qtySelected);
    String individualPrice = request.getParameter("price");
    float priceInt = Float.parseFloat(individualPrice);
    float totalPrice = qty * priceInt;
    String productID = request.getParameter("id");
    ShoppingCart item = new ShoppingCart(productName, productID, qtySelected, priceInt, totalPrice);
    
    ArrayList<ShoppingCart> currentCart = new ArrayList();
    if(session.getAttribute("myCart") == null){
        currentCart.add(item);
        session.setAttribute("myCart", currentCart);
    }
    else{
        currentCart= (ArrayList)session.getAttribute("myCart");
        currentCart.add(item);
        session.setAttribute("myCart", currentCart);
    }
    
    String redirectURL = "userProductPage.jsp";
    response.sendRedirect(redirectURL);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ID: <%= productID%></h1>
        <h1>Price: <%= individualPrice %></h1>
    </body>
</html>
