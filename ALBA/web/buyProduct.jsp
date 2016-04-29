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
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    
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
    String size="";
    float itemPrice=0;
    float totalPrice=0;
    
    int smallCount=0;
    int mediumCount=0;
    int largeCount=0;
    int xlCount=0;
%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Shopping Cart</title>
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
             
        /* When the user clicks on the button, toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

            // Close the dropdown menu if the user clicks outside of it
            window.onclick = function(event) {
              if (!event.target.matches('.dropbtn')) {

                var dropdowns = document.getElementsByClassName("dropdown-content");
                var i;
                for (i = 0; i < dropdowns.length; i++) {
                  var openDropdown = dropdowns[i];
                  if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                  }
                }
              }
            }

        </script>
    </head>
    <body>
        <div class="title-top">
            <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
        </div>
        <div class="userbar">
            <div class="dropdown">
                <button onclick="myFunction()" class="dropbtn">Account: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></button>
                <div id="myDropdown" class="dropdown-content">
                    <a href="accountSettings.jsp">Account Settings</a>
                    <a href="reset-password.jsp">Reset Password</a>
                    <a href="deactivateAccount.jsp">Deactivate Account</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
            <!--<h4>Logged In As: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></h4>-->
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
                <% size = tempItem.getSize(); %>
                
                <% 
                    if(size.equals("Small")){ 
                        smallCount++;
                    } else if(size.equals("Medium")){ 
                        mediumCount++;
                    } else if(size.equals("Large")){ 
                        largeCount++;
                    } else{ 
                        xlCount++;
                    } 
                %>
                <div class="product">
                    <h1><%= name %></h1>
                    <h1>Product ID: <%= id %></h1>
                    <h2>Unit Price: $<%= dec.format(itemPrice) %></h2>
                    <h2>Total Price $<%= dec.format(totalPrice) %></h2>
                    <h2>Size: <%= size %></h2>
                    <p>
                        Quantity: <%= qty %>
                    </p>
                </div>
            <% } %>
        <% } %>
        
        <% if(empty==false){ %>
        <form action="shippingAddress.jsp" method="POST" onsubmit="return validateForm(this);">
   
        <div class="total">
            <h1>CHECKOUT TOTAL: $<%= totalString %></h1>
            <input type="text" name="enterTotal" value="" placeholder="Enter Total Price...">
            <input type="hidden" name="small" value="<%= smallCount %>">
            <input type="hidden" name="medium" value="<%= mediumCount %>">
            <input type="hidden" name="large" value="<%= largeCount %>">
            <input type="hidden" name="xl" value="<%= xlCount %>">
            <button type="submit">Check Out</button>
        </div>
        </form>
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

