#!/usr/bin/env bash

$i=0
for file in $(ls -1 *.msg)
do
    newfile="$((i++)).eml"
    printf "Converting ${file} to ${newfile}"
    msgconvert --outfile "${newfile}" "${file}"
done
