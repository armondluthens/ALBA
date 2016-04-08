<%-- 
    Document   : managerProductPage
    Created on : Mar 4, 2016, 3:50:51 PM
    Author     : armondluthens
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
/**********************************************************************
    Connect to Database
***********************************************************************/
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    
/**********************************************************************
    Set Session Keys
***********************************************************************/
    String curField="";
    String token= request.getParameter("token");
    String[] userFields = {"FirstName", "LastName", "Email", "Gender", "Activated", "Role", "Phone"};
    String checkForUser = "SELECT * FROM USERS WHERE UserID = '" + token + "';";
    ResultSet userRs = stmt.executeQuery(checkForUser);
    while(userRs.next()){
        for(int i=0; i< userFields.length; i++){
            curField = userRs.getString(userFields[i]);
            session.setAttribute("session"+userFields[i], curField);
        }
    }
    
    //Role manager= Manager
    //Role admin= Admin
/**********************************************************************
    Get ArrayList of Managers
**********************************************************************/
    ArrayList<HashMap> allManagers = new ArrayList();
    String getAllManagers = "SELECT * FROM USERS WHERE Role='Manager'";
    ResultSet managerRs = stmt.executeQuery(getAllManagers);
    String[] managerFields = {"FirstName", "LastName", "Email"};
    while(managerRs.next()){
            HashMap<String, String> managerHash = new HashMap();
            for(int i=0; i<managerFields.length; i++){
                curField = managerRs.getString(managerFields[i]);
                managerHash.put(managerFields[i], curField);
            }
            allManagers.add(managerHash);
    }

/**********************************************************************
    Get Record Count for DEFECT Table
***********************************************************************/
    /*
    int defectCount;
    String getDefectCount= "SELECT COUNT(*) FROM DEFECT;";
    ResultSet defectCountRs = stmt.executeQuery(getDefectCount);
    while(managerRs.next()){
        curField = defectCountRs.getString("");
    }
    defectCount= Integer.parseInt(curField);
    */
/**********************************************************************
    Get All Available Claims From DEFECT Table
***********************************************************************/
    ArrayList<HashMap> defectClaims = new ArrayList();
    int defectCount=0;
    //String getDefectClaims = "SELECT * FROM DEFECT WHERE Reviewed='0'";
    String getDefectClaims = "SELECT * FROM DEFECT";
    ResultSet defectRs = stmt.executeQuery(getDefectClaims);
    String[] defectFields = {"ProductID", "DateReceived", "Description","Category", "Email", "Reviewed", "ClaimNum"};

    while(defectRs.next()){
        HashMap<String, String> claim = new HashMap();
        for(int i=0; i<defectFields.length; i++){
            curField = defectRs.getString(defectFields[i]);
            claim.put(defectFields[i], curField);
        }
        if(claim.get("Reviewed").equals("0")){
            defectClaims.add(claim);
        }
        defectCount++;
    }
    int nextClaimNumber= defectCount+1;
/**********************************************************************
    Get All Available Products From Products Table
***********************************************************************/
    ArrayList<HashMap> availableProducts = new ArrayList();
    String getAvailableProducts = "SELECT * FROM PRODUCTS WHERE Available='1'";
    ResultSet productsRs = stmt.executeQuery(getAvailableProducts);
    String[] productFields = {"ProductID", "Price", "Qty", "Description","Available", "ProductName", "ManufactureDate", "ExpirationDate", "Color", "Dimensions", "Category", "Supplier"};
    
    while(productsRs.next()){
        HashMap<String, String> product = new HashMap();
        for(int i=0; i<productFields.length; i++){
            curField = productsRs.getString(productFields[i]);
            product.put(productFields[i], curField);
        }
        availableProducts.add(product);
    }
/**********************************************************************
    Get All Unavailable Products From Products Table
***********************************************************************/
    ArrayList<HashMap> unavailableProducts = new ArrayList();
    String getUnavailableProducts = "SELECT * FROM PRODUCTS WHERE Available='0'";
    ResultSet unavailableRs = stmt.executeQuery(getUnavailableProducts);
    while(unavailableRs.next()){
        HashMap<String, String> unavailable = new HashMap();
        for(int i=0; i<productFields.length; i++){
            curField = unavailableRs.getString(productFields[i]);
            unavailable.put(productFields[i], curField);
        }
        unavailableProducts.add(unavailable);
    }
    HashMap<String, String> tempMap = new HashMap();


%>
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
            <h1>ALBA, INC.</h1>
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
        
        <% if(!session.getAttribute("sessionRole").equals("User")){ %>
            <div class="selectView">
                <a href="userProductPage.jsp">User View</a>
                <a href="#"><span style="border-bottom: 4px solid orangered;">Manager View</span></a>
            </div>
        <%} %>
     
 
        <div class="products-table">
            <h1>Available Products</h1>
            <h3>Displaying Results: 1 - <%= availableProducts.size() %></h3>
            <h4>Product Name</h4>
            <h4>Serial No.</h4>
            <h4>Price</h4>
            <h4>Qty</h4>
            <h4>Color</h4>
            <h4>Dimensions</h4>
            <h4>Man. Date</h4>
            <h4>Exp. Date</h4>
            <h4>Category</h4>
            <h4>Supplier</h4>
        </div>   
        
        <% for(int i=0; i<availableProducts.size(); i++){ %>
            <%= tempMap= availableProducts.get(i) %>
            
            <div class="manager-product-record">
                <a href="editPart.jsp?&key=<%= tempMap.get("ProductID")%>">
                    <h5 title="Select To Edit Part"><%= tempMap.get("ProductName")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("ProductID")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Price")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Qty")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Color")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Dimensions")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("ManufactureDate") %></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("ExpirationDate")%></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Category") %></h5>
                    <h5 title="Select To Edit Part"><%= tempMap.get("Supplier")%></h5>
                </a>
            </div>
        <% } %>
            
        
        <div class="products-table">
            <h1>Insert New Products</h1>
        </div>
        <form action="insertPartForm.jsp" method="POST">
        <div class="insertForm">
            <button type="submit" name="insert">INSERT</button>
        </div>
        </form>
        
        <div class="products-table">
            <h1>Make Part Available To Users</h1>
        </div>
        <form action="insertPart.jsp" method="POST">
        <div class="styled-select">
            <select name="partSelected">
                <% for(int i=0; i< unavailableProducts.size(); i++){ %>
                <%= tempMap= unavailableProducts.get(i) %>
                    <option value="<%= tempMap.get("ProductID")%>"><%= tempMap.get("ProductName")%></option>
                <% } %>
            </select>
        </div>
        <div class="insert-button">
            <button type="submit" name="insert">INSERT</button>
        </div>
        </form>
        
        
        <div class="products-table">
            <h1>View Product Defect Claims</h1>
        </div>
        <form action="viewClaim.jsp" method="POST">
        <div class="styled-select">
            <select name="defectClaimSelected">
                <% for(int j=0; j< defectClaims.size(); j++){ %>
                    <%= tempMap= defectClaims.get(j) %>
                    <option value="<%= tempMap.get("ClaimNum")%>"><%= tempMap.get("ProductID")%></option>
                <% } %>
                    
            </select>
            
        </div>
        <div class="insert-button">
            <button type="submit" name="insert">VIEW</button>
        </div>
        </form>
            
            
        <% if(session.getAttribute("sessionRole").equals("Admin")){ %>    
            <div class="products-table">
                <h1>Promote Manager To Admin</h1>
            </div>

            <form action="promoteManager.jsp" method="POST">
            <div class="styled-select">
                <select name="managerSelected">
                    <option value="">Select Manager</option>
                    <% for(int i=0; i< allManagers.size(); i++){ %>
                        <%= tempMap= allManagers.get(i) %>
                        <option name="promotion" value="<%= tempMap.get("Email")%>"><%= tempMap.get("FirstName")%> <%= tempMap.get("LastName")%></option>
                    <% } %>
                </select>
            </div>
            <div class="insert-button">
                <button type="submit" name="insert">PROMOTE</button>
            </div>
            </form>
        <% } %>
        <div class="footer">
            <ul>
                <li><a href="#"><h1>ALBA</h1></a></li>
                <!--
                <li><a href="deactivateAccount.jsp">Deactivate My Account</a></li>
                <li><a href="index.jsp">Log Out</a></li>
                -->
            </ul>
        </div>
    </body>
</html>
