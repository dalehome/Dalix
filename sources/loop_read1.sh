#!/usr/bin/bash
filename="$1"
while read -r line || [[ -n "$line" ]]
do
    name="$line"
    echo "Name read from file - $name"
done < "$filename"