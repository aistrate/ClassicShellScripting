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
	-e 's= =\&nbsp;=g' \
	-e 's=¡=\&iexcl;=g' \
	-e 's=¢=\&cent;=g' \
	-e 's=£=\&pound;=g' \
	-e 's=¤=\&curren;=g' \
	-e 's=¥=\&yen;=g' \
	-e 's=¦=\&brvbar;=g' \
	-e 's=§=\&sect;=g' \
	-e 's=¨=\&uml;=g' \
	-e 's=©=\&copy;=g' \
	-e 's=ª=\&ordf;=g' \
	-e 's=«=\&laquo;=g' \
	-e 's=¬=\&not;=g' \
	-e 's=­=\&shy;=g' \
	-e 's=®=\&reg;=g' \
	-e 's=¯=\&macr;=g' \
	-e 's=°=\&deg;=g' \
	-e 's=±=\&plusmn;=g' \
	-e 's=²=\&sup2;=g' \
	-e 's=³=\&sup3;=g' \
	-e 's=´=\&acute;=g' \
	-e 's=µ=\&micro;=g' \
	-e 's=¶=\&para;=g' \
	-e 's=·=\&middot;=g' \
	-e 's=¸=\&cedil;=g' \
	-e 's=¹=\&sup1;=g' \
	-e 's=º=\&ordm;=g' \
	-e 's=»=\&raquo;=g' \
	-e 's=¼=\&frac14;=g' \
	-e 's=½=\&frac12;=g' \
	-e 's=¾=\&frac34;=g' \
	-e 's=¿=\&iquest;=g' \
	-e 's=À=\&Agrave;=g' \
	-e 's=Á=\&Aacute;=g' \
	-e 's=Â=\&Acirc;=g' \
	-e 's=Ã=\&Atilde;=g' \
	-e 's=Ä=\&Auml;=g' \
	-e 's=Å=\&Aring;=g' \
	-e 's=Æ=\&AElig;=g' \
	-e 's=Ç=\&Ccedil;=g' \
	-e 's=È=\&Egrave;=g' \
	-e 's=É=\&Eacute;=g' \
	-e 's=Ê=\&Ecirc;=g' \
	-e 's=Ë=\&Euml;=g' \
	-e 's=Ì=\&Igrave;=g' \
	-e 's=Í=\&Iacute;=g' \
	-e 's=Î=\&Icirc;=g' \
	-e 's=Ï=\&Iuml;=g' \
	-e 's=Ð=\&ETH;=g' \
	-e 's=Ñ=\&Ntilde;=g' \
	-e 's=Ò=\&Ograve;=g' \
	-e 's=Ó=\&Oacute;=g' \
	-e 's=Ô=\&Ocirc;=g' \
	-e 's=Õ=\&Otilde;=g' \
	-e 's=Ö=\&Ouml;=g' \
	-e 's=×=\&times;=g' \
	-e 's=Ø=\&Oslash;=g' \
	-e 's=Ù=\&Ugrave;=g' \
	-e 's=Ú=\&Uacute;=g' \
	-e 's=Û=\&Ucirc;=g' \
	-e 's=Ü=\&Uuml;=g' \
	-e 's=Ý=\&Yacute;=g' \
	-e 's=Þ=\&THORN;=g' \
	-e 's=ß=\&szlig;=g' \
	-e 's=à=\&agrave;=g' \
	-e 's=á=\&aacute;=g' \
	-e 's=â=\&acirc;=g' \
	-e 's=ã=\&atilde;=g' \
	-e 's=ä=\&auml;=g' \
	-e 's=å=\&aring;=g' \
	-e 's=æ=\&aelig;=g' \
	-e 's=ç=\&ccedil;=g' \
	-e 's=è=\&egrave;=g' \
	-e 's=é=\&eacute;=g' \
	-e 's=ê=\&ecirc;=g' \
	-e 's=ë=\&euml;=g' \
	-e 's=ì=\&igrave;=g' \
	-e 's=í=\&iacute;=g' \
	-e 's=î=\&icirc;=g' \
	-e 's=ï=\&iuml;=g' \
	-e 's=ð=\&eth;=g' \
	-e 's=ñ=\&ntilde;=g' \
	-e 's=ò=\&ograve;=g' \
	-e 's=ó=\&oacute;=g' \
	-e 's=ô=\&ocirc;=g' \
	-e 's=õ=\&otilde;=g' \
	-e 's=ö=\&ouml;=g' \
	-e 's=÷=\&divide;=g' \
	-e 's=ø=\&oslash;=g' \
	-e 's=ù=\&ugrave;=g' \
	-e 's=ú=\&uacute;=g' \
	-e 's=û=\&ucirc;=g' \
	-e 's=ü=\&uuml;=g' \
	-e 's=ý=\&yacute;=g' \
	-e 's=þ=\&thorn;=g' \
	-e 's=ÿ=\&yuml;=g' \
	"$@"
