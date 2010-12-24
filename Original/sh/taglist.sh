#! /bin/sh -
# Read one or more HTML/SGML/XML files given on the command
# line containing markup like <tag>word</tag> and output on
# standard output a tab-separated list of
#
#	count word tag filename
#
# sorted by ascending word and tag.
# 
# Usage:
#	taglist xml-files

for f in "$@"
do
  cat "$f" |
    sed -e 's#systemitem *role="url"#URL#g' -e 's#/systemitem#/URL#' |
      tr ' (){}[]' '\n\n\n\n\n\n\n' |
        egrep '>[^<>]+</' |
	  awk -F'[<>]' -v FILE="$f" '{printf("%-31s\t%-15s\t%s\n", $3, $2, FILE)}' |
	    sort |
	      uniq -c |
	        sort -k2,2 -k3,3 |
		  awk '{
			  print ($2 == Last) ? ($0 " <----") : $0
			  Last = $2
		       }'
done
