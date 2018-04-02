#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2018 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

# verified on RHEL 6.6

if [ `which $SHELL` = "/bin/ksh" ]; then
    DIR="$( cd "$( dirname "_[2]" )" && pwd )"
elif [ `which $SHELL` = "/bin/bash" ]; then
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

source $DIR/aliases/aliases.sh
source $DIR/prompt/prompt_two_lines_blue.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/history/history_settings.sh

cp $DIR/.gdbinit $HOME
cp $DIR/.tmux.conf $HOME

# Get all the bin scripts
# cd $DIR/bin
# git submodule update --init --recursive
# git checkout master

# Merge the bin scripts to the local
mkdir -p $HOME/bin
cp $DIR/bin/* $HOME/bin

cd
clear
