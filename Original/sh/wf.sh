#! /bin/sh
# Read a text stream on standard input, and output a list of
# the n (default: 25) most frequently-occurring words and
# their frequency counts, in order of descending counts, on
# standard output.
#
# Usage:
#	wf [n]

tr -cs A-Za-z\' '\n' |
    tr A-Z a-z |
	sort |
	    uniq -c |
		sort -k1nr -k2 |
		    sed ${1:-25}q

