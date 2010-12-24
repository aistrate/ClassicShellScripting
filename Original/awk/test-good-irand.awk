# Test good irand() for generating pseudorandom integers
# Usage:
#	awk [-v LOW=nnn] [-v HIGH=nnn] [-v MAXTEST=nnn] [-v SEED=nnn] -f test-good-irand.awk

BEGIN {
    MAXDEF = 1024 * 1024

    MAXTEST = (MAXTEST == "") ? MAXDEF : int(MAXTEST)
    MAXTEST = (MAXTEST > 0) ? MAXTEST : MAXDEF

    LOW = (LOW == "") ? 0 : int(LOW)

    HIGH = (HIGH == "") ? 10 : int(HIGH)
    HIGH = (HIGH <= LOW) ? (LOW + 1) : HIGH

    # Initialize the generator
    if (SEED == "")
	srand()
    else
	srand(SEED)

    # Sample the generator
    for (k = 1; k <= MAXTEST; ++k)
	count[irand(LOW, HIGH)]++
    chisq = 0

    # Count results
    n = 0
    for (k in count)
	n++

    degrees_of_freedom = HIGH - LOW
    if (n != (1 + degrees_of_freedom))
    {
	print "\nERROR: degrees of freedom does not match expected number\n"
	n = 1 + degrees_of_freedom
    }

    print "Count[] values"
    for (k = LOW; k <= HIGH; ++k)
    {
	if (k in count)
    	    printf("\t[%d] = %d\n", k, count[k])
    }
    print ""

    # Compute chi-square measure
    chisq = 0
    e = MAXTEST / n
    for (k in count)
        chisq += (e - count[k])^2 / e

    # Report results
    printf("Test irand(%d,%d) with %d samples\n", LOW, HIGH, MAXTEST)
    printf("n = %d\n", n)
    printf("degrees of freedom = %d\n", HIGH - LOW)
    printf("chi-square measure = %.5f\n", chisq)
}

function irand(low, high,     n)
{
    # Return a pseudorandom integer n such that low <= n <= high

    # Ensure integer endpoints
    low = int(low)
    high = int(high)

    # Sanity check on argument order
    if (low >= high)
	return (low)

    # Find a value in the required range
    do
        n = low + int(rand() * (high + 1 - low))
    while ((n < low) || (high < n))

    return (n)
}
