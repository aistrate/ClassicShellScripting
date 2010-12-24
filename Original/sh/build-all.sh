#! /bin/sh -
# Build one or more packages in parallel on one or more build hosts.
#
# Usage:
#	build-all [ --? ]
#		  [ --all "..." ]
#		  [ --cd "..." ]
#		  [ --check "..." ]
#		  [ --configure "..." ]
#		  [ --environment "..." ]
#		  [ --help ]
#		  [ --logdirectory dir ]
#		  [ --on "[user@]host[:dir][,envfile] ..." ]
#		  [ --source "dir ..." ]
#		  [ --userhosts "file(s)" ]
#		  [ --version ]
#		  package(s)
#
# Optional initialization files:
#	$HOME/.build/directories	list of source directories
#	$HOME/.build/userhosts		list of [user@]host[:dir][,envfile]

IFS='
 	'

PATH=/usr/local/bin:/bin:/usr/bin
export PATH

UMASK=002
umask $UMASK

build_one()
{
	# Usage:
	#	build_one [user@]host[:build-directory][,envfile]

	arg="`eval echo $1`"

	userhost="`echo $arg | sed -e 's/:.*$//'`"

	user="`echo $userhost | sed -e s'/@.*$//'`"
	test "$user" = "$userhost" && user=$USER

	host="`echo $userhost | sed -e s'/^[^@]*@//'`"

	envfile="`echo $arg | sed -e 's/^[^,]*,//'`"
	test "$envfile" = "$arg" && envfile=/dev/null

	builddir="`echo $arg | sed -e s'/^.*://' -e 's/,.*//'`"
	test "$builddir" = "$arg" && builddir=/tmp

	parbase=`basename $PARFILE`

	# NB: update find_package() if these patterns are changed
	package="`echo $parbase | \
		sed	-e 's/[.]jar$//' \
			-e 's/[.]tar[.]bz2$//' \
			-e 's/[.]tar[.]gz$//' \
			-e 's/[.]tar[.]Z$//' \
			-e 's/[.]tar$//' \
			-e 's/[.]tgz$//' \
			-e 's/[.]zip$//'`"

	## echo "DEBUG: LOGDIR   = $LOGDIR"
	## echo "DEBUG: PARFILE  = $PARFILE"
	## echo "DEBUG: PAR      = $PAR"
	## echo "DEBUG: package  = $package"
	## echo "DEBUG: arg      = $arg"
	## echo "DEBUG: userhost = $userhost"
	## echo "DEBUG: host     = $host"
	## echo "DEBUG: builddir = $builddir"

	# Copy the package file if we cannot see it on the remote host
	echo $SSH $SSHFLAGS $userhost "test -f $PARFILE"
	if $SSH $SSHFLAGS $userhost "test -f $PARFILE"
	then
		parbaselocal=$PARFILE
	else
		parbaselocal=$parbase
		echo $SCP $PARFILE $userhost:$builddir
		$SCP $PARFILE $userhost:$builddir
	fi

	# Unbundle the archive file on the remote host, build, and
	# check it, running in the background

	sleep 1			# to guarantee unique log filename
	now="`date $DATEFLAGS`"
	logfile="$package.$host.$now.log"

	## echo "DEBUG: LOGFILE  = $LOGDIR/$package.$host.$now.log"

	nice $SSH $SSHFLAGS $userhost "
			echo '============================================================' ;
		        test -f $BUILDBEGIN && . $BUILDBEGIN || test -f $BUILDBEGIN && source $BUILDBEGIN || true ;
			echo 'Package:                $package' ;
			echo 'Archive:                $PARFILE' ;
			echo 'Date:                   $now' ;
			echo 'Local user:             $USER' ;
			echo 'Local host:             `hostname`' ;
			echo 'Local log directory:    $LOGDIR' ;
			echo 'Local log file:         $logfile' ;
			echo 'Remote user:            $user' ;
			echo 'Remote host:            $host' ;
			echo 'Remote directory:       $builddir' ;
			printf 'Remote date:            ' ;
			date $DATEFLAGS ;
			printf 'Remote uname:           ' ;
			uname -a || true ;
			printf 'Remote gcc version:     ' ;
			gcc --version | head -n 1 || echo ;
			printf 'Remote g++ version:     ' ;
			g++ --version | head -n 1 || echo ;
			echo 'Configure environment:  `$STRIPCOMMENTS $envfile | $JOINLINES`' ;
			echo 'Extra environment:      $EXTRAENVIRONMENT' ;
			echo 'Configure directory:    $CONFIGUREDIR' ;
			echo 'Configure flags:        $CONFIGUREFLAGS' ;
			echo 'Make all targets:       $ALLTARGETS' ;
			echo 'Make check targets:     $CHECKTARGETS' ;
			echo 'Disk free report for $builddir/$package:' ;
			df $builddir | $INDENT ;
			echo 'Environment:' ;
			env | env LC_ALL=C sort | $INDENT ;
			echo '============================================================' ;
			umask $UMASK ;
			cd $builddir || exit 1 ;
			/bin/rm -rf $builddir/$package ;
			$PAR $parbaselocal ;
			test "$parbase" = "$parbaselocal" && /bin/rm -f $parbase ;
			cd $package/$CONFIGUREDIR || exit 1 ;
			test -f configure && \
				chmod a+x configure && \
					env `$STRIPCOMMENTS $envfile | $JOINLINES` \
						$EXTRAENVIRONMENT \
							nice time ./configure $CONFIGUREFLAGS ;
			nice time make $ALLTARGETS && nice time make $CHECKTARGETS ;
			echo '============================================================' ;
			echo 'Disk free report for $builddir/$package:' ;
			df $builddir | $INDENT ;
			printf 'Remote date:            ' ;
			date $DATEFLAGS ;
			cd ;
		        test -f $BUILDEND && . $BUILDEND || test -f $BUILDEND && source $BUILDEND || true ;
			echo '============================================================' ;
		" < /dev/null > "$LOGDIR/$logfile" 2>&1 &
}

error()
{
	echo "$@" 1>&2
	usage_and_exit 1
}

find_file()
{
	# Usage:
	#	find_file file program-and-args
	# Return 0 (success) if found, 1 (failure) if not found

	if test -r "$1"
	then
		PAR="$2"
		PARFILE="$1"
		return 0
	else
		return 1
	fi
}

find_package()
{
	# Usage: find_package package-x.y.z
	base=`echo "$1" | sed -e 's/[-_][.]*[0-9].*$//'`
## echo "DEBUG: find_package $1"
## echo "DEBUG: SRCDIRS = $SRCDIRS"
	PAR=
	PARFILE=
	for srcdir in $SRCDIRS
	do
		test "$srcdir" = "." && srcdir="`pwd`"
## echo "DEBUG: srcdir = $srcdir"

		for subdir in "$base" ""
		do
			# NB: update package setting in build_one() if this list changes
			find_file $srcdir/$subdir/$1.tar.gz	"tar xfz"	&& return
			find_file $srcdir/$subdir/$1.tar.Z	"tar xfz"	&& return
			find_file $srcdir/$subdir/$1.tar	"tar xf"	&& return
			find_file $srcdir/$subdir/$1.tar.bz2	"tar xfj"	&& return
			find_file $srcdir/$subdir/$1.tgz	"tar xfz"	&& return
			find_file $srcdir/$subdir/$1.zip	"unzip -q"	&& return
			find_file $srcdir/$subdir/$1.jar	"jar xf"	&& return
		done
	done
}

set_userhosts()
{
	# Usage: set_userhosts file(s)
	for u in "$@"
	do
		if test -r "$u"
		then
			ALTUSERHOSTS="$ALTUSERHOSTS $u"
		elif test -r "$BUILDHOME/$u"
		then
			ALTUSERHOSTS="$ALTUSERHOSTS $BUILDHOME/$u"
		else
			error "File not found: $u"
		fi
	done
}

usage()
{
	cat <<EOF
Usage:
	$PROGRAM [ --? ]
			[ --all "..." ]
			[ --cd "..." ]
			[ --check "..." ]
			[ --configure "..." ]
			[ --environment "..." ]
			[ --help ]
			[ --logdirectory dir ]
			[ --on "[user@]host[:dir][,envfile] ..." ]
			[ --source "dir ..." ]
			[ --userhosts "file(s)" ]
			[ --version ]
			package(s)
EOF
}

usage_and_exit()
{
	usage
	exit $1
}

version()
{
	echo "$PROGRAM version $VERSION"
}

warning()
{
	echo "$@" 1>&2
	EXITCODE=`expr $EXITCODE + 1`
}

ALLTARGETS=
altlogdir=
altsrcdirs=
ALTUSERHOSTS=
BUILDBEGIN=./.build/begin
BUILDEND=./.build/end
BUILDHOME=$HOME/.build
CHECKTARGETS=check
CONFIGUREDIR=.
CONFIGUREFLAGS=
DATEFLAGS="+%Y.%m.%d.%H.%M.%S"
EXITCODE=0
EXTRAENVIRONMENT=
INDENT="awk '{ print \"\t\t\t\" \$0 }'"
JOINLINES="tr '\n' '\040'"
LOGDIR=
PROGRAM=`basename $0`
SCP=scp
SSH=ssh
# SCP="echo scp"
# SSH="echo ssh"
SSHFLAGS=${SSHFLAGS--x}
STRIPCOMMENTS='sed -e s/#.*$//'
userhosts=
VERSION=1.0

# Default initialization files
defaultdirectories=$BUILDHOME/directories
defaultuserhosts=$BUILDHOME/userhosts

# List of places to find package distributions, with a default
# list if the user has no personalized list:
SRCDIRS="`$STRIPCOMMENTS $defaultdirectories 2> /dev/null`"
test -z "$SRCDIRS" && \
	SRCDIRS="
			.
			/usr/local/src
			/usr/local/gnu/src
			$HOME/src
			$HOME/gnu/src
			/tmp
			/usr/tmp
			/var/tmp
		"

while test $# -gt 0
do
	case $1 in

	--all | --al | --a | -all | -al | -a )
		shift
		ALLTARGETS="$1"
		;;

	--cd | -cd )
		shift
		CONFIGUREDIR="$1"
		;;

	--check | --chec | --che | --ch | -check | -chec | -che | -ch )
		shift
		CHECKTARGETS="$1"
		;;

	--configure | --configur | --configu | --config | --confi | \
	--conf | --con | --co | \
	-configure | -configur | -configu | -config | -confi | \
	-conf | -con | -co )
		shift
		CONFIGUREFLAGS="$1"
		;;

	--environment | --environmen | --environme | --environm | --environ | \
	--enviro | --envir | --envi | --env | --en | --e | \
	-environment | -environmen | -environme | -environm | -environ | \
	-enviro | -envir | -envi | -env | -en | -e )
		shift
		EXTRAENVIRONMENT="$1"
		;;

	--help | --hel | --he | --h | '--?' | -help | -hel | -he | -h | '-?' )
		usage_and_exit 0
		;;

	--logdirectory | --logdirector | --logdirecto | --logdirect | \
	--logdirec | --logdire | --logdir | --logdi | --logd | --log | \
	--lo | --l | \
	-logdirectory | -logdirector | -logdirecto | -logdirect | \
	-logdirec | -logdire | -logdir | -logdi | -logd | -log | -lo | -l )
		shift
		altlogdir="$1"
		;;

	--on | --o | -on | -o )
		shift
		userhosts="$userhosts $1"
		;;

	--source | --sourc | --sour | --sou | --so | --s | \
	-source | -sourc | -sour | -sou | -so | -s )
		shift
		altsrcdirs="$altsrcdirs $1"
		;;

	--userhosts | --userhost | --userhos | --userho | --userh | \
	--user | --use | --us | --u | \
	-userhosts | -userhost | -userhos | -userho | -userh | \
	-user | -use | -us | -u )
		shift
		set_userhosts $1
		;;

	--version | --versio | --versi | --vers | --ver | --ve | --v | \
	-version | -versio | -versi | -vers | -ver | -ve | -v )
		version
		exit 0
		;;

	-*)
		error "Unrecognized option: $1"
		;;

	*)
		break
		;;

	esac
	shift
done

# Find a suitable mail client
for MAIL in /bin/mailx /usr/bin/mailx /usr/sbin/mailx /usr/ucb/mailx /bin/mail /usr/bin/mail
do
	test -x $MAIL && break
done
test -x $MAIL || error "Cannot find mail client"

# Command-line source directories precede defaults
SRCDIRS="$altsrcdirs $SRCDIRS"

if test -n "$userhosts"
then
	test -n "$ALTUSERHOSTS" &&
	    userhosts="$userhosts `$STRIPCOMMENTS $ALTUSERHOSTS 2> /dev/null`"
else
	test -z "$ALTUSERHOSTS" && ALTUSERHOSTS="$defaultuserhosts"
	userhosts="`$STRIPCOMMENTS $ALTUSERHOSTS 2> /dev/null`"
fi

# Check for something to do
test -z "$userhosts" && usage_and_exit 1

for p in "$@"
do
	find_package "$p"

	if test -z "$PARFILE"
	then
		warning "Cannot find package file $p"
		continue
	fi

	LOGDIR="$altlogdir"
	if test -z "$LOGDIR" -o ! -d "$LOGDIR" -o ! -w "$LOGDIR"
	then
		for LOGDIR in "`dirname $PARFILE`/logs/$p" $BUILDHOME/logs/$p /usr/tmp /var/tmp /tmp
		do
			test -d "$LOGDIR" || mkdir -p "$LOGDIR" 2> /dev/null
			test -d "$LOGDIR" -a -w "$LOGDIR" && break
		done
	fi

	msg="Check build logs for $p in `hostname`:$LOGDIR"
	echo "$msg"
	echo "$msg" | $MAIL -s "$msg" $USER 2> /dev/null

	for u in $userhosts
	do
		build_one $u
	done
done

# Limit exit status to common Unix practice
test $EXITCODE -gt 125 && EXITCODE=125

exit $EXITCODE
