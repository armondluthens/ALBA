/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Armond_Test;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author armondluthens
 */
public class NewClass {
    public static void main(String[] args) throws ClassNotFoundException, SQLException{
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/ALBA";
    Class.forName("com.mysql.jdbc.Driver");
    con = (Connection) DriverManager.getConnection(url, "root", ""); 
    stmt = (Statement) con.createStatement();
    
    boolean validEmail= true;
    String email= "gavin@test.com";
    String checkForEmail = "SELECT email FROM USER WHERE email = '"+ email +"'";
    String emailReturnedFromSQL="";
    ResultSet emailRs = stmt.executeQuery(checkForEmail);
    boolean test= false;
    while(emailRs.next()){
        emailReturnedFromSQL = emailRs.getString("email");
        if(emailReturnedFromSQL.equals(email)){
            test = true;
        }
    }
    System.out.println(test);
    }
}
