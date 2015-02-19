
Mono Instructions.  If you are on windows running .NET you are on your own, but it should work. :)

Prerequisites:
-------------
- .NET compile/runtime environement ( this example assumes mono )
- A .DLL, .so, or .dylib dynamic library compiled from the *_wrap.cpp + chatscript source.
- see instructions in the swig directory about how to do that
- A little patience and ingenuity.

Caling swig from insdie the cs src directory to create the wrapper:
swig -c++ -csharp -namespace ChatScript ../swig/mac/csharp/ChatScript.i

To compile:
dmcs ./*.cs -r:System.dll

To run:
mono ./ChatScript.exe


You should get a simple console running on mono using chatscript directly as a library.
