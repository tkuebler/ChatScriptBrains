
Mono Instructions.  If you are on windows running .NET you are on your own, but it should work. :)

Prerequisites:
-------------
- .NET compile/runtime environement ( this example assumes mono )
- A .DLL, .so, or .dylib dynamic library compiled from the *_wrap.cpp + chatscript source.
- see instructions in the swig directory about how to do that
- A little patience and ingenuity.

Caling swig from insdie the cs src directory to create the wrapper:
swig -c++ -csharp -namespace ChatScript ../swig/mac/csharp/ChatScript.i

verify the wrapper worked and the fuctions, etc are exposed:

nm -g libChatScript.dylib| less


To compile the c# into an executable:
dmcs ./*.cs -r:System.dll

To run:
mono ./ChatScript.exe


You should get a simple console running on mono using chatscript directly as a library.


Troubleshooting:

set the environment variable MONO_LOG_LEVEL=debug to get better info out of the mono startup.

Common problem is compiling the shared library for 64 bit and using a 32 bit mono ( macmono downloaded from the mono site for example is 32 bit, you can compile mono yourself to be 64 bit))

