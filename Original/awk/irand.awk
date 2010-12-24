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
