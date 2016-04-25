<%-- 
    Document   : confirmOrder
    Created on : Apr 19, 2016, 6:23:41 PM
    Author     : armondluthens
--%>

<%-- 
    Document   : viewClaim
    Created on : Apr 7, 2016, 1:55:10 PM
    Author     : armondluthens
--%>

<%@page import="java.util.HashMap"%>
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
    
    String address1=request.getParameter("address1");
    String address2=request.getParameter("address2");
    String city=request.getParameter("city");
    String state=request.getParameter("state");
    String zip=request.getParameter("zip");
    String price=request.getParameter("price");
    
    String smallCount= request.getParameter("small");
    String mediumCount= request.getParameter("medium");
    String largeCount= request.getParameter("large");
    String xlCount= request.getParameter("xl");
        
        
%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Review Order</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="product.css">
        <link rel="stylesheet" href="product-media.css">
        <script>
        /* When the user clicks on the button, 
t       oggle between hiding and showing the dropdown content */
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
            <% if(session.getAttribute("sessionRole").equals("User")){ %>
                <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } else{ %>
                <a href="managerProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } %>
        </div>
        <div class="userbar">
            <div class="dropdown">
                <button onclick="myFunction()" class="dropbtn">Account: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></button>
                <div id="myDropdown" class="dropdown-content">
                    <a href="accountSettings.jsp">Account Settings</a>
                    <a href="reset-password.jsp">Reset Password</a>
                    <a href="deactivateAccount.jsp">Deactivate Account</a>
                    <a href="index.jsp">Logout</a>
                </div>
            </div>
            <!--<h4>Logged In As: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></h4>-->
        </div>
        
        <% if(session.getAttribute("sessionRole").equals("Admin")){ %>
            <div class="selectView">
                <a href="userProductPage.jsp">User View</a>
                <a href="#"><span style="border-bottom: 4px solid orangered;">Manager View</span></a>
            </div>
        <%} %>
        
        <form method="POST" action="successfulPurchase.jsp">
            <div class="claimFormat">
                
                <h1>Please Review Your Order</h1>
                <h2>Address 1: <span style="color: orangered;"><%= address1 %></span></h2>
                <h2>Address 2: <span style="color: orangered;"><%= address2 %></span></h2>
                <h2>City: <span style="color: orangered;"><%= city %></span></h2>
                <h2>State: <span style="color: orangered;"><%= state %></span></h2>
                <h2>Zip Code: <span style="color: orangered;"><%= zip %></span></h2>
                <h2>Total Price: <span style="color: orangered;">$<%= price %></span></h2>
                
                <input type="hidden" name="small" value="<%= smallCount %>">
                <input type="hidden" name="medium" value="<%= mediumCount %>">
                <input type="hidden" name="large" value="<%= largeCount %>">
                <input type="hidden" name="xl" value="<%= xlCount %>">
                
                <button type="submit">Place Order</button>
        </div>
        </form>
        
        <div class="footer">
            <ul>
                <li><a href="#"><h1>ALBA</h1></a></li>
            </ul>
        </div>
    </body>
</html>

