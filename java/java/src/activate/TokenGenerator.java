package activate;

import java.util.UUID;

public class TokenGenerator {

	public static String generate(){
		
		UUID id = UUID.randomUUID();
		
		String token = String.valueOf(id);
		
		return token.replace("-", "");
	}
}
