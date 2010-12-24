	      Code and Data for Classic Shell Scripting
			    [10-Jun-2005]


==============
About the book
==============

This directory contains all of the source code from Classic Shell
Scripting, cataloged in this BibTeX database entry:

	@String{pub-ORA-MEDIA           = "O'Reilly Media, Inc."}
	@String{pub-ORA-MEDIA:adr       = "1005 Gravenstein Highway North,
					   Sebastopol, CA 95472, USA"}

	@Book{Robbins:2005:CSS,
	  author =       "Arnold Robbins and Nelson H. F. Beebe",
	  title =        "Classic Shell Scripting",
	  publisher =    pub-ORA-MEDIA,
	  address =      pub-ORA-MEDIA:adr,
	  pages =        "xxii + 534",
	  year =         "2005",
	  ISBN =         "0-596-00595-4",
	  ISBN-13 =      "978-0-596-00595-5",
	  LCCN =         "????",
	  bibdate =      "Fri Apr 15 07:42:17 2005",
	  URL =          "http://www.oreilly.com/catalog/shellsrptg/",
	  acknowledgement = ack-nhfb,
	}

At the time of writing this, the US Library of Congress Catalog Number
(LCCN) value has not yet been assigned, so its value is temporarily a
string of question marks.

A Bell Labs ref-style entry with similar data is

	%author    Arnold Robbins
	%author    Nelson H. F. Beebe
	%title     Classic Shell Scripting
	%publisher O'Reilly Media, Inc.
	%city      Sebastopol, CA 95472, USA
	%date      2005
	%pages     xxii + 534
	%url       http://www.oreilly.com/catalog/shellsrptg/
	%isbn      0-596-00595-4
	%isbn13    978-0-596-00595-5

A refer-style entry looks like this ("man sortbib" describes the
one-letter keys):

	%A Arnold Robbins
	%A Nelson H. F. Beebe
	%T Classic Shell Scripting
	%I O'Reilly Media, Inc.
	%C Sebastopol, CA 95472, USA
	%D 2005
	%P xxii + 534
	%X URL:    http://www.oreilly.com/catalog/shellsrptg/
	%X ISBN:   0-596-00595-4
	%X ISBN13: 978-0-596-00595-5

Because the 10-digit International Standard Book Number (ISBN) number
space established in 1972 is running out of assignable numbers,
effective 1-Jan-2007, it is replaced by a 13-digit value conforming to
the European Article Numbering (EAN) system.  To convert to the new
system, existing ISBNs get the prefix 978-, and a final check digit
that usually differs from the one in the old 10-digit system.  Library
catalogs and online booksellers started using the new 13-digit form in
mid-2005, and you'll see much more of it in the future.  New books
have the ISBN-13 code printed at the bottom of the bar code on the
back cover, without the embedded field-separator hyphens.  Until the
changeover date, the ISBN-10 is printed at the top of the bar code.


============
Code license
============

From the preface to the book, section Code Examples, p. xix:

    ``The code in this book is published under the terms of the GNU
    General Public License (GPL), which allows copying, reuse,
    and modification of the programs.  See the file COPYING included
    with the examples for the exact terms of the license.''

The COPYING file is in the same directory as this README file.


==========
Data files
==========

The book's data files used in examples are available in two
subdirectories:

	$ ls dat
	danish          is-sort-stable  my-friends  spanish-english
	french-english  latin-numbers   sort-test

	$ ls etc
	chown-files  final.password  passwd-3  u1.passwd  unique2
	dupids       old-new-list    passwd-4  u2.passwd  unique3

The /usr/dict/words file used in the book is from Sun Solaris 9, so we
cannot distribute it here.  Your system may have a file of that name,
or it may have instead /usr/share/dict/words or
/usr/share/lib/dict/words.


=============
Shell scripts
=============

The book's shell scripts are available as *.sh files in the sh
subdirectory; when they get installed in a bin directory in the PATH,
the .sh suffixes get stripped (this practice is common in the
"make install" step in Unix Makefiles).

	$ ls sh
	build-all.sh                   looper-intsig.sh
	debug-trap.sh                  looper.sh
	desgml.sh                      merge-systems.sh
	dexml.sh                       myspell.sh
	diskhogs.sh                    pathfind.sh
	english.sfx                    probreport.sh
	err-trap.sh                    puser.sh
	filesdirectories.sh            puzzle-help.sh
	french.sfx                     show-identical-files.sh
	getpubkey.sh                   simple-top.sh
	iso8859-1-to-html-with-sed.sh  spell-with-aspell.sh
	iso8859-1-to-html.sh           spell-with-ispell.sh
	kp-spell.sh                    taglist.sh
	looper-2.sh                    wf.sh


============
awk programs
============

The book's awk scripts are available as .sh files in the awk
subdirectory:

	$ ls awk
	irand.awk  ofmt.awk   split.awk     test-good-irand.awk
	join.awk   spell.awk  splitout.awk


============
Manual pages
============

Document for the book's larger programs are availabe in a variety of
input and output formats in the man subdirectory:

	$ ls man
	Makefile        build-all.sok   myspell.ps     pathfind.pdf
	build-all.html  build-all.texi  myspell.sok    pathfind.ps
	build-all.info  myspell.html    myspell.texi   pathfind.sok
	build-all.man   myspell.info    pathfind.html  pathfind.texi
	build-all.pdf   myspell.man     pathfind.info
	build-all.ps    myspell.pdf     pathfind.man


=================
Software packages
=================

Because we anticipate that at least three of the book's programs may
be of wide interest, we have packaged them separately and given them
their own Web and FTP sites (they each lead to the same physical
directory):

	ftp://ftp.math.utah.edu/pub/build-all
	ftp://ftp.math.utah.edu/pub/myspell
	ftp://ftp.math.utah.edu/pub/pathfind

	http://www.math.utah.edu/pub/build-all
	http://www.math.utah.edu/pub/myspell
	http://www.math.utah.edu/pub/pathfind

Consult those locations for the latest versions, which may have
evolved further from the frozen code at the book's Web site, and have
the advantage of autoconfigure support.

You can fetch, verify a digital signature, unpack, build, validate,
and install a distribution from one of those locations like this
example:

	$ wget http://www.math.utah.edu/pub/build-all/build-all-1.05.tar.gz
	$ wget http://www.math.utah.edu/pub/build-all/build-all-1.05.tar.gz.sig
	$ pgp build-all-1.05.tar.gz.sig
	$ tar xfz build-all-1.05.tar.gz.sig
	$ cd build-all-1.05
	$ ./configure && make all check install

If your system lacks GNU tar, then that step is a bit more complex:

	$ gunzip < build-all-1.05.tar.gz.sig | tar xf -


======================
Bibliographic database
======================

Bibliography entries for the bibliography in the book were extracted
from BibTeX entries in assorted database files maintained by the
second author, and manually reformatted into Docbook/XML in the book's
source files.  The BibTeX entries are collected into a single database
file with associated support files available at these locations:

	ftp://ftp.math.utah.edu/pub/css.*
	http://www.math.utah.edu/pub/tex/bib/index-table-c.html#css


================================
Uniform Resource Locators (URLs)
================================

The book contains more than 150 Web addresses, some of which you may
wish to visit, but probably don't care to retype.  Here is a list of
them, in lexicographical order by chapter:

	Foreword

	Preface
		http://www.cygwin.com/
		http://www.delorie.com/djgpp/
		http://www.mks.com/
		http://www.mkssoftware.com/products/tk/ds_tkpdev.asp
		http://www.opengroup.org/austin/papers/backgrounder.html
		http://www.opengroup.org/austin/papers/posix_faq.html
		http://www.oreilly.com/catalog/shellsrptg/
		http://www.research.att.com/sw/tools/uwin/
		http://www.unix.org/version3/
		http://www.unix.org/version3/online.html
		http://www.unix.org/

	Chapter 1 --- Background
		http://netpbm.sourceforge.net/
		http://www.bell-labs.com/history/unix
		http://www.opengroup.org/publications/catalog/

	Chapter 2 --- Getting Started
		ftp://ftp.gnu.org/gnu/gettext/
		http://foldoc.doc.ic.ac.uk/foldoc/foldoc.cgi?Ousterhout's+dichotomy
		http://userpage.chemie.fu-berlin.de/diverse/doc/ISO_3166.html
		http://www.ics.uci.edu/pub/ietf/http/related/iso639.txt

	Chapter 3 --- Searching and Substitutions
		ftp://ftp.cs.arizona.edu/agrep/agrep-2.04.tar.Z
		ftp://ftp.gnu.org/gnu/less/
		ftp://ftp.gnu.org/gnu/sed/
		ftp://rtfm.mit.edu/pub/faqs/editor-faq/sed
		http://sed.sourceforge.net/
		http://www.dreamwvr.com/sed-info/sed-faq.html
		http://www.tgries.de/agrep/337/agrep337.zip

	Chapter 4 --- Text Processing Tools
		ftp://ftp.astron.com/pub/file/
		ftp://ftp.gnu.org/gnu/a2ps/
		ftp://ftp.gnu.org/gnu/coreutils/
		http://www.cups.org/
		http://www.lprng.org/
		http://www.marx-brothers.org/
		http://www.math.utah.edu/pub/lptops/
		http://www.math.utah.edu/pub/tgrind/
		http://www.math.utah.edu/pub/vgrind/

	Chapter 5 --- Pipelines Can Do Amazing Things
		ftp://ftp.ox.ac.uk/pub/wordlists/
		ftp://ibiblio.org/pub/docs/books/gutenberg/etext96/pgw*
		ftp://qiclab.scn.rain.com/pub/wordlists/
		http://www.gutenberg.net/
		http://www.math.utah.edu/pub/sgml/
		http://www.math.utah.edu/pub/tex/bib/sgml.html
		http://www.math.utah.edu/pub/tex/bib/sgml2000.html
		http://www.math.utah.edu/pub/tex/bib/sqlbooks.html
		http://www.openoffice.org/
		http://www.phreak.org/html/wordlists.shtml
		http://www.tldp.org/

	Chapter 6 --- Variables, Making Decisions, and Repeating Actions

	Chapter 7 --- Input and Output, Files, and Command Evaluation

	Chapter 8 --- Production Scripts
		http://www.info-zip.org/
		http://www.iso.ch/cate/d26780.html

	Chapter 9 --- Enough awk to Be Dangerous
		ftp://ftp.gnu.org/gnu/gawk/
		ftp://ftp.gnu.org/gnu/texinfo/
		ftp://ftp.whidbey.net/pub/brennan/mawk-1.3.3.tar.gz
		http://awka.sourceforge.net/
		http://cm.bell-labs.com/who/bwk/awk.tar.gz
		http://mathworld.wolfram.com/AckermannFunction.html

	Chapter 10 --- Working with Files
		ftp://ftp.geekreview.org/slocate/
		ftp://ftp.gnu.org/gnu/findutils/
		ftp://ftp.gnu.org/gnu/wget/
		ftp://ftp.gnupg.org/gcrypt/gnupg/
		ftp://ftp.internic.net/rfc/rfc1321.txt
		ftp://ftp.mktemp.org/pub/mktemp/
		http://math-www.uni-paderborn.de/pgp/
		http://pgp.mit.edu/
		http://pgp.mit.edu:11371/pks/lookup?op=get&search=KEYID-GOES-HERE
		http://pgp.zdv.uni-mainz.de/keyserver/pks-commands.html#extract
		http://sunrpms.maraudingpirates.org/HowTo.html
		http://sunsolve.sun.com/
		http://web.mit.edu/network/pgp.html
		http://www.cerberussystems.com/INFOSEC/stds/fip180-1.htm
		http://www.cl.cam.ac.uk/PGP/pks-commands.html#extract
		http://www.cosy.sbg.ac.at/~andi/SUNrand/pkg/random-0.7a.tar.gz
		http://www.gnupg.org/
		http://www.keyserver.net/en/
		http://www.math.utah.edu/pub/checksum/

	Chapter 11 --- Extended Example: Merging User Databases
		http://linux.oreillynet.com/pub/a/linux/2002/05/09/uid.html

	Chapter 12 --- Spellchecking
		ftp://ftp.gnu.org/gnu/aspell/
		ftp://ftp.gnu.org/gnu/non-gnu/ispell/
		ftp://labrea.stanford.edu/pub/dict/words.gz
		http://aspell.net/
		http://ficus-www.cs.ucla.edu/geoff/ispell.html
		http://www.math.utah.edu/pub/pawk/
		http://www.math.utah.edu/pub/tex/bib/index-table-s.html#spell
		http://www.tuhs.org/

	Chapter 13 --- Processes
		ftp://ftp.cs.toronto.edu/pub/jdd/xcpustate/
		ftp://ftp.groupsys.com/pub/top/
		http://gridengine.sunsource.net/
		http://procps.sourceforge.net/
		http://supercluster.org/maui/
		http://supercluster.org/silver/
		http://www.apple.com/acg/xgrid/
		http://www.gnqs.org/
		http://www.ibm.com/servers/eserver/pseries/library/sp_books/loadleveler.html
		http://www.magnicomp.com/sysinfo/
		http://www.openpbs.org/
		http://www.platform.com/products/LSFfamily/
		http://www.scri.fsu.edu/pub/dqs
		http://www.sun.com/bigadmin/scripts/submittedScripts/quicktop.ksh.txt

	Chapter 14 --- Shell Portability Issues and Extensions
		ftp://ftp.cwru.edu/pub/bash/bash-3.0-patches/
		ftp://ftp.gnu.org/gnu/bash/bash-3.0.tar.gz
		ftp://ftp.ncftp.com/ncftp/
		http://web.cs.mun.ca/~michael/pdksh/
		http://www.research.att.com/sw/download
		http://www.star.le.ac.uk/~tjg/rc/
		http://www.zsh.org/

	Chapter 15 --- Secure Shell Scripts: Getting Started
		http://www.cerias.purdue.edu/
		http://www.courtesan.com/sudo
		http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html:

	Appendix A --- Writing Manual Pages
		http://docs.sun.com/
		http://www.gnu.org/software/texinfo/
		http://www.math.utah.edu/pub/chkdelim/
		http://www.math.utah.edu/pub/dw/
		http://www.math.utah.edu/pub/man2html/
		http://www.math.utah.edu/pub/man2texi/
		http://www.tldp.org/
		http://www.troff.org/

	Appendix B --- Files and Filesystems
		ftp://ftp.cs.wisc.edu/pub/paradyn/fuzz/
		ftp://ftp.cs.wisc.edu/pub/paradyn/technical_papers/fuzz*
		ftp://ftp.gnu.org/gnu/glibc/
		ftp://ftp.internic.net/rfc/rfc2279.txt
		ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/
		http://aa.usno.navy.mil/faq/docs/UT.html
		http://ethesis.helsinki.fi/julkaisut/oik/julki/pg/parviainen/
		http://lpf.ai.mit.edu/Links/prep.ai.mit.edu/patent-list
		http://www.boulder.nist.gov/timefreq/general/misc.htm
		http://www.cl.cam.ac.uk/~mgk25/ieee02-optical.pdf
		http://www.columbia.edu/kermit/
		http://www.ibm.com/linux/
		http://www.iso.ch/iso/en/CatalogueListPage.CatalogueList
		http://www.math.utah.edu/pub/dosmacux/
		http://www.math.utah.edu/pub/tex/bib/index-table.html
		http://www.npl.co.uk/time/time_scales.html
		http://www.openbsd.org/cgi-bin/man.cgi?query=getconf&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html
		http://www.openssh.org/
		http://www.ssh.com/
		http://www.zdnet.com/zdnn/stories/news/0,4586,2673461,00.html

	Appendix C --- Important Unix Commands

	Bibliography
		http://cm.bell-labs.com/cm/cs/awkbook
		http://cm.bell-labs.com/cm/cs/tpop
		http://cm.bell-labs.com/cm/cs/upe
		http://plan9.bell-labs.com/7thEdMan
		http://www.cs.bell-labs.com/cm/cs/pearls/
		http://www.opengroup.org/onlinepubs/007904975
		http://www.oreilly.com/catalog
		http://www.standards.ieee.org/
		http://www.w3.org/TR/REC-xml/

	Glossary
		ftp://ftp.example.com/pub/xml/README
		ftp://ftp.gnu.org/gnu/rcs/
		ftp://ftp.isi.edu/rfc/
		http://lpf.ai.mit.edu/Links/prep.ai.mit.edu/patent-list
		http://patft.uspto.gov/netahtml/srchnum.htm
		http://www.bell-labs.com/history/unix/business.html
		http://www.ida.liu.se/~petfr/princprog/envpaper.pdf
		http://www.ietf.org/internet-drafts/
		http://www.jclark.com/
		http://www.openafs.org/
		http://www.transarc.ibm.com/
		http://www.unix.org/version3/
