/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Armond_Test;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 *
 * @author armondluthens
 */
public class ResetPasswordEmail {
    private String recipientEmail;
    private String senderEmail;
    private String SMTPServer;
    private String password;
    
    public ResetPasswordEmail(){
        this.senderEmail = "gbautoemail@gmail.com";
        this.SMTPServer = "smtp.gmail.com";
        this.password = "autoemail";
    }
    
    public void sendActivation(String recipientEmail, String name, String token) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTPServer);
        props.put("mail.smtp.port", "25");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, password);
            }
        });

        try {
            // Create a default MimeMessage object.
            Message message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(senderEmail));

            // Set To: header field of the header.
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail));

            // Set Subject: header field
            message.setSubject("Reset Your Password");

            // Now set the actual message
            String url = "http://localhost:8080/ALBA_Armond/reset-password.jsp?&token=" + token;
            String body = "Hello,\n\nPlease click the link below to reset your password:\n\n" + url;
            message.setText(body);

            // Send message
            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
