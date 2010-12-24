#! /bin/sh -
# Kernighan & Plauger's 1981 Software Tools in Pascal spell checking
# pipeline, modernized to current Unix tools.
#
# Usage:
#	kp-spell.sh [ file(s) ]

IFS='
 	'

PATH=/usr/local/bin:/bin:/usr/bin
export PATH

DICTFILE=/tmp/kp-spell.dict.$$
trap "exit 1" HUP INT QUIT PIPE TERM
trap "rm -f $DICTFILE" EXIT
cat /usr/dict/words /usr/local/share/dict/words.knuth | sort -u > $DICTFILE

cat "$@" |
  tr A-Z a-z |
    tr -c a-z '\n' |
      sort |
	uniq |
	  comm -13 $DICTFILE -
