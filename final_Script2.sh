#!/bin/bash
LockFile="/var/tmp/flim.lock"
pidof -o %PPID -x $0 >/dev/null && echo "Script $0 already running" && exit 1
X=3
Y=200000

while true
do
    NumberOfFiles=$(ls -la /local/backups | grep Articles | wc -l)
    TotalDirSize=$(du -hbs /local/backups | cut -f1)
    echo $NumberOfFiles -- $TotalDirSize

    if [ $NumberOfFiles -ge $X ] || [ $TotalDirSize -ge $Y ]
    then
        if ! test -f $LockFile
        then
            echo Create
            logger -t __ADMIN__ "Number of files in /local/backups is greater then $X and total directory size is greater then $Y"
            echo "Number of files in /local/backups is greater then $X ($NumberOfFiles total) and total directory size is greater then $Y ($TotalDirSize bytes total size)" | mail -s "Files report" root
            touch /var/tmp/flim.lock
        fi
    else
        if test -f $LockFile
        then
            echo Remove
            rm $LockFile
        fi
    fi
    sleep 15
done
