#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null
dir=`pwd`
for line in `ls -la | awk '/ \.+/ { print $9 }'`; do
    if [ $line != '.' -a $line != '..' -a $line != '.git' ]; then
        ln -fs "${dir}/$line" "${HOME}/${line}"
    fi
done
if [ "$(which brew)" != "brew not found" ]; then
    brew update
    if [ -n "$(brew ls --versions go)" ]; then
        brew install go
    fi
    if [ -n "$(brew ls --versions rbenv)" ]; then
        # Remember to setup default ruby
        brew install rbenv ruby-build
    fi
    if [ -n "$(brew ls --versions boot2docker)" ]; then
        brew install boot2docker
    fi
popd &> /dev/null
