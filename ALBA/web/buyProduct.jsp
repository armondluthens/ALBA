<%-- 
    Document   : buyProduct
    Created on : Mar 7, 2016, 9:17:00 AM
    Author     : armondluthens
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="Armond_Test.ShoppingCart"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String checkNum = request.getParameter("test");
    DecimalFormat dec = new DecimalFormat("#.00");
    String totalString="";
    ArrayList<ShoppingCart> currentCart = new ArrayList();
    String cartEmpty="cart filled";
    float grandTotal=0;
    boolean empty= false;
    if(session.getAttribute("myCart") == null){
        cartEmpty="CART EMPTY";
        totalString= "0.00";
        empty=true;
    }
    else{
        currentCart= (ArrayList)session.getAttribute("myCart");
        ShoppingCart temp = new ShoppingCart();
        
        float tempTotal;
        for(int i=0; i<currentCart.size(); i++){
            temp = currentCart.get(i);
            tempTotal = temp.getTotalPrice();
            grandTotal = grandTotal + tempTotal;
        }
        totalString = dec.format(grandTotal);
        
        //totalString = Float.toString(grandTotal);
        //int len= totalString.length();
        //if(totalString.charAt(len - 1) == '0'){
            //totalString += "0";
        //}
        
    }
    //ShoppingCart tempItem = new ShoppingCart();
    
    
    String name="";
    String id="";
    String qty="";
    float itemPrice=0;
    float totalPrice=0;
    
%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA INC.</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="individual-product.css">
        <link rel="stylesheet" href="product-media.css">
        
        <script type="text/javascript">
            function validateForm(form){
                var price = <%= totalString %>;
                if (form.enterTotal.value == null){
                    return false;
                }   
                if(form.enterTotal.value != price) {
                    alert("Error: Invalid price entered");
                    form.enterTotal.focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <div class="title-top">
            <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
        </div>
        <div class="userbar">
            <h4>Logged In As: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></h4>
        </div>
        
        <div class="search-prod">
            <form action="userProductPage.jsp" method="POST">
                <input type="text" name="search" value="" placeholder="Search for product...">
                <button type="submit">SEARCH</button>
            </form>
        </div>
        <% if(empty == false){%>
            <% for(int i=0; i< currentCart.size(); i++){ %>
                <% ShoppingCart tempItem = new ShoppingCart(); %>
                <% tempItem = currentCart.get(i); %>
                <% name = tempItem.getName(); %>
                <% id = tempItem.getID(); %>
                <% qty = tempItem.getQty(); %>
                <% itemPrice = tempItem.getItemPrice(); %>
                <% totalPrice = tempItem.getTotalPrice(); %>
                <div class="product">
                    <h1><%= name %></h1>
                    <h1>Product ID: <%= id %></h1>
                    <h2>Unit Price: $<%= dec.format(itemPrice) %></h2>
                    <h2>Total Price $<%= dec.format(totalPrice) %></h2>
                    <p>
                        Quantity: <%= qty %>
                    </p>
                </div>
            <% } %>
        <% } %>
        
        <% if(empty==false){ %>
        <form action="successfulPurchase.jsp" method="POST" onsubmit="return validateForm(this);">
        <div class="total">
            <h1>CHECKOUT TOTAL: $<%= totalString %></h1>
            <input type="text" name="enterTotal" value="" placeholder="Enter Total Price...">
            <button type="submit">PURCHASE</button>
        </div>
        <%} else{ %>
            <div class="total">
                <h2>CART IS EMPTY.</h2>
            </div>
        <% } %>
        <div class="footer">
            <ul>
                <li><a href="userProductPage.jsp">Home</a></li>
                <li><a href="#">&bull;</a></li>
                <li><a href="index.jsp">Log Out</a></li>
            </ul>
        </div>
        </div>
    </body>
</html>

