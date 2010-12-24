#! /bin/sh -
    
trap 'echo Ignoring HUP ...' HUP
trap 'echo Terminating on USR1 ... ; exit 1' USR1
trap 'echo Child terminated ...' CHLD
    
while true 
do 
    sleep 2
    date >/dev/null
done
