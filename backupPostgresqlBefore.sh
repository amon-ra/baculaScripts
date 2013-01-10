#!/bin/bash

FIFO="/srv/db/pgsql/backup/postgresql.dump"

if [ -r $FIFO ]; then
        rm -f $FIFO
        if [ "$?" -ne "0" ]; then
                exit 1
        fi
fi

mkfifo $FIFO
if [ "$?" -ne "0" ]; then
  exit 1
fi

screen -d -m -S pgdump -t pgdump su -s /bin/bash -c "pg_dumpall -o -U postgres > ${FIFO}"
