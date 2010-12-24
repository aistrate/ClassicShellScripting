# Implement a simple spelling checker, with user-specifiable exception
# lists.  The built-in dictionary is constructed from a list of
# standard Unix spelling dictionaries, overridable on the command line.
#
# Dictionaries are simple text files, with one word per line.  Unlike
# those for Unix spell(1), the dictionaries need not be sorted, and
# there is no dependence on the locale in this program that can affect
# which exceptions are reported, although the locale can affect their
# reported order in the exception list.  A default list of dictionaries
# can be supplied via the environment variable DICTIONARIES, but that
# can be overridden on the command line.
#
# For the purposes of this program, words are located by replacing ASCII
# control characters, digits, and punctuation (except apostrophe) with
# ASCII space (32).  What remains are the words to be matched against
# the dictionary lists.  Thus, files in ASCII and ISO-8859-n encodings
# are supported, as well as Unicode files in UTF-8 encoding.
#
# All word matching is case insensitive (subject to the workings of
# tolower()).
#
# In this simple version, which is intended to support multiple
# languages, no attempt is made to strip word suffixes, unless the
# +strip option is supplied.
#
# Suffixes are defined as regular expressions, and may be supplied from
# suffix files (one per name) named on the command line, or from an
# internal default set of English suffixes.  Comments in the suffix file
# run from sharp (#) to end of line.  Each suffix regular expression
# should end with $, to anchor the expression to the end of the word.
# Each suffix expression may be followed by a list of one or more
# strings that can replace it, with the special convention that ""
# represents an empty string.  For example:
#
#	ies$	ie ies y	# flies -> fly, series -> series, ties -> tie
#	ily$	y ily		# happily -> happy, wily -> wily
#	nnily$	n		# funnily -> fun
#
# Although it is permissible to include the suffix in the replacement
# list, it is not necessary to do so, since words are looked up before
# suffix stripping.
#
# Suffixes are tested in order of decreasing length, so that the longest
# matches are tried first.
#
# The default output is just a sorted list of unique spelling
# exceptions, one per line.  With the +verbose option, output lines
# instead take the form
#
#	filename:linenumber:exception
#
# Some Unix text editors recognize such lines, and can use them to move
# quickly to the indicated location.
#
# Usage:
#	awk [-v Dictionaries="sysdict1 sysdict2 ..."] -f spell.awk -- \
#	    [=suffixfile1 =suffixfile2 ...] [+dict1 +dict2 ...] \
#	    [-strip] [-verbose] [file(s)]

BEGIN	{ initialize() }

	{ spell_check_line() }

END	{ report_exceptions() }

function get_dictionaries(        files, key)
{
    if ((Dictionaries == "") && ("DICTIONARIES" in ENVIRON))
	Dictionaries = ENVIRON["DICTIONARIES"]
    if (Dictionaries == "")	# Use default dictionary list
    {
	DictionaryFiles["/usr/dict/words"]++
	DictionaryFiles["/usr/local/share/dict/words.knuth"]++
    }
    else			# Use system dictionaries from command line
    {
	split(Dictionaries, files)
	for (key in files)
	    DictionaryFiles[files[key]]++
    }
}

function initialize()
{
   NonWordChars = "[^" \
	"'" \
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" \
	"abcdefghijklmnopqrstuvwxyz" \
	"\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217" \
	"\220\221\222\223\224\225\226\227\230\231\232\233\234\235\236\237" \
	"\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257" \
	"\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277" \
	"\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317" \
	"\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337" \
	"\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357" \
	"\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377" \
	"]"
    get_dictionaries()
    scan_options()
    load_dictionaries()
    load_suffixes()
    order_suffixes()
}

function load_dictionaries(        file, word)
{
    for (file in DictionaryFiles)
    {
	## print "DEBUG: Loading dictionary " file > "/dev/stderr"
	while ((getline word < file) > 0)
	    Dictionary[tolower(word)]++
	close(file)
    }
}

function load_suffixes(        file, k, line, n, parts)
{
    if (NSuffixFiles > 0)		# load suffix regexps from files
    {
	for (file in SuffixFiles)
	{
	    ## print "DEBUG: Loading suffix file " file > "/dev/stderr"
	    while ((getline line < file) > 0)
	    {
		sub(" *#.*$", "", line)		# strip comments
		sub("^[ \t]+", "", line)	# strip leading whitespace
		sub("[ \t]+$", "", line)	# strip trailing whitespace
		if (line == "")
		    continue
		n = split(line, parts)
		Suffixes[parts[1]]++
		Replacement[parts[1]] = parts[2]
		for (k = 3; k <= n; k++)
		    Replacement[parts[1]] = Replacement[parts[1]] " " parts[k]
	    }
	    close(file)
	}
    }
    else	      # load default table of English suffix regexps
    {
	split("'$ 's$ ed$ edly$ es$ ing$ ingly$ ly$ s$", parts)
	for (k in parts)
	{
	    Suffixes[parts[k]] = 1
	    Replacement[parts[k]] = ""
	}
    }
}

function order_suffixes(        i, j, key)
{
    # Order suffixes by decreasing length
    NOrderedSuffix = 0
    for (key in Suffixes)
	OrderedSuffix[++NOrderedSuffix] = key
    for (i = 1; i < NOrderedSuffix; i++)
	for (j = i + 1; j <= NOrderedSuffix; j++)
	    if (length(OrderedSuffix[i]) < length(OrderedSuffix[j]))
		swap(OrderedSuffix, i, j)
}

function report_exceptions(        key, sortpipe)
{
    ## print "DEBUG: report_exceptions(): NR = ", NR, " FILENAME =", FILENAME
    sortpipe = Verbose ? "sort -f -t: -u -k1,1 -k2n,2 -k3" : "sort -f -u -k1"
    for (key in Exception)
	print Exception[key] | sortpipe
    close(sortpipe)
}

function scan_options(        k)
{
    for (k = 1; k < ARGC; k++)
    {
	if (ARGV[k] == "-strip")
	{
	    ARGV[k] = ""
	    Strip = 1
	}
	else if (ARGV[k] == "-verbose")
	{
	    ARGV[k] = ""
	    Verbose = 1
	}
	else if (ARGV[k] ~ /^=/)	# suffix file
	{
	    NSuffixFiles++
	    SuffixFiles[substr(ARGV[k], 2)]++
	    ARGV[k] = ""
	}
	else if (ARGV[k] ~ /^[+]/)	# private dictionary
	{
	    DictionaryFiles[substr(ARGV[k], 2)]++
	    ARGV[k] = ""
	}
    }

    # Remove trailing empty arguments (for nawk)
    while ((ARGC > 0) && (ARGV[ARGC-1] == ""))
        ARGC--
}

function spell_check_line(        k, word)
{
    ## for (k = 1; k <= NF; k++) print "DEBUG: word[" k "] = \"" $k "\""
    gsub(NonWordChars, " ")		# eliminate nonword chars
    for (k = 1; k <= NF; k++)
    {
	word = $k
	sub("^'+", "", word)		# strip leading apostrophes
	sub("'+$", "", word)		# strip trailing apostrophes
	if (word != "")
	    spell_check_word(word)
    }
}

function spell_check_word(word,        key, lc_word, location, w, wordlist)
{
    lc_word = tolower(word)
    ## print "DEBUG: spell_check_word(" word ") -> tolower -> " lc_word
    if (lc_word in Dictionary)		# acceptable spelling
	return
    else				# possible exception
    {
	if (Strip)
	{
	    strip_suffixes(lc_word, wordlist)
	    ## for (w in wordlist) print "DEBUG: wordlist[" w "]"
	    for (w in wordlist)
		if (w in Dictionary)
		    break
	    if (w in Dictionary)
		return
	}
	## print "DEBUG: spell_check():", word
	location = Verbose ? (FILENAME ":" FNR ":") : ""
	if (lc_word in Exception)
	    Exception[lc_word] = Exception[lc_word] "\n" location word
	else
	    Exception[lc_word] = location word
    }
}

function strip_suffixes(word, wordlist,        ending, k, n, regexp)
{
    ## print "DEBUG: strip_suffixes(" word ")"
    split("", wordlist)
    for (k = 1; k <= NOrderedSuffix; k++)
    {
	regexp = OrderedSuffix[k]
	## print "DEBUG: strip_suffixes(): Checking \"" regexp "\""
	if (match(word, regexp))
	{
	    ## print "DEBUG: strip_suffixes(): MATCHED: RSTART =", RSTART, " RLENGTH =", RLENGTH
	    word = substr(word, 1, RSTART - 1)
	    if (Replacement[regexp] == "")
		wordlist[word] = 1
	    else
	    {
		split(Replacement[regexp], ending)
		for (n in ending)
		{
		    if (ending[n] == "\"\"")
			ending[n] = ""
		    wordlist[word ending[n]] = 1
		}
	    }
	    break
	}
    }
     ## for (n in wordlist) print "DEBUG: strip_suffixes() -> \"" n "\""
}

function swap(a, i, j,        temp)
{
    temp = a[i]
    a[i] = a[j]
    a[j] = temp
}
