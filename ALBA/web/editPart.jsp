<%-- 
    Document   : editPart
    Created on : Mar 21, 2016, 1:52:47 PM
    Author     : armondluthens
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //String enterValidProductID = "";
    String productID = request.getParameter("key");
  
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String curField;
    HashMap<String, String> product = new HashMap();
    String getAvailableProducts = "SELECT * FROM PRODUCTS WHERE ProductID='"+ productID +"'";
    ResultSet productsRs = stmt.executeQuery(getAvailableProducts);
    String[] productFields = {"ProductID", "Price", "Qty", "Description","Available", "ProductName", "ManufactureDate", "ExpirationDate", "Color", "Dimensions"};
    while(productsRs.next()){
        for(int i=0; i<productFields.length; i++){
            curField = productsRs.getString(productFields[i]);
            product.put(productFields[i], curField);
        }
    }
    
    String productName = product.get("ProductName");
    String price = product.get("Price");
    String qty = product.get("Qty");
    String description = product.get("Description");
    String color = product.get("Color");
    String dimensions = product.get("Dimensions");
    String manufactureDate= product.get("ManufactureDate");
    String expirationDate= product.get("ExpirationDate");
   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href='http://fonts.googleapis.com/css?family=Lato:100,400,700,900' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Prociono' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>
        <title>ALBA | Edit Part</title>
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
            <h1>Edit Product</h1>
            
            <form method="POST" action="editPartFormValidate.jsp">
            <div class="create-user-field">
                <p>Product Name<span style="color: orangered;"> *</span></p>
                <input type="text" name="productName" value="<%= productName%>" placeholder="" required>
            </div>
            
            <div class="create-user-field">
                <p>Serial No.<span style="color: orangered;"> *</span></p>
                <input type="text" name="productID" value="<%= productID %>" placeholder="" readonly>
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
            
            <div class="create-user-field">
                <p>Dimensions<span style="color: orangered;"> *</span></p>
                <input type="text" name="dimensions" value="<%= dimensions %>" placeholder="" required>
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
            <div class="create-user-button">   
                <button type="submit">UPDATE</button>
            </div>
            </form>
        </div>

    </body>
</html>
