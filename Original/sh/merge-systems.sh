#! /bin/sh

sort u1.passwd u2.passwd &gt; merge1

awk -f splitout.awk merge1

awk -F: '{ print $3 }' merge1 | sort -n -u &gt; unique-ids

rm -f old-new-list

old_ifs=$IFS
IFS=:
while read user passwd uid gid fullname homedir shell
do
    if read user2 passwd2 uid2 gid2 fullname2 homedir2 shell2
    then
        if [ $user = $user2 ]
        then
            printf "%s&bsol;t%s&bsol;t%s&bsol;n" $user $uid $uid2 &gt;&gt; old-new-list
            echo "$user:$passwd:$uid2:$gid:$fullname:$homedir:$shell"
        else
            echo $0: out of sync: $user and $user2 &gt;&amp;2
            exit 1
        fi
    else
        echo $0: no duplicate for $user &gt;&amp;2
        exit 1
    fi
done &lt; dupusers &gt; unique2
IFS=$old_ifs

count=$(wc -l &lt; dupids)      # Total duplicate ids

# This is a hack, it'd be better if POSIX sh had arrays:
set -- $(newuids.sh -c $count unique-ids)

IFS=:
while read user passwd uid gid fullname homedir shell
do
    newuid=$1
    shift

    echo "$user:$passwd:$newuid:$gid:$fullname:$homedir:$shell"

    printf "%s&bsol;t%s&bsol;t%s&bsol;n" $user $uid $newuid &gt;&gt; old-new-list
done &lt; dupids &gt; unique3
IFS=$old_ifs

sort -k 3 -t : -n unique[123] &gt; final.password

while read user old new
do
    echo "find / -user $user -print | xargs chown $new"
done &lt; old-new-list &gt; chown-files

chmod +x chown-files

rm merge1 unique[123] dupusers dupids unique-ids old-new-list
