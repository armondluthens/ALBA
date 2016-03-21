<%-- 
    Document   : userProductPage
    Created on : Mar 4, 2016, 3:50:40 PM
    Author     : armondluthens
--%>
<%@page import="java.lang.String"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
    String id = "";
    String buy = "buyProduct.jsp?&prod=";
    
    ArrayList<HashMap> availableProducts = new ArrayList();
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    String curField;
    String searchBar = request.getParameter("search");
    if(searchBar == null || searchBar.equals("")){
        String getAvailableProducts = "SELECT * FROM PRODUCTS WHERE Available='1'";
        ResultSet productsRs = stmt.executeQuery(getAvailableProducts);
        String[] productFields = {"ProductID", "Price", "Qty", "Description", "ProductName"};
        while(productsRs.next()){
            HashMap<String, String> product = new HashMap();
            for(int i=0; i<productFields.length; i++){
                curField = productsRs.getString(productFields[i]);
                product.put(productFields[i], curField);
            }
            availableProducts.add(product);
        }
    }
    else{
        String getAvailableProducts = "SELECT * FROM PRODUCTS WHERE " +
                "ProductID='"+ searchBar +"' OR " +
                "Price LIKE '%"+ searchBar + "%' OR " +
                "Qty LIKE '%"+ searchBar + "%' OR " +
                "Description LIKE '%"+ searchBar + "%' OR " +
                "ProductName LIKE '%"+ searchBar + "%'; ";
        
        ResultSet productsRs = stmt.executeQuery(getAvailableProducts);
        String[] productFields = {"ProductID", "Price", "Qty", "Description", "ProductName"};
        while(productsRs.next()){
            HashMap<String, String> product = new HashMap();
            for(int i=0; i<productFields.length; i++){
                curField = productsRs.getString(productFields[i]);
                product.put(productFields[i], curField);
            }
            availableProducts.add(product);
        }
    }
    HashMap<String, String> tempMap = new HashMap();
    //SET SESSION KEYS
    String token= request.getParameter("token");
    String[] userFields = {"FirstName", "LastName", "Email", "Gender", "Activated"};
    String checkForUser = "SELECT * FROM USERS WHERE UserID = '" + token + "';";
    ResultSet userRs = stmt.executeQuery(checkForUser);
    while(userRs.next()){
        for(int i=0; i< userFields.length; i++){
            curField = userRs.getString(userFields[i]);
            session.setAttribute("session"+userFields[i], curField);
        }
    }

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
        <title>ALBA</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="product.css">
        <link rel="stylesheet" href="product-media.css">
    </head>
    <body>
        <div class="title-top">
            <h1>ALBA, INC.</h1>
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
        

        <div class="products-table">
            <h1>Available Products</h1>
            <h3>Displaying Results: 1 - <%= availableProducts.size()%></h3>
         </div>   
        
        <% for(int i=0; i<availableProducts.size(); i++){ %>
            
            <%= tempMap= availableProducts.get(i) %>
            <% int qty = Integer.parseInt(tempMap.get("Qty")); %>
            <%= id= tempMap.get("ProductID") %>
            <form action="add-to-cart.jsp">
            <div class="product-record">
                    <h2><%= tempMap.get("ProductName")%> </h5>
                    <h5>$<%= tempMap.get("Price") %></h5>
                    <p>
                        <%= tempMap.get("Description") %>
                    </p>
                    <h6>Select Qty.</h6>
                    
                    <div class="styled-select2">
                        <select name="qtySelected">
                            <% for(int j=1; j<= qty; j++){ %>
                            <option value="<%= j %>"><%= j %></option>
                            <% } %>
                        </select>
                    </div>
                    <button action="">ADD</button>
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="price" value="<%=tempMap.get("Price")%>">
                    <input type="hidden" name="name" value="<%=tempMap.get("ProductName")%>">
            </div>
            </form>
        <% } %>
        <form action="buyProduct.jsp" method="POST">
        <div class="checkout">
            <button type="submit">CHECKOUT</button>
            <input type="hidden" name="test" value="success">
        </div>
        </form>
        <div class="footer">
            <ul>
                <li><a href="deactivateAccount.jsp">Deactivate My Account</a></li>
                <li><a href="index.jsp">Log Out</a></li>
            </ul>
        </div>
    </body>
</html>

