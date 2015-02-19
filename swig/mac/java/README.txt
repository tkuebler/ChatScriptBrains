
Mono Instructions.  If you are on windows running .NET you are on your own, but it should work. :)

Prerequisites:
-------------
- Java sdk and jre
- A .DLL, .so, or .dylib dynamic library compiled from the *_wrap.cpp + chatscript source.
- see instructions in the swig directory about how to do that
- A little patience and ingenuity.

Caling swig from insdie the cs src directory to create the wrapper:
------------------------------------------------------------------
swig -c++ -cjava ../swig/mac/csharp/ChatScript.i

To compile and create the header:
---------------------------------
javac *.java
javah ChatScriptJNI

To run:
--------
java JavaExample



You should get a simple console running on java VM using chatscript directly as a library.
