{ 
    print "\nField separator = FS = \"" FS "\""
    n = split($0, parts)
    for (k = 1; k <= n; ++k) 
        print "parts[" k "] = \"" parts[k] "\""

    print "\nField separator = \"[ ]\""
    n = split($0, parts, "[ ]")
    for (k = 1; k <= n; ++k)
        print "parts[" k "] = \"" parts[k] "\""

    print "\nField separator =", ":"
    n = split($0, parts, ":")
    for (k = 1; k <= n; ++k)
        print "parts[" k "] = \"" parts[k] "\""

    print ""
}    
