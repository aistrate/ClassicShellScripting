#! /usr/local/bin/gawk -f
# Convert an input stream containing characters in ISO 8859-1
# encoding from the range 128..255 to HTML equivalents in ASCII.
# Characters 0..127 are preserved as normal ASCII.
#
# Usage:
#	iso8859-1-to-html infile(s) >outfile
#
#	***************************************************************
#	* NB: Neither awk nor nawk nor mawk can be used for this job! *
#	***************************************************************

# Most lines probably do not need filtering, so checking with a
# single pattern saves a lot of time
/[\200-\377]/	{ print iso8859_1_to_html($0); next }

		{ print }

# ========================================================================

function iso8859_1_to_html(s)
{
    # From P. Flynn, The WorldWideWeb Handbook, p. 170, Table 8.2

    gsub(" ",	"\\&nbsp;",	s)
    gsub("¡",	"\\&iexcl;",	s)
    gsub("¢",	"\\&cent;",	s)
    gsub("£",	"\\&pound;",	s)
    gsub("¤",	"\\&curren;",	s)
    gsub("¥",	"\\&yen;",	s)
    gsub("¦",	"\\&brvbar;",	s)
    gsub("§",	"\\&sect;",	s)
    gsub("¨",	"\\&uml;",	s)
    gsub("©",	"\\&copy;",	s)
    gsub("ª",	"\\&ordf;",	s)
    gsub("«",	"\\&laquo;",	s)
    gsub("¬",	"\\&not;",	s)
    gsub("­",	"\\&shy;",	s)
    gsub("®",	"\\&reg;",	s)
    gsub("¯",	"\\&macr;",	s)
    gsub("°",	"\\&deg;",	s)
    gsub("±",	"\\&plusmn;",	s)
    gsub("²",	"\\&sup2;",	s)
    gsub("³",	"\\&sup3;",	s)
    gsub("´",	"\\&acute;",	s)
    gsub("µ",	"\\&micro;",	s)
    gsub("¶",	"\\&para;",	s)
    gsub("·",	"\\&middot;",	s)
    gsub("¸",	"\\&cedil;",	s)
    gsub("¹",	"\\&sup1;",	s)
    gsub("º",	"\\&ordm;",	s)
    gsub("»",	"\\&raquo;",	s)
    gsub("¼",	"\\&frac14;",	s)
    gsub("½",	"\\&frac12;",	s)
    gsub("¾",	"\\&frac34;",	s)
    gsub("¿",	"\\&iquest;",	s)

    # Table borrowed from /u/sy/beebe/public_html/support/darmstadt/sgml/psgml/iso88591.map
    # See also UNIX /usr/pub/iso

    gsub("\300",	"\\&Agrave;",	s)
    gsub("\301",	"\\&Aacute;",	s)
    gsub("\302",	"\\&Acirc;",	s)
    gsub("\303",	"\\&Atilde;",	s)
    gsub("\304",	"\\&Auml;",	s)
    gsub("\305",	"\\&Aring;",	s)
    gsub("\306",	"\\&AElig;",	s)
    gsub("\307",	"\\&Ccedil;",	s)
    gsub("\310",	"\\&Egrave;",	s)
    gsub("\311",	"\\&Eacute;",	s)
    gsub("\312",	"\\&Ecirc;",	s)
    gsub("\313",	"\\&Euml;",	s)
    gsub("\314",	"\\&Igrave;",	s)
    gsub("\315",	"\\&Iacute;",	s)
    gsub("\316",	"\\&Icirc;",	s)
    gsub("\317",	"\\&Iuml;",	s)
    gsub("\320",	"\\&ETH;",	s)
    gsub("\321",	"\\&Ntilde;",	s)
    gsub("\322",	"\\&Ograve;",	s)
    gsub("\323",	"\\&Oacute;",	s)
    gsub("\324",	"\\&Ocirc;",	s)
    gsub("\325",	"\\&Otilde;",	s)
    gsub("\326",	"\\&Ouml;",	s)

    gsub("\327",	"\\&times;",	s)	# Multiply sign (missing from iso88591.map)

    gsub("\330",	"\\&Oslash;",	s)
    gsub("\331",	"\\&Ugrave;",	s)
    gsub("\332",	"\\&Uacute;",	s)
    gsub("\333",	"\\&Ucirc;",	s)
    gsub("\334",	"\\&Uuml;",	s)
    gsub("\335",	"\\&Yacute;",	s)
    gsub("\336",	"\\&THORN;",	s)
    gsub("\337",	"\\&szlig;",	s)
    gsub("\340",	"\\&agrave;",	s)
    gsub("\341",	"\\&aacute;",	s)
    gsub("\342",	"\\&acirc;",	s)
    gsub("\343",	"\\&atilde;",	s)
    gsub("\344",	"\\&auml;",	s)
    gsub("\345",	"\\&aring;",	s)
    gsub("\346",	"\\&aelig;",	s)
    gsub("\347",	"\\&ccedil;",	s)
    gsub("\350",	"\\&egrave;",	s)
    gsub("\351",	"\\&eacute;",	s)
    gsub("\352",	"\\&ecirc;",	s)
    gsub("\353",	"\\&euml;",	s)
    gsub("\354",	"\\&igrave;",	s)
    gsub("\355",	"\\&iacute;",	s)
    gsub("\356",	"\\&icirc;",	s)
    gsub("\357",	"\\&iuml;",	s)
    gsub("\360",	"\\&eth;",	s)
    gsub("\361",	"\\&ntilde;",	s)
    gsub("\362",	"\\&ograve;",	s)
    gsub("\363",	"\\&oacute;",	s)
    gsub("\364",	"\\&ocirc;",	s)
    gsub("\365",	"\\&otilde;",	s)
    gsub("\366",	"\\&ouml;",	s)

    gsub("\367",	"\\&divide;",	s)	# Division sign (missing from iso88591.map)

    gsub("\370",	"\\&oslash;",	s)
    gsub("\371",	"\\&ugrave;",	s)
    gsub("\372",	"\\&uacute;",	s)
    gsub("\373",	"\\&ucirc;",	s)
    gsub("\374",	"\\&uuml;",	s)
    gsub("\375",	"\\&yacute;",	s)
    gsub("\376",	"\\&thorn;",	s)
    gsub("\377",	"\\&yuml;",	s)

    return (s)
}
