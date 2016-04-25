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
    
    String loginCheck= (String)session.getAttribute("LoggedIn");
    if(!loginCheck.equals("1") || loginCheck.equals(null)){
        String redirectURL = "index.jsp?&invalidLoginAttempt=1";
        response.sendRedirect(redirectURL);
    }
    
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
        String[] productFields = {"ProductID", "Price", "Qty", "Description", "ProductName", "Dimensions"};
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
    String[] userFields = {"FirstName", "LastName", "Email", "Gender", "Phone", "Role"};
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
        <script>
        /* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
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
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
            <!--<h4>Logged In As: <%= session.getAttribute("sessionFirstName") %> <%= session.getAttribute("sessionLastName") %></h4>-->
        </div>
        
        <div class="search-prod">
            <form action="userProductPage.jsp" method="POST">
                <input type="text" name="search" value="" placeholder="Search for product...">
                <button type="submit">SEARCH</button>
            </form>
            <a href="buyProduct.jsp">
                <img src="shopping-cart2.png">
                <input type="hidden" name="test" value="success">
            </a>
            
        </div>
        
        <% if(!session.getAttribute("sessionRole").equals("User")){ %>
            <div class="selectView">
                <a href="userProductPage.jsp"><span style="border-bottom: 4px solid orangered;">User View</span></a>
                <a href="managerProductPage.jsp">Manager View</a>
            </div>
        <% } %>
        
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
                    <h5>Size: <%= tempMap.get("Dimensions") %></h5>
                    <p>
                        <%= tempMap.get("Description") %>
                    </p>
                    <h6>Select Qty.</h6>
                    
                    <div class="styled-select2">
                        <select name="qtySelected">
                            <%if(qty <= 0){%>
                                <option value="">OUT OF STOCK</option>
                            <%} else{ %>
                                
                                <% for(int j=1; j<= qty; j++){ %>
                                    <option value="<%= j %>"><%= j %></option>
                                <% } %>
                            <% } %>
                            
                        </select>
                    </div>
                    <%if(qty <= 0){%>
                        <button type="button" disabled style="opacity:0.5;">ADD</button>
                    <%} else{ %>
                        <button action="">ADD</button>
                    <% } %>
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="price" value="<%=tempMap.get("Price")%>">
                    <input type="hidden" name="name" value="<%=tempMap.get("ProductName")%>">
                    <input type="hidden" name="size" value="<%=tempMap.get("Dimensions")%>">
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
                <li><a href="defectiveProduct.jsp">Defective Product Claim</a></li>
                <li><a href="index.jsp">Log Out</a></li>
            </ul>
        </div>
    </body>
</html>

