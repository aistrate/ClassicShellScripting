#! /bin/awk -f

#  $1   $2    $3  $4   $5         $6     $7
# user:passwd:uid:gid:long name:homedir:shell

BEGIN { FS = ":" }

# name[]    --- indexed by user name
# uid[]     --- indexed by uid

# if a duplicate appears, decide the disposition

{
    if ($1 in name) {
        if ($3 in uid)
            ;   # name and uid identical, do nothing
        else {
            print name[$1] &gt; "dupusers"
            print $0 &gt; "dupusers"
            delete name[$1]

            # remove saved entry with same name but different uid
            remove_uid_by_name($1)
        }
    } else if ($3 in uid) {
        # we know $1 is not in name, so save duplicate ID records
        print uid[$3] &gt; "dupids"
        print $0 &gt; "dupids"
        delete uid[$3]

        # remove saved entry with same uid but different name
        remove_name_by_uid($3)
    } else
        name[$1] = uid[$3] = $0     # first time this record was seen
}

END {
    for (i in name)
        print name[i] &gt; "unique1"

    close("unique1")
    close("dupusers")
    close("dupids")
}

function remove_uid_by_name(n,     i, f)
{
    for (i in uid) {
        split(uid[i], f, ":")
        if (f[1] == n) {
            delete uid[i]
            break
        }
    }
}

function remove_name_by_uid(id,    i, f)
{
    for (i in name) {
        split(name[i], f, ":")
        if (f[3] == id) {
            delete name[i]
            break
        }
    }
}
