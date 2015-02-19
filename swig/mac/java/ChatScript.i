%module ChatScript %{ 
#include <time.h>
#include <stdint.h>
#include "common.h"
#include "mainSystem.h"
%}

//%include typemaps.i
%include cpointer.i
%include arrays_java.i
%include various.i

// This covers the char pointers for string input
%pointer_functions(char, charp);
// this covers the string array pointer (easy way)
%apply char** STRING_ARRAY {char* argv[]};

// declarations
int InitSystem(int argc, char * argv[],char* unchangedPath = NULL,char* readonlyPath = NULL, char* writablePath = NULL);
void PerformChat(char* user, char* usee, char* incoming,char* ip, char *BYTE);

