The key to getting perl to link is usually $Config{lddlflags}.   Basically run the command below and use those when linking.  :)

perl -MConfig -e 'print $Config{lddlflags}'

also:

perl -MExtUtils::Embed -e ldopts

the config module is key to a lot of things around compiling and linking perl.  Enjoy.

In XCode you also have to use perl -MConfig -e 'print $Config{archlib}' and add those to both include and library path recursive
I also found xcode doesn't like to create universal binaries for the perl library - just build 64 bit works fine.

Note: match the name of the library to what perl expects - libperlchatscript.dylib  for example and if nessesary add -I. to the command line.
