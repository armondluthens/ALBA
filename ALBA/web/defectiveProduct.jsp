<%-- 
    Document   : defectiveProduct
    Created on : Apr 4, 2016, 7:19:30 PM
    Author     : armondluthens
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
    Get All Available Claims From DEFECT Table
***********************************************************************/
    ArrayList<HashMap> defectClaims = new ArrayList();
    int defectCount=0;
    String curField;
    //String getDefectClaims = "SELECT * FROM DEFECT WHERE Reviewed='0'";
    String getDefectClaims = "SELECT * FROM DEFECT";
    ResultSet defectRs = stmt.executeQuery(getDefectClaims);
    String[] defectFields = {"ProductID", "DateReceived", "Description","Category", "Email", "Reviewed"};
    
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
        <title>ALBA | Defect Claim</title>
        <meta name="description" content="ALBA web page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signUp.css">
        <link rel="stylesheet" href="signUp-media.css">
        
        <script type="text/javascript">
            function validateForm(form){
                var re = /^[\w ]+$/; //regular expression to match only alphanumeric characters and spaces
                //PRODUCT ID VALIDATION
                if(form.productID.value.length > 20) {
                    alert("Invalid Product ID");
                    form.productID.focus();
                    return false;
                }
                if(!re.test(form.productID.value)) {
                    alert("Error: Input contains invalid characters");
                    form.productID.focus();
                    return false;
                }
                
                //DESCRIPTION VALIDATION
                if(form.defectDescription.value.length > 200) {
                    alert("Description must be 200 characters or less");
                    form.defectDescription.focus();
                    return false;
                }
                return true; // validation was successful
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
        
        <div class="create-user">
            <h1>Product Defect Claim </h1>
            <h6><span style="color: orangered;"> *</span> required field</h6>
          
            
            <form method="POST" action="submitDefect.jsp" onsubmit="return validateForm(this);">
            <div class="create-user-field">
                <p>Product ID<span style="color: orangered;"> *</span></p>
                <input type="text" name="productID" value="" placeholder="" required>
            </div>
                
            <div class="create-user-field">
                <p>Date Purchased<span style="color: orangered;"> *</span></p>
                <input type="date" name="datePurchased" value="" placeholder="" required>
            </div>
            <div class="create-user-field">
                <p>Category<span style="color: orangered;"> *</span></p></p>
                <div class="gender-field">
                    <select name="category">
                        <option value="select">Select</option>
                        <option value="electronics">Electronics</option>
                        <option value="food">Home</option>
                        <option value="food">Garden</option>
                    </select>
                </div>
            </div>
                <input type="hidden" name="claimNum" value="<%= nextClaimNumber %>">
            <div class="create-user-field">
                <p>Description of Defect:<span style="color: orangered;"> *</span></p>
                <textarea type="text" name="defectDescription" value="" placeholder="Please detail the defect of your part..." required></textarea>
            </div>
           
            <div class="create-user-button">   
                <button type="submit">Submit Claim</button>
            </div>
            </form>
        </div>

    </body>
</html>


