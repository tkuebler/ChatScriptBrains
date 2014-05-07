all: clean distclean test build dist

clean:
	-/bin/rm cs/*.top;

distclean:
	-/bin/rm ../RAWDATA/Alice/*-aiml.top;

testclean:
	-/bin/rm test/*.top

test: testclean
	/usr/bin/perl ./aiml2cs.pl test/ test/;
	/bin/cp test/*-aiml.top ../RAWDATA/test/;

build:
	/usr/bin/perl ./aiml2cs.pl aiml/ cs/;

dist: 
	/bin/cp cs/* ../RAWDATA/Alice/;
