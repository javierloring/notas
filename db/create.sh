#!/bin/sh

if [ "$1" = "travis" ]
then
    psql -U postgres -c "CREATE DATABASE notas_test;"
    psql -U postgres -c "CREATE USER notas PASSWORD 'notas' SUPERUSER;"
else
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists notas
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists notas_test
    [ "$1" != "test" ] && sudo -u postgres dropuser --if-exists notas
    sudo -u postgres psql -c "CREATE USER notas PASSWORD 'notas' SUPERUSER;"
    [ "$1" != "test" ] && sudo -u postgres createdb -O notas notas
    sudo -u postgres createdb -O notas notas_test
    LINE="localhost:5432:*:notas:notas"
    FILE=~/.pgpass
    if [ ! -f $FILE ]
    then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE
    then
        echo "$LINE" >> $FILE
    fi
fi
