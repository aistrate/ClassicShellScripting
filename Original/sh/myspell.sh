#! /bin/sh -
# ======================================================================
# This is a shell script interface to the multilingual spelling checker.
# The locale can be set explicitly with the --locale name option, or
# implicitly via the environment variable LANG.  The distinction is that
# with the latter, the default English dictionaries and suffix lists
# will be used if no locale-specific dictionaries are installed, while
# with the former, at least one locale-specific dictionary must be
# found.
#
# Usage:
#	myspell [ --? ] \
#		[ --dictionary dictfile ] \
#		[ --help ] \
#		[ --locale name ] \
#		[ --privatedictionary dictfile ] \
#		[ --strip  ] \
#		[ --suffixrules rulefile ] \
#		[ --verbose ] \
#		[ --version ] \
#		[ +dictfile ] \
#		[ =rulefile ] \
#		[ -- ] \
#		[ file(s) ]
#
# ======================================================================
IFS='
 	'

PATH=/bin:/usr/bin
export PATH

DATE="[26-Jun-2003]"
PROGRAM=$0
VERSION=myspell-1.00

error()
{
	echo ERROR: "$@" >&2
	usage_and_exit 1
}

usage_and_exit()
{
	# echo DEBUG: usage_and_exit...
	cat >&2 <<EOF
Usage:
$PROGRAM	[ --? ] [ --dictionary dictfile ] [ --help ] \\
			[ --locale name ] [ --privatedictionary dictfile ] \\
			[ --suffixrules rulefile ] [ --verbose ] \\
			[ --version ] [ +dictfile ] [ =rulefile ] [ -- ] \\
			[ file(s) ]
EOF
	exit $1
}

version_and_exit()
{
	echo "$VERSION $DATE" >&2
	exit 0
}

LIBDIR=`dirname $PROGRAM`/../share/myspell/$VERSION
LOCALEDIR=$LIBDIR/locale

# Temporary during development
# LIBDIR=/u/sy/beebe/xml/shbook/awk

# Temporary do-nothing version for debugging
# AWK="echo awk"
AWK=${AWK:-/usr/local/bin/nawk}

DICTIONARIES=
PRIVATEDICTIONARIES=
SPELLFLAGS=
SUFFIXRULES=

# If we have a locale set, choose a set of dictionaries accordingly, if
# they are available
if test -n "$LANG" -a -d "$LOCALEDIR/$LANG"
then
	DICTIONARIES="`find $LOCALEDIR/$LANG/*.dict`"
	SUFFIXRULES="`find $LOCALEDIR/$LANG/*.sfx`"
fi

while test $# -gt 0
do
	case $1 in
	-- )			# everything else must be a file
		shift
		break
		;;

	-dictionary | -dictionar | -dictiona | -diction | -dictio | \
	-dicti | -dict | -dic | -di | -d | \
	--dictionary | --dictionar | --dictiona | --diction | --dictio | \
	--dicti | --dict | --dic | --di | --d )
		shift
		DICTIONARIES="$DICTIONARIES $1"
		;;

	-help | -hel | -he | -h | \
	--help | --hel | --he | --h | \
	'-?' )
		usage_and_exit 0
		;;

	-locale | -local | -loca | -loc | -lo | -l | \
	--locale | --local | --loca | --loc | --lo | --l )
		shift
		if test -d $LOCALEDIR/$1
		then
			DICTIONARIES="`find $LOCALEDIR/$1/*.dict`"
			test -z "$DICTIONARIES" && error No dictionaries available for locale $1
		else
			error No dictionaries available for locale $1
		fi
		;;

	-privatedictionary | -privatedictionar | -privatedictiona | \
	-privatediction | -privatedictio | -privatedicti | \
	-privatedict | -privatedic | -privatedi | -privated | \
	-private | -privat | -priva | -priv | -pri | -pr | -p | \
	--privatedictionary | --privatedictionar | --privatedictiona | \
	--privatediction | --privatedictio | --privatedicti | \
	--privatedict | --privatedic | --privatedi | --privated | \
	--private | --privat | --priva | --priv | --pri | --pr | --p )
		shift
		PRIVATEDICTIONARIES="$PRIVATEDICTIONARIES +$1"
		;;

	-strip | -stri | -str | -st | \
	--strip | --stri | --str | --st )
		SPELLFLAGS="$SPELLFLAGS -strip"
		;;

	-suffixrules | -suffixrules | -suffixrule | -suffixrul | \
	-suffixru | -suffixr | -suffix | -suffi | -suff | -suf | \
	-su | -s | \
	--suffixrules | --suffixrules | --suffixrule | --suffixrul | \
	--suffixru | --suffixr | --suffix | --suffi | --suff | --suf | \
	--su | --s )
		shift
		SUFFIXRULES="$SUFFIXRULES =$1"
		;;

	-verbose | -verbos | -verbo | -verb | -ver | -ve | -v | \
	--verbose | --verbos | --verbo | --verb | --ver | --ve | --v )
		SPELLFLAGS="$SPELLFLAGS -verbose"
		;;

	-version | -versio | -versi | -vers | \
	--version | --versio | --versi | --vers )
		version_and_exit
		;;

	+*)
		PRIVATEDICTIONARIES="$PRIVATEDICTIONARIES $1"
		;;

	=*)
		SUFFIXRULES="$SUFFIXRULES $1"
		;;

	-*)
		error Unrecognized option $1
		usage_and_exit 1
		;;

	*)			# everything else must be a file
		break
	esac
	shift
done

test -n "$DICTIONARIES" && export DICTIONARIES && echo "DEBUG: DICTIONARIES = $DICTIONARIES"

$AWK -f $LIBDIR/spell.awk -- $PRIVATEDICTIONARIES $SUFFIXRULES "$@"
