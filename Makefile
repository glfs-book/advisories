all: glfs.html

glfs.html: glfs.xml lfs.xsl
	xsltproc -o glfs.html lfs.xsl glfs.xml
tidy: glfs.html
	for filename in `find . -name "*.html"`; do \
          tidy -config tidy.conf $$filename;        \
          true;                                     \
        done;

clean:
	rm -rf *.*html
.PHONY: all glfs.html tidy clean
