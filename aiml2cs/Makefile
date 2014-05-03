all: clean build deploy

clean:
	/bin/rm cs/*.top;
	/bin/rm ../RAWDATA/Alice/*-aiml.top;

build:
	/usr/bin/perl ./aiml2cs.pl aiml/;

deploy:
	/bin/cp cs/* ../RAWDATA/Alice/;
