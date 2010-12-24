#!/bin/sh

# aspell -l mimicks the standard unix spell program, roughly.

cat "$@" | aspell -l --mode=none | sort -u
