#!/usr/bin/env bash

# Convert all .msg files and save them as .eml

for file in *.msg
do
    newfile="${file%%.msg}.eml"
    printf "Converting ${file} to ${newfile}"
    msgconvert --outfile "${newfile}" "${file}"
done
