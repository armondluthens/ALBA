<%-- 
    Document   : shippingAddress
    Created on : Apr 19, 2016, 5:57:26 PM
    Author     : armondluthens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    
   String priceTotal= request.getParameter("enterTotal");
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
        <title>ALBA | Shipping Address</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">

    </head>
    <body>
        <div class="title-top">
            <% if(session.getAttribute("sessionRole").equals("User")){ %>
                <a href="userProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } else{ %>
                <a href="managerProductPage.jsp"><h1>ALBA, INC.</h1></a>
            <% } %>
        </div>
        
        <div class="create-user">
            
            <h1>Enter Shipping Address</h1>
            <h6><span style="color: orangered;"> *</span> required field</h6>
            
            <form method="POST" action="confirmOrder.jsp">
            <div class="create-user-field">
                <p>Address 1<span style="color: orangered;"> *</span></p>
                <input type="text" name="address1" value="" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Address 2<span style="color: orangered;"> *</span></p>
                <input type="text" name="address2" value="" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>City<span style="color: orangered;"> *</span></p>
                <input type="text" name="city" value="" placeholder="" required>
            </div>
            
            <div class="create-user-field">
                <p>State<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="state">
                        <option value="AL">Alabama</option>
                        <option value="AK">Alaska</option>
                        <option value="AZ">Arizona</option>
                        <option value="AR">Arkansas</option>
                        <option value="CA">California</option>
                        <option value="CO">Colorado</option>
                        <option value="CT">Connecticut</option>
                        <option value="DE">Delaware</option>
                        <option value="FL">Florida</option>
                        <option value="GA">Georgia</option>
                        <option value="HI">Hawaii</option>
                        <option value="ID">Idaho</option>
                        <option value="IL">Illinois</option>
                        <option value="IN">Indiana</option>
                        <option value="IA">Iowa</option>
                        <option value="KS">Kansas</option>
                        <option value="KY">Kentucky</option>
                        <option value="LA">Louisiana</option>
                        <option value="ME">Maine</option>
                        <option value="MD">Maryland</option>
                        <option value="MA">Massachusetts</option>
                        <option value="MI">Michigan</option>
                        <option value="MN">Minnesota</option>
                        <option value="MS">Mississippi</option>
                        <option value="MO">Missouri</option>
                        <option value="MT">Montana</option>
                        <option value="NE">Nebraska</option>
                        <option value="NV">Nevada</option>
                        <option value="NH">New Hampshire</option>
                        <option value="NJ">New Jersey</option>
                        <option value="NM">New Mexico</option>
                        <option value="NY">New York</option>
                        <option value="NC">North Carolina</option>
                        <option value="ND">North Dakota</option>
                        <option value="OH">Ohio</option>
                        <option value="OK">Oklahoma</option>
                        <option value="OR">Oregon</option>
                        <option value="PA">Pennsylvania</option>
                        <option value="RI">Rhode Island</option>
                        <option value="SC">South Carolina</option>
                        <option value="SD">South Dakota</option>
                        <option value="TN">Tennessee</option>
                        <option value="TX">Texas</option>
                        <option value="UT">Utah</option>
                        <option value="VT">Vermont</option>
                        <option value="VA">Virginia</option>
                        <option value="WA">Washington</option>
                        <option value="WV">West Virginia</option>
                        <option value="SI">Wisconsin</option>
                        <option value="WY">Wyoming</option>
                    </select>
                </div>
            </div>    
            <div class="create-user-field">
                <p>Zip Code<span style="color: orangered;"> *</span></p>
                <input type="number" name="zip" value="" placeholder="" required>
            </div>
                
            <input type="hidden" name="small" value="<%= smallCount %>">
            <input type="hidden" name="medium" value="<%= mediumCount %>">
            <input type="hidden" name="large" value="<%= largeCount %>">
            <input type="hidden" name="xl" value="<%= xlCount %>">
            <input type="hidden" name="price" value="<%= priceTotal %>">
            <div class="create-user-button">   
                <button type="submit">Review Order</button>
            </div>
            </form>
        </div>

    </body>
</html>

