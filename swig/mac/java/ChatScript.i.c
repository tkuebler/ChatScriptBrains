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

// this covers string output pointer
%typemap(jni) char *SBUF "jobject"
%typemap(jtype) char *SBUF "StringBuffer"
%typemap(jstype) char *SBUF "StringBuffer"

/* How to convert Java(JNI) type to requested C type */
%typemap(in) char *SBUF {

  $1 = NULL;
  if($input != NULL) {
    /* Get the String from the StringBuffer */
    jmethodID setLengthID;
    jclass sbufClass = (*jenv)->GetObjectClass(jenv, $input);
    jmethodID toStringID = (*jenv)->GetMethodID(jenv, sbufClass, "toString", "()Ljava/lang/String;");
    jstring js = (jstring) (*jenv)->CallObjectMethod(jenv, $input, toStringID);

    /* Convert the String to a C string */
    const char *pCharStr = (*jenv)->GetStringUTFChars(jenv, js, 0);

    /* Take a copy of the C string as the typemap is for a non const C string */
    jmethodID capacityID = (*jenv)->GetMethodID(jenv, sbufClass, "capacity", "()I");
    jint capacity = (*jenv)->CallIntMethod(jenv, $input, capacityID);
    $1 = (char *) malloc(capacity+1);
    strcpy($1, pCharStr);

    /* Release the UTF string we obtained with GetStringUTFChars */
    (*jenv)->ReleaseStringUTFChars(jenv,  js, pCharStr);

    /* Zero the original StringBuffer, so we can replace it with the result */
    setLengthID = (*jenv)->GetMethodID(jenv, sbufClass, "setLength", "(I)V");
    (*jenv)->CallVoidMethod(jenv, $input, setLengthID, (jint) 0);
  }
}

/* How to convert the C type to the Java(JNI) type */
%typemap(argout) char *SBUF {

  if($1 != NULL) {
    /* Append the result to the empty StringBuffer */
    jstring newString = (*jenv)->NewStringUTF(jenv, $1);
    jclass sbufClass = (*jenv)->GetObjectClass(jenv, $input);
    jmethodID appendStringID = (*jenv)->GetMethodID(jenv, sbufClass, "append", "(Ljava/lang/String;)Ljava/lang/StringBuffer;");
    (*jenv)->CallObjectMethod(jenv, $input, appendStringID, newString);

    /* Clean up the string object, no longer needed */
    free($1);
    $1 = NULL;
  }  
}
/* Prevent the default freearg typemap from being used */
%typemap(freearg) char *SBUF ""

/* Convert the jstype to jtype typemap type */
%typemap(javain) char *SBUF "$javainput"

// declarations
int InitSystem(int argc, char * argv[],char* unchangedPath = NULL,char* readonlyPath = NULL, char* writablePath = NULL);
void PerformChat(char* user, char* usee, char* incoming,char* ip, char *SBUF);

