/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Armond_Test;

/**
 *
 * @author armondluthens
 */

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailConfirmation {
	
	private String recipientEmail;
	private String senderEmail;
	private String SMTPServer;
	private String password;
	
	public EmailConfirmation(){
            this.senderEmail = "gbautoemail@gmail.com";
            this.SMTPServer = "smtp.gmail.com";
            this.password = "autoemail";
		
	}

	public void sendActivation(String recipientEmail, String name, String token){
		
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
			   message.setSubject("Activate Your Account");
			
			   // Now set the actual message
                           
                           //String url = "http://localhost:8080/Databases/activate.jsp?&token=" + token;
                           String url = "http://localhost:8080/ALBA_Armond/activateUser.jsp?&token=" + token;
                           String body = "Hello " + name + ",\n\nPlease click the link below to activate your account:\n\n" + url;
			   message.setText(body);

			   // Send message
			   Transport.send(message);

			   System.out.println("Sent message successfully....");
			   
		} catch (MessagingException e) {
		         throw new RuntimeException(e);
		}
	}
}

