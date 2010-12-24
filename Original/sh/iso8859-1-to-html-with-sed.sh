#! /bin/sh -
# Convert an input stream containing characters in ISO 8859-1
# encoding from the range 128..255 to HTML equivalents in ASCII.
# Characters 0..127 are preserved as normal ASCII.
#
# Usage:
#	iso8859-1-to-html infile(s) >outfile

IFS='
 	'
PATH=/usr/bin:/bin
export PATH

sed \
	-e 's=�=\&nbsp;=g' \
	-e 's=�=\&iexcl;=g' \
	-e 's=�=\&cent;=g' \
	-e 's=�=\&pound;=g' \
	-e 's=�=\&curren;=g' \
	-e 's=�=\&yen;=g' \
	-e 's=�=\&brvbar;=g' \
	-e 's=�=\&sect;=g' \
	-e 's=�=\&uml;=g' \
	-e 's=�=\&copy;=g' \
	-e 's=�=\&ordf;=g' \
	-e 's=�=\&laquo;=g' \
	-e 's=�=\&not;=g' \
	-e 's=�=\&shy;=g' \
	-e 's=�=\&reg;=g' \
	-e 's=�=\&macr;=g' \
	-e 's=�=\&deg;=g' \
	-e 's=�=\&plusmn;=g' \
	-e 's=�=\&sup2;=g' \
	-e 's=�=\&sup3;=g' \
	-e 's=�=\&acute;=g' \
	-e 's=�=\&micro;=g' \
	-e 's=�=\&para;=g' \
	-e 's=�=\&middot;=g' \
	-e 's=�=\&cedil;=g' \
	-e 's=�=\&sup1;=g' \
	-e 's=�=\&ordm;=g' \
	-e 's=�=\&raquo;=g' \
	-e 's=�=\&frac14;=g' \
	-e 's=�=\&frac12;=g' \
	-e 's=�=\&frac34;=g' \
	-e 's=�=\&iquest;=g' \
	-e 's=�=\&Agrave;=g' \
	-e 's=�=\&Aacute;=g' \
	-e 's=�=\&Acirc;=g' \
	-e 's=�=\&Atilde;=g' \
	-e 's=�=\&Auml;=g' \
	-e 's=�=\&Aring;=g' \
	-e 's=�=\&AElig;=g' \
	-e 's=�=\&Ccedil;=g' \
	-e 's=�=\&Egrave;=g' \
	-e 's=�=\&Eacute;=g' \
	-e 's=�=\&Ecirc;=g' \
	-e 's=�=\&Euml;=g' \
	-e 's=�=\&Igrave;=g' \
	-e 's=�=\&Iacute;=g' \
	-e 's=�=\&Icirc;=g' \
	-e 's=�=\&Iuml;=g' \
	-e 's=�=\&ETH;=g' \
	-e 's=�=\&Ntilde;=g' \
	-e 's=�=\&Ograve;=g' \
	-e 's=�=\&Oacute;=g' \
	-e 's=�=\&Ocirc;=g' \
	-e 's=�=\&Otilde;=g' \
	-e 's=�=\&Ouml;=g' \
	-e 's=�=\&times;=g' \
	-e 's=�=\&Oslash;=g' \
	-e 's=�=\&Ugrave;=g' \
	-e 's=�=\&Uacute;=g' \
	-e 's=�=\&Ucirc;=g' \
	-e 's=�=\&Uuml;=g' \
	-e 's=�=\&Yacute;=g' \
	-e 's=�=\&THORN;=g' \
	-e 's=�=\&szlig;=g' \
	-e 's=�=\&agrave;=g' \
	-e 's=�=\&aacute;=g' \
	-e 's=�=\&acirc;=g' \
	-e 's=�=\&atilde;=g' \
	-e 's=�=\&auml;=g' \
	-e 's=�=\&aring;=g' \
	-e 's=�=\&aelig;=g' \
	-e 's=�=\&ccedil;=g' \
	-e 's=�=\&egrave;=g' \
	-e 's=�=\&eacute;=g' \
	-e 's=�=\&ecirc;=g' \
	-e 's=�=\&euml;=g' \
	-e 's=�=\&igrave;=g' \
	-e 's=�=\&iacute;=g' \
	-e 's=�=\&icirc;=g' \
	-e 's=�=\&iuml;=g' \
	-e 's=�=\&eth;=g' \
	-e 's=�=\&ntilde;=g' \
	-e 's=�=\&ograve;=g' \
	-e 's=�=\&oacute;=g' \
	-e 's=�=\&ocirc;=g' \
	-e 's=�=\&otilde;=g' \
	-e 's=�=\&ouml;=g' \
	-e 's=�=\&divide;=g' \
	-e 's=�=\&oslash;=g' \
	-e 's=�=\&ugrave;=g' \
	-e 's=�=\&uacute;=g' \
	-e 's=�=\&ucirc;=g' \
	-e 's=�=\&uuml;=g' \
	-e 's=�=\&yacute;=g' \
	-e 's=�=\&thorn;=g' \
	-e 's=�=\&yuml;=g' \
	"$@"
