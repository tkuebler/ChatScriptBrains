ChatScriptBrains Project
=========================

Has four parts:

Brains
------
Repository of brains to be placed in chat script.   Give back license, you use these brains, give back some more brains. :)

The file structure mimics the layout needed by the ChatScript server.  

aiml2cs
-------
This directory contains a perl script to help translating aiml -> chatscript.  That process is nessisarily a partitially manual process - as a lot of the macros require human interpretation of what behavior was intended in order to translate it to the chatscript methods of doing similar things.

swig
----
This directory contains interface definition files for a variety of platforms and languages with generated source.  You should be able to use what’s in these directories to both generate the library for your platform/language and also compile and test it.

XCode Project to compile ChatScript on Mac
------------------------------------------
Open this project and add the current source directory to all the targets and you should be able to compile any of them.

* ChatScriptServer
* libChatScript (swig generated dylib for C#, etc)
* libChatScriptJNI (swig generated dylib for java)
* libChatScriptPerl (swig generated dylib for perl)
* ChatScript ( bundle for use in things like unity )


__
Brains Contributors:

Jennifer:  Robert Jackson
