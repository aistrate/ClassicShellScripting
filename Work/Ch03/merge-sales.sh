#! /bin/sh

# Combine quota and sales data

# Remove comments and sort datafiles
sed '/^#/d' quotas | sort > quotas.sorted
sed '/^#/d' sales  | sort > sales.sorted

# Combine on first key, results to standard output
join quotas.sorted sales.sorted

# Remove temporary files
rm quotas.sorted sales.sorted
