package email;

public class EmailTest {

	public static void main(String[] args) {

		final String to = "bannermangavin@gmail.com";
		final String from = "gbautoemail@gmail.com";
		final String host = "smtp.gmail.com";
		final String password = "autoemail";
		
		final String subject = "Activate Your Account";
		final String body = "Hello <NAME>,\n\nPlease click the link below to activate your account:\n\nwww.icon.uiowa.edu";
		
		EmailConfirmation email = new EmailConfirmation(to, from, host, password);
		email.send(subject, body);

	}

}
