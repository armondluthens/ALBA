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
    
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    int qtyNotAvailable=0;
    String trackingTime="";
    
    String smallCount= request.getParameter("small");
    String mediumCount= request.getParameter("medium");
    String largeCount= request.getParameter("large");
    String xlCount= request.getParameter("xl");

    ArrayList<ShoppingCart> currentCart = new ArrayList();
    if((ArrayList)session.getAttribute("myCart") == null){
        response.sendRedirect("userProductPage.jsp");
    }
    else{
        currentCart= (ArrayList)session.getAttribute("myCart");
    }
    
    if(mediumCount.equals("0") && largeCount.equals("0") && xlCount.equals("0")){
            trackingTime="1-3";
        }
        else if(largeCount.equals("0") && xlCount.equals("0")){
            trackingTime="3-5";
        }
        else{
            trackingTime="5-7";
        }
        Statement stmt;
        Connection con;
        String url = "jdbc:mysql://localhost:3306/ALBA";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", ""); 
        stmt = con.createStatement();

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

        //IF NOT ENOUGH QUANTITY

        int finalQty =0;

        if(qtyFromDB < qty){
            qtyNotAvailable= qty - qtyFromDB;
            finalQty = qtyFromDB;
        }
        else{
            finalQty = qtyFromDB - qty;
        }


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
            
            <% if(qtyNotAvailable > 0){ %>
                <h1>Unfortunately, We have run out of stock and <%= qtyNotAvailable %> of your
                    products were unable to be shipped. We are working to order more and satisfy
                    your order.
                </h1>
            <% } %>
            <h3>You will be receiving an email shortly detailing your order and shipping information.</h3>
            <h3>Your order should take <%= trackingTime %> days for delivery</h3>
           
        </div>

    </body>
</html>
