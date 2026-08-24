# Advisories

This repository contains XML, which are advisories for a collection of the LFS
books.

Previously, these advisories were only in HTML. The XML is treated as data
instead of something that is only meant to be transformed into HTML, though
this project has files geared for doing exactly that, via `xsltproc`.

This project uses the MIT license, so you can transform the XML however you
wish. For example, you can feed it into a parser and create a menu that's
user-friendly, as an example, similar to the current system LFS+BLFS employs.

IDs are automatically resolved but are not created when writing the XML, only
when transforming the XML.

You can read the generated HTML files online.
- GLFS: https://glfs-book.github.io/advisories/glfs.html
- SLFS: https://glfs-book.github.io/advisories/slfs.html

## Transforming the XML

This repository supports transforming the XML into HTML.

To do it, you need `xsltproc` from **libxslt**. `tidy` from **tidy-html5** is
recommended to make the HTML cleaner and get rid of whitespace. `make` is also
recommended, but HTML generation is easy without it.

If you have `make`, run:
```Bash
make &&
make tidy
```

This will generate HTML files, but they aren't moved or copied anywhere.

If you don't have `make`, run this instead:
```Bash
for filename in $(find . -name "*.xml"); do
  book=${filename%.xml}
  xsltproc -o "$book".html lfs.xsl $filename
  tidy -config tidy.conf "$book".html
done
```
