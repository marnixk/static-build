# static-build
Simple build scripts that understand certain include and variable instructions for static page generation.

# Makefile

The makefile runs and transforms any .html file under the html/ folder except when they live in a folder starting with an underscore `_`.

# Conversion

Understand the following instructions. One per line.

	<!--#include file="relative to html/ filename" -->

The included file will be interpreted recursively, don't make cycles.


	<!--#var name="key from config/default.tcl" -->


