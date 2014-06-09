#!/bin/sh

kdiffpath=`type -P kdiff3`

if [ -z "$kdiffpath" ] ; then
    echo >&2 "ERROR: Can't find KDiff3"
    exit
fi

"$kdiffpath" "$2" "$5" | cat
