<%-- 
    Document   : updateAccount
    Created on : Apr 4, 2016, 6:32:09 PM
    Author     : armondluthens
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%
    String email= (String)session.getAttribute("sessionEmail");
    String firstName= request.getParameter("firstName");
    String lastName= request.getParameter("lastName");
    String phone= request.getParameter("phoneNumber");
    String gender= request.getParameter("gender");
    String role= request.getParameter("role");
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", ""); 
    stmt = con.createStatement();
    
    String updateAccountSettings = "UPDATE USERS SET FirstName='"+ firstName+ "', LastName='"+ lastName+ "', Phone='"+ phone+ "',Gender='"+ gender+ "' WHERE Email='"+ email +"';";


    String redirect;
    if(role.equals("user")){
        redirect="userProductPage.jsp";
    }
    else if(role.equals("manager")){
        redirect="managerProductPage.jsp";
    }
    else{
        redirect="managerProductPage.jsp";
    }
    session.setAttribute("sessionFirstName", firstName);
    session.setAttribute("sessionLastName", lastName);
    session.setAttribute("sessionGender", gender);
    session.setAttribute("sessionPhone", phone);
    
    //session.invalidate(); <-- KILLS SESSION
    stmt.executeUpdate(updateAccountSettings);
    response.sendRedirect(redirect);
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

