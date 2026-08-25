BASEDIR ?= $(HOME)/public_html/advisories

all: basedir

glfs: glfs.xml lfs.xsl
	xsltproc -o glfs.html lfs.xsl glfs.xml
slfs: slfs.xml lfs.xsl
	xsltproc -o slfs.html lfs.xsl slfs.xml
index: index.html.in
	cp index.html.in index.html
tidy: glfs slfs index
	for filename in `find . -name "*.html"`; do \
  tidy -config tidy.conf $$filename;         \
  true;                                     \
done;
basedir: tidy
	mkdir -p $(BASEDIR)
	cp *.html *.css *.svg $(BASEDIR)
clean:
	rm -rf *.*html

.PHONY: all glfs slfs tidy clean
