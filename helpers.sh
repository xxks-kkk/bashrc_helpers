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
__add_path_head "${HOME}/cockroach-v1.1.7/src/github.com/cockroachdb/cockroach"
__add_path_head "$HOME/.cargo/bin"


if [ `which $SHELL` = "/bin/ksh" ]; then
    DIR="$( cd "$( dirname "_[2]" )" && pwd )"
elif [ `which $SHELL` = "/bin/bash" ] || [ `which $SHELL` = "/lusr/bin/bash" ]; then
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

################################################################################
# mark/jump support + completion
# un/mark name : bookmark a directory or remove one (unmark)
# jump name : jump to directory
# marks : show all bookmarks
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

complete -F _completemarks jump unmark
################################################################################

source $DIR/aliases/aliases.sh
source $DIR/prompt/prompt_two_lines_blue.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/history/history_settings.sh

# Copy dotfiles the $HOME
cp $DIR/dot_files/.gdbinit $HOME
cp $DIR/dot_files/.tmux.conf $HOME
# Setup to use alacritty terminal
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    cp $DIR/dot_files/alacritty_macos.yml $HOME/.alacritty.yml
else
    cp $DIR/dot_files/alacritty.yml $HOME/.alacritty.yml
fi


# Get all the bin scripts
# cd $DIR/bin
# git submodule update --init --recursive
# git checkout master


# Merge the bin scripts to the local
mkdir -p $HOME/bin
cp $DIR/bin/* $HOME/bin


cd
clear
