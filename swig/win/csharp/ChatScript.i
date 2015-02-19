%module ChatScript %{ 
#include <time.h>
#include <stdint.h>
#include "common.h"
#include "mainSystem.h"
%}

%include <typemaps.i>

%typemap(ctype) char * output "char *" 
%typemap(imtype) char * output  "System.Text.StringBuilder" 
%typemap(cstype) char * output "System.Text.StringBuilder" 

%typemap(in) char * ppString (char *tmp = 0) %{ 
$1=&tmp; 
%} 

%typemap(argout) char * ppString %{ 
strcpy($input, *$1); 
free(*$1); 
%} 

//%apply char * output { char *OUTPUT }

int InitSystem(int argc, char * argv[],char* unchangedPath = NULL,char* readonlyPath = NULL, char* writablePath = NULL);
void PerformChat(char* user, char* usee, char* incoming,char* ip, char* output);

