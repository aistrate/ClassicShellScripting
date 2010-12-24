#! /bin/sh -
    
trap 'echo Ignoring HUP ...' 1
trap 'echo Terminating on USR1 ... ; exit 1' 16
    
while true 
do 
    sleep 2
    date >/dev/null
done
