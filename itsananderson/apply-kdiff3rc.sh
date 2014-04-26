#!/bin/bash

while read line; do
    cp $2 "$2.bak"
    IFS='=' read -ra line_parts <<< "$line"
    config_name=${line_parts[0]}
    config_val=${line_parts[1]}
    sed "s/${config_name}\=.*/${config_name}=${config_val}/g" "$2.bak" > $2
done < $1

rm $2.bak
