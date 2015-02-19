
import java.util.Arrays;
import java.io.Console;

/**
* Simple interactive console application.
* Uses the java.io.Console class of Java 6.
*/
public final class JavaExample {

  public static final void main(String... aArgs){
    
	boolean chatting = true;
	Console console = System.console();
	ChatScript chatScript = new ChatScript();
	
	do {
		String response = console.readLine("> ");
		switch ( response ) {
		case ("/quit"):
			chatting = false;
			break;
		default:
			chatScript.
			break;
		}
			
	} while ( chatting );
	
  }
  
} 