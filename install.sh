#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null
dir=`pwd`
for line in `ls -la | awk '/ \.+/ { print $9 }'`; do
    if [ $line == '.vim' ]; then
        rm -rf $HOME/.vim
        cp -r $dir/.vim $HOME/.vim
        mkdir -p $HOME/.vim/bundle
        pushd "${HOME}/.vim/bundle" &> /dev/null
            git clone https://github.com/gmarik/Vundle.vim.git
        popd &> /dev/null
        vim +PluginInstall +qall
    elif [ $line != '.' -a $line != '..' -a $line != '.git' ]; then
        ln -fs "${dir}/$line" "${HOME}/${line}"
    fi
done
if [ "$(which brew)" != "brew not found" ]; then
    if [ -z "$(brew ls --versions go)" ]; then
        brew install go
    fi
    if [ -z "$(brew ls --versions rbenv)" ]; then
        # Remember to setup default ruby
        brew install rbenv ruby-build
    fi
    if [ -z "$(brew ls --versions boot2docker)" ]; then
        brew install boot2docker
    fi
fi
popd &> /dev/null
