#! /bin/ksh -
trap 'echo This is an ERR trap.' ERR
echo Try command substitution: $(ls no-such-file)
echo Try a standalone command:
ls no-such-file
