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
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
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
    String[] productFields = {"ProductID", "Price", "Qty", "Description","Available", "ProductName", "ManufactureDate", "ExpirationDate", "Color", "Dimensions", "Category", "Supplier"};
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
    String category=product.get("Category");
    String supplier=product.get("Supplier");
   
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
                        <%if(dimensions.equals("Small")){ %>
                            <option selected="selected" value="Small">Small</option>
                            <option value="Medium">Medium</option>
                            <option value="Large">Large</option>
                            <option value="Extra Large">Extra Large</option>
                        <%} else if(dimensions.equals("Medium")){%>
                            <option value="Small">Small</option>
                            <option selected="selected" value="Medium">Medium</option>
                            <option value="Large">Large</option>
                            <option value="Extra Large">Extra Large</option>
                        <%} else if(dimensions.equals("Large")){%>
                            <option value="Small">Small</option>
                            <option value="Medium">Medium</option>
                            <option selected="selected" value="Large">Large</option>
                            <option value="Extra Large">Extra Large</option>
             
                        <%} else{ %>
                            <option value="Small">Small</option>
                            <option value="Medium">Medium</option>
                            <option value="Large">Large</option>
                            <option selected="selected" value="Extra Large">Extra Large</option>
                        <% } %>
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
            
            <!--
            <div class="create-user-field">
                <p>Category<span style="color: orangered;"> *</span></p>
                <input type="text" name="category123" value="<%= category %>" placeholder="" required>
            </div>
            -->
            <div class="create-user-field">
                <p>Category<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="category123">
                        <%if(category.equals("electronics")){ %>
                            <option selected="selected" value="electronics">Electronics</option>
                            <option value="audio">Audio</option>
                            <option value="home">Home</option>
                            <option value="office">Office</option>
                            
                        <%} else if(category.equals("audio")){%>
                            <option value="electronics">Electronics</option>
                            <option selected="selected" value="audio">Audio</option>
                            <option value="home">Home</option>
                            <option value="office">Office</option>
                            
                        <%} else if(category.equals("home")){%>
                            <option value="electronics">Electronics</option>
                            <option value="audio">Audio</option>
                            <option selected="selected" value="home">Home</option>
                            <option value="office">Office</option>
             
                        <%} else{ %>
                            <option value="electronics">Electronics</option>
                            <option value="audio">Audio</option>
                            <option value="home">Home</option>
                            <option selected="selected" value="office">Office</option>
                        <% } %>
                    </select>
                </div>
            </div>
            
            <div class="create-user-field">
                <p>Supplier<span style="color: orangered;"> *</span></p>
                <input type="text" name="supplier123" value="<%= supplier %>" placeholder="" required>
            </div>
            <div class="create-user-button">   
                <button type="submit">UPDATE</button>
            </div>
            </form>
        </div>

    </body>
</html>
