<%-- 
    Document   : insertPartForm
    Created on : Mar 11, 2016, 8:58:47 AM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    
    String enterValidProductID = "";
    
    String productName = "";
    String productID = "";
    String price = "";
    String qty = "";
    String description = "";
    String color = "";
    String dimensions = "";
    String manufactureDate="";
    String expirationDate="";
    String category="";
    String supplier="";
  
    if(request.getParameter("productName") != null){
        productName = request.getParameter("productName");
        productID = request.getParameter("productID");
        price = request.getParameter("price");
        qty = request.getParameter("qty");
        description = request.getParameter("description");
        color = request.getParameter("color");
        dimensions = request.getParameter("dimensions");
        manufactureDate=request.getParameter("manufactureDate");
        expirationDate=request.getParameter("expirationDate");
        manufactureDate=request.getParameter("category");
        expirationDate=request.getParameter("supplier");
        
        
        enterValidProductID = "-- Product ID Has Already Been Used";
    }
   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Insert Part</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
    </head>
    <body>
        <div class="title-top">
            <a href="managerProductPage.jsp"><h1>ALBA, INC.</h1></a>
        </div>
        
        <div class="create-user">
            <h1>Insert New Product <span><%= enterValidProductID %></span></h1>
            
            <form method="POST" action="insertPartFormValidate.jsp">
            <div class="create-user-field">
                <p>Product Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="productName" value="<%= productName%>" placeholder="" required>
            </div>
            
            <div class="create-user-field">
                <p>Serial No.<span style="color: orangered;"> *</span></p>
                <input type="text" name="productID" value="<%= productID %>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Price<span style="color: orangered;"> *</span></p>
                <input type="number" name="price" value="<%= price %>" placeholder="" required>
            </div>
            
            <div class="create-user-field">
                <p>Quantity<span style="color: orangered;"> *</span></p>
                <input type="number" name="qty" value="<%= qty %>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Description<span style="color: orangered;"> *</span></p>
                <input type="text" name="description" value="<%= description %>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Color<span style="color: orangered;"> *</span></p>
                <input type="text" name="color" value="<%= color %>" placeholder="" required>
            </div>
            <!--
            <div class="create-user-field">
                <p>Dimensions<span style="color: orangered;"> *</span></p>
                <input type="text" name="dimensions" value="<%= dimensions %>" placeholder="" required>
            </div>
            -->
            <div class="create-user-field">
                <p>Dimensions<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="dimensions">
                        <option value="Small">Small</option>
                        <option value="Medium">Medium</option>
                        <option value="Large">Large</option>
                        <option value="Extra Large">Extra Large</option>
                    </select>
                </div>
            </div>
            
            <div class="create-user-field">
                <p>Available to Users<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="available">
                        <option value="1">Yes</option>
                        <option value="0">No</option>
                    </select>
                </div>
            </div>
            <div class="create-user-field">
                <p>Manufacture Date<span style="color: orangered;"> *</span></p>
                <input type="date" name="manufactureDate" value="<%= manufactureDate %>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Expiration Date<span style="color: orangered;"> *</span></p>
                <input type="date" name="expirationDate" value="<%= expirationDate %>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Category<span style="color: orangered;"> *</span></p>
                <input type="text" name="category123" value="<%= productName%>" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Supplier<span style="color: orangered;"> *</span></p>
                <input type="text" name="supplier123" value="<%= productID %>" placeholder="" required>
            </div>
            <div class="create-user-button">   
                <button type="submit">INSERT PART</button>
            </div>
            </form>
        </div>

    </body>
</html>


