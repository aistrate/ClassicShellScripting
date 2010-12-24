#! /bin/sh -
# Show a sorted list of users with their counts of active
# processes and process names, optionally limiting the
# display to a specified set of users (actually, egrep(1)
# username patterns).
#
# Usage:
#	puser [ user1 user2 ... ]

IFS='
 	'
PATH=/usr/local/bin:/usr/bin:/bin
export PATH

EGREPFLAGS=
while test $# -gt 0
do
    if test -z "$EGREPFLAGS"
    then
	EGREPFLAGS="$1"
    else
	EGREPFLAGS="$EGREPFLAGS|$1"
    fi
    shift
done

if test -z "$EGREPFLAGS"
then
    EGREPFLAGS="."
else
    EGREPFLAGS="^ *($EGREPFLAGS) "
fi

case "`uname -s`" in
    *BSD | Darwin)	PSFLAGS="-a -e -o user,ucomm -x" ;;
    *)			PSFLAGS="-e -o user,comm" ;;
esac

ps $PSFLAGS |
    sed -e 1d |
        EGREP_OPTIONS= egrep "$EGREPFLAGS" |
	    sort -b -k1,1 -k2,2 |
		uniq -c |
		    sort -b -k2,2 -k1nr,1 -k3,3 |
			awk '{
				    user = (LAST == $2) ? " " : $2
				    LAST = $2
				    printf("%-15s\t%2d\t%s\n", user, $1, $3)
			     }'
