#!/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null
if ! [ -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi
mkdir -p .vim/backups
dir=`pwd`
for line in `ls -la | awk '/ \.+/ { print $9 }'`; do
    if [ $line != '.' -a $line != '..' -a $line != '.git' ]; then
        ln -fs "${dir}/$line" "${HOME}/${line}"
    fi
done
if [ "$(which brew)" != "brew not found" ]; then
    if [ -z "$(brew ls --versions go)" ]; then
        brew install go
    fi
    if [ -z "$(brew ls --versions z)" ]; then
        brew install z
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
