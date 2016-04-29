<%-- 
    Document   : handleReturn
    Created on : Apr 28, 2016, 8:12:01 PM
    Author     : armondluthens
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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
 *  Dump claim to database
***********************************************************************/
    String submitClaim = "INSERT INTO DEFECT (ProductID, DateReceived, Description, Category, Email, Reviewed, ClaimNum)";
        String submitClaim2 = "VALUES ('"+ productID +"','"+ date +"','"+ description +"','"+ category +"','"+ email +"','"+ reviewed+"','"+ claimNum +"');";
    try{
        stmt.executeUpdate(submitClaim + submitClaim2);
    }
    catch(Exception e){
        String redirectURL = "userProductPage.jsp";
        response.sendRedirect(redirectURL);
    }
    

/**********************************************************************
 *  Return Check
***********************************************************************/
        boolean returnInStock;
        String getQuantity = "SELECT Qty FROM PRODUCTS WHERE ProductID='"+ productID +"'";
        String quantity="";
        ResultSet qRs = stmt.executeQuery(getQuantity);
        while(qRs.next()){
            quantity = qRs.getString("Qty");
        }
        int qty = Integer.parseInt(quantity);
        String sentence="";
        if(qty>0){
            
            returnInStock = true;
        }
        else{
            returnInStock = false;
        }
        
    //String redirectURL = "userProductPage.jsp";
    //response.sendRedirect(redirectURL);

    

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
        <form method="POST" action="userProductPage.jsp">
            <div class="claimFormat">
                <% if(returnInStock == true){ %>
                    <h2>
                        We apologize for our defect. We have refunded your product and it will be shipped as soon as we can!
                    </h2>
                <% } else{ %>
                    <h2>
                        We apologize for our defect. Unfortunately, we no longer have your product in stock. Please feel free
                        to browse similar products we have in stock.
                    </h2>
                    <input type="hidden" name="search" value="<%= category %>">
                    <button type="submit">View</button>
                <% } %>
                
        </div>
        </form>
        
        <div class="footer">
            <ul>
                <li><a href="#"><h1>ALBA</h1></a></li>
            </ul>
        </div>
       

    </body>
</html>
