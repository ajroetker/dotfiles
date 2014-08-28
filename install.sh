#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null
dir=`pwd`
for line in `ls -la | awk '/ \.+/ { print $9 }'`; do
    if [ $line != '.' -a $line != '..' ]; then
        rm -rf "${HOME}/${line}"
        ln -s "${dir}/$line" "${HOME}/${line}"
    fi
done
popd &> /dev/null
