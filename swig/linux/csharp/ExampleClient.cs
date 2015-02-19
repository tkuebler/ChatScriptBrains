using System;
using System.IO;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using ChatScript;
using ExampleClient;

namespace ExampleClient
{
	public class ExampleClient
	{
		public bool dbug = false;
		static string[] args = { "", "local", "trace" };
		public string botName = "Harry";
		public string playerName = "Todd";
		public string chatRoot = "../../";

		public ExampleClient ()
		{
			InitServer ();
		}

		public ExampleClient (string chatscriptDirectory)
		{

		}

		void InitServer ()
		{
			if (dbug)
				Console.WriteLine ("PWD: " + System.Environment.CurrentDirectory.ToString ());
			GCHandle gch = StringArray2Ptr (args);
			IntPtr argv = gch.AddrOfPinnedObject ();
			if (dbug)
				Console.WriteLine (argv);
			if (dbug)
				Console.WriteLine ("Starting Server...");
			//Console.Write ("Started Chat Server : " + ChatScript.ChatScript.InitSystem (2, new SWIGTYPE_p_p_char (argv, false), "/tmp/chatscript", "/tmp/chatscript", "/tmp/chatscript"));
			Console.WriteLine ("Started Chat Server : " + ChatScript.ChatScript.InitSystem (args.Length, new SWIGTYPE_p_p_char (argv, false), chatRoot, chatRoot, chatRoot));
			gch.Free ();
		}

		public string SendChat (string input)
		{
			// TODO: thread this and check if server has fully started yet
			System.Text.StringBuilder output = new System.Text.StringBuilder (1024);
			ChatScript.ChatScript.PerformChat (playerName, botName, input, null, output);
			return output.ToString ();
		}

		void OnDisable ()
		{

		}

		void OnDestroy ()
		{
			
		}

		private void ShutdownServer ()
		{
			// TODO: shutdown tcp server
		}

		public static System.Runtime.InteropServices.GCHandle StringArray2Ptr (string[] array)
		{
			System.IntPtr[] parray = new System.IntPtr[array.Length];
			for (int i = 0; i < array.Length; ++i) {
				// StringToHGlobalAnsi  or   StringToCoTaskMemUni  ??
				parray [i] = System.Runtime.InteropServices.Marshal.StringToHGlobalAnsi (array [i]);
			}
			// In order to obtain the address of the IntPtr array, 
			// we must fix it in memory. We do this using GCHandle.
			System.Runtime.InteropServices.GCHandle gch = System.Runtime.InteropServices.GCHandle.Alloc (parray, System.Runtime.InteropServices.GCHandleType.Pinned);
			// call gch.free after you are done using this
			return gch;
		}
		// currently unused tcp method
		// TODO: need to make this configurable based on constructor args
		// So it can support both modes
		string Connect (String message)
		{
			try {
				// Create a TcpClient. 
				// Note, for this client to work you need to have a TcpServer  
				// connected to the same address as specified by the server, port 
				// combination.
				Int32 port = 1024;
				string server = "192.168.1.50";
				TcpClient client = new TcpClient (server, port);

				//message = main.userName + '\0' + '\0' + message + '\0';
				// Translate the passed message into ASCII and store it as a Byte array.
				Byte[] data = System.Text.Encoding.ASCII.GetBytes (message);         

				// Get a client stream for reading and writing. 
				//  Stream stream = client.GetStream();

				NetworkStream stream = client.GetStream ();

				// Send the message to the connected TcpServer. 
				Console.Write ("Connected: {0} : sending '" + message + "'.");
				stream.Write (data, 0, data.Length);

				Console.Write ("Sent: {0} : " + message);         

				// Receive the TcpServer.response. 

				// Buffer to store the response bytes.
				data = new Byte[1024];

				// String to store the response ASCII representation.
				String responseData = String.Empty;

				// Read the first batch of the TcpServer response bytes.
				Int32 bytes = stream.Read (data, 0, data.Length);
				responseData = System.Text.Encoding.ASCII.GetString (data, 0, bytes);
				Console.Write ("Received: {0} : " + responseData);         

				// Close everything.
				stream.Close ();         
				client.Close ();  
				return responseData;
			} catch (ArgumentNullException e) {
				Console.Write ("ArgumentNullException: {0} : " + e.ToString ());
			} catch (SocketException e) {
				Console.Write ("SocketException: {0} : " + e.ToString ());
			} catch (Exception e) {
				Console.Write ("Uh, oh, some other exceptions... " + e.ToString ());
			}

			return "Error!";
		}

		public static void Main (string[] args)
		{
			ExampleClient chatc = new ExampleClient ();
			Console.WriteLine();
			Console.WriteLine ("Welcome!");
			Console.WriteLine ("/quit to quit, /help for help, otherwise chat with the bot");
			Console.WriteLine();
			Console.Write("> ");
			bool notQuit = true;
			do {

				string choice = Console.ReadLine ();

				switch (choice) {

				case "/quit": 
					notQuit = false;
					break;

				case "/help": //Do that
					Console.WriteLine ("/quit to quit, /help for help, otherwise chat with the bot");
					Console.Write("> ");
					break;

				default:
					Console.WriteLine (chatc.SendChat (choice));
					Console.Write("> ");
					break;
				}

			} while (notQuit);
		}
	}
}
