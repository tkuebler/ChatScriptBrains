import java.util.Arrays;
import java.io.Console;
import java.lang.StringBuffer;

/**
 * Simple interactive console application. Uses the java.io.Console class of
 * Java 6.
 */
public final class JavaExample {

	static {
		System.loadLibrary("ChatScriptJNI");
	}

	static String userName = "Todd";
	static String botName = "Harry";
	static String csPath = "../../../";
	static String[] argv = { "", "local", "trace" };
	ChatScript chatScript;

	public JavaExample() {
  		chatScript = new ChatScript();
  		chatScript.InitSystem(argv.length, argv, csPath, csPath, csPath);
		System.out.println("running server....");
  }

	public static final void main(String... aArgs) {

		boolean chatting = true;
		Console console = System.console();
		JavaExample example = new JavaExample();
		System.out.println("\nWelcome!  type :quit to quit\n");
		do {
			String response = console.readLine("> ");
			// Note: this is to accomidate jdk < 1.7.  1.7 has a nice switch on string functin. 
			if ( response.compareToIgnoreCase(":quit") == 0 ) {
				chatting = false;
			}else{
				byte[] output = new byte[512];
				System.out.println(userName + " : " + response);
				example.chatScript.PerformChat(userName, botName, response, null, output);
				System.out.println(botName + " : " + new String(output));
			}
		} while (chatting);

	}

}
