/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Armond_Test;

import org.jasypt.util.text.BasicTextEncryptor;


/**
 *
 * @author armondluthens
 */
public class PasswordEncryption {
    private final String jaspytPassword;
    
    public PasswordEncryption(){
        this.jaspytPassword = "alba";
    }
    
    public String encryptPassword(String plainPassword){
        BasicTextEncryptor encryptObject = new BasicTextEncryptor();
        encryptObject.setPassword(jaspytPassword);
        String encryptedPassword = encryptObject.encrypt(plainPassword);
        return encryptedPassword;
    }
    
    public String decryptPassword(String encryptedPassword){
        BasicTextEncryptor decryptObject = new BasicTextEncryptor();
        decryptObject.setPassword(jaspytPassword);
        String decryptedPassword = decryptObject.decrypt(encryptedPassword);
        return decryptedPassword;
    }
    
    
}
