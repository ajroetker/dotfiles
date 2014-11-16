#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null
dir=`pwd`
for line in `ls -la | awk '/ \.+/ { print $9 }'`; do
    if [ $line != '.' -a $line != '..' ]; then
        ln -fs "${dir}/$line" "${HOME}/${line}"
    fi
done
popd &> /dev/null
