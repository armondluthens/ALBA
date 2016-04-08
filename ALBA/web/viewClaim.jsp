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
        String curField;
        String claimNum = request.getParameter("defectClaimSelected");
        
        Statement stmt;
        Connection con;
        String url = "jdbc:mysql://localhost:3306/ALBA";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", ""); 
        stmt = con.createStatement();
      
        String getClaim = "SELECT * FROM DEFECT WHERE ClaimNum='"+ claimNum +"'";
        HashMap<String, String> claim = new HashMap();
        ResultSet claimRs = stmt.executeQuery(getClaim);
        String[] claimFields = {"DateReceived","ProductID", "Description","Category", "Email", "Reviewed", "ClaimNum"};
        while(claimRs.next()){
            for(int i=0; i<claimFields.length; i++){
                curField = claimRs.getString(claimFields[i]);
                claim.put(claimFields[i], curField);
            }
        }

         String email = claim.get("Email");
         String prodID= claim.get("productID");
         String date= claim.get("DateReceived");;
         String category= claim.get("Category");;
         String description= claim.get("Description");;
        
        
        String getAvailableProducts = "SELECT * FROM USERS WHERE Email='"+ email +"'";
        ResultSet claimSubmitterRs = stmt.executeQuery(getAvailableProducts);
        String firstName="";
        String lastName="";
    
        while(claimSubmitterRs.next()){
            firstName= claimSubmitterRs.getString("FirstName");
            lastName= claimSubmitterRs.getString("LastName");
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
        <title>ALBA | View Claim</title>
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
        
        <% if(session.getAttribute("sessionRole").equals("Admin")){ %>
            <div class="selectView">
                <a href="userProductPage.jsp">User View</a>
                <a href="#"><span style="border-bottom: 4px solid orangered;">Manager View</span></a>
            </div>
        <%} %>
     
        <div class="claimFormat">
            <h1>Claim No. <%= claimNum %></h1>
            <h2>Claim Submitted By: <span style="color: orangered;"><%= firstName %> <%= lastName %></span></h2>
            <h2>Submitter Email: <span style="color: orangered;"><%= email %></span></h2>
            <h2>Product ID: <span style="color: orangered;"><%= prodID %></span></h2>
            <h2>Date of Purchase: <span style="color: orangered;"><%= date %></span></h2>
            <h2>Product Category: <span style="color: orangered;"><%= category %></span></h2>
            <h2>Product Defect Description <span style="color: orangered;"><%= description %></span></h2>
            <p></p>
        </div>
        
        <div class="footer">
            <ul>
                <li><a href="#"><h1>ALBA</h1></a></li>
            </ul>
        </div>
    </body>
</html>
