#!/bin/sh
### ====================================================================
### Remove XML markup from stdin, or a list of files, sending the
### output to stdout with line breaks preserved.  This is useful before
### processing .xml files with spelling checkers, doubled-word finders,
### grammar checkers, etc.
###
### Usage:
### 	dexml <infile >outfile
### 	dexml file1 file2 ... >outfile
###
### Only simple pattern matching is used on the input; in particular,
### angle brackets that do not delimit XML tags may be eliminated.
###
### [21-Sep-2002] -- adapt from /usr/local/bin/dehtml
### [02-Sep-1997] -- update to handle a few SGML &xyz; entities
### [07-Apr-1995] -- original version
### ====================================================================
/bin/sed -e 's@<[/]*[A-Za-z][A-Za-z0-9]*[^>]*>@@g' \
        -e 's@[&][A-Za-z][A-Za-z0-9]*;@ @g' \
        "$@"

