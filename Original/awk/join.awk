{
    n = split($0,a,"[ ]")
    s = join(a,n," ")
    print "DEBUG: n =",n," s = \"" s "\""
    if ($0 != s) print "ERROR: \"" $0 "\" vs \"" s "\""
}

function join(a,n,fs,    k,s)
{
    # Recombine a[1]...a[n] into a string, with elements
    # separated by fs
    if (n >= 1)
    {
        s = a[1]
	for (k = 2; k <= n; ++k)
	    s = s fs a[k]
    }
    return (s)
}
