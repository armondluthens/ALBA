package email;
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
	
	public EmailConfirmation(String rE, String sE, String SMTP, String password){
		
		this.recipientEmail = rE;
		this.senderEmail = sE;
		this.SMTPServer = SMTP;
		this.password = password;
		
	}

	public void send(String subject, String body){
		
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
			   message.setSubject(subject);
			
			   // Now set the actual message
			   message.setText(body);

			   // Send message
			   Transport.send(message);

			   System.out.println("Sent message successfully....");
			   
		} catch (MessagingException e) {
		         throw new RuntimeException(e);
		}
	}
}
