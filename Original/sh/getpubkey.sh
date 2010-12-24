#! /bin/sh -
# Get one or more PGP/GPG keys from a key server.
#
# Usage:
#       getpubkey key-ID-1 key-ID-2 ...

IFS='
 	'

PATH=/usr/local/bin:/usr/bin:/bin
export PATH

for f in "$@"
do
	g=0x`echo $f | sed -e s'/^0x//'`
	tmpfile=/tmp/pgp-$g.tmp.$$
	wget -q -O - "http://pgp.mit.edu:11371/pks/lookup?op=get&search=$g" > $tmpfile
	ls -l $tmpfile
	echo "Try:	pgp -ka $tmpfile"
 	echo "    	pgpgpg -ka $tmpfile"
 	echo "    	rm -f $tmpfile"
done
