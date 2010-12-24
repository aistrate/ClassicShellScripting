#!/bin/sh

# Unix spell treats a first argument of `+file' as providing a
# personal spelling list.  Let's do that too.

mydict=
case $1 in
+?*)    mydict=${1#+}   # strip off leading +
        mydict="-p $mydict"
        shift
        ;;
esac

cat "$@" | ispell -l $mydict | sort -u
