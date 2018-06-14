#!/bin/sh -vx

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2018 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.


# if a directory exists, add it to $PATH
__add_path_head() {
    if [ -d "$1" ]; then
        if [ -n "${PATH}" ]; then
            PATH="$1:${PATH}"
        else
            PATH="$1"
        fi
    fi
}
export PATH
__add_path_head "${HOME}/local/bin"
__add_path_head "${HOME}/local/sbin"
__add_path_head "${HOME}/bin"
__add_path_head "/opt/apache-maven-3.5.2/bin"
__add_path_head "/lusr/opt/pintos/"
__add_path_head "/lusr/opt/bochs-2.2.6-pintos/bin/"
__add_path_head "/usr/lib/go-1.10/bin"
__add_path_head "/home/zeyuanhu/cockroach-v1.1.7/src/github.com/cockroachdb/cockroach"


if [ `which $SHELL` = "/bin/ksh" ]; then
    DIR="$( cd "$( dirname "_[2]" )" && pwd )"
elif [ `which $SHELL` = "/bin/bash" ] || [ `which $SHELL` = "/lusr/bin/bash" ]; then
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
