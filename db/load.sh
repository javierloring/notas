#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]
then
    psql -h localhost -U notas -d notas < $BASE_DIR/notas.sql
fi
psql -h localhost -U notas -d notas_test < $BASE_DIR/notas.sql
