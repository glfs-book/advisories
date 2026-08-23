all: glfs slfs

glfs: glfs.xml lfs.xsl
	xsltproc -o glfs.html lfs.xsl glfs.xml
slfs: slfs.xml lfs.xsl
	xsltproc -o slfs.html lfs.xsl slfs.xml
tidy: glfs slfs
	for filename in `find . -name "*.html"`; do \
          tidy -config tidy.conf $$filename;        \
          true;                                     \
        done;
clean:
	rm -rf *.*html

.PHONY: all glfs slfs tidy clean
