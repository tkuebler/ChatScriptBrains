Swig wrapper for ChatScript instructions:

Prerequisites:
--------------
- swig
- the swig extension for the language you want.
- the chatscript sources - basically the zip file download unziped


Each of the directories here contain the same .i file ( swig instructions ) and the resulting generated files from the commands below:

csharp:
cd <chatscript>/src
swig -c++ -csharp -namespace ChatScript ../swig/mac/csharp

java:
cd <chatscript>/src
swig -c++ -java ChatScript ../swig/mac/java


etc... you get the idea.   'swig -help' is your friend.

The Example* files in mac/[csharp|java|perl] should all run should all run and give you a console to chat with chatscript with, but running in that language.  The other directories are there for your convience and will require you to get it working yourself.  Enjoy

