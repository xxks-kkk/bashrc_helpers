#!/bin/bash -vx

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
__add_path_head "${HOME}/.cargo/bin"
__add_path_head "/usr/local/go/bin"
__add_path_head "${HOME}/go/bin"
__add_path_head "/Applications/CMake.app/Contents/bin"
__add_path_head "/usr/local/Cellar/llvm/9.0.0_1/bin"
__add_path_head "/usr/local/smlnj/bin"
__add_path_head "$HOME/.rbenv/bin"
__add_path_head "${HOME}/Downloads/apache-maven-3.6.3/bin"
__add_path_head "$HOME/.jenv/bin"
__add_path_head "/Applications/Racket v7.9/bin"
__add_path_head "/Users/zyh/Downloads/apache-ant-1.10.11/bin"
__add_path_head "/usr/lib/jvm"
__add_path_head "/Applications/Postgres.app/Contents/Versions/14/bin"

# LDBC Datagen (https://github.com/ldbc/ldbc_snb_datagen_spark)
export SPARK_HOME="/opt/spark-3.1.2-bin-hadoop3.2"
__add_path_head "$SPARK_HOME/bin"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
elif [ -f /etc/redhat-release ]; then
    platform='rhel'
elif [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" = *"MINGW64_NT"* ]]; then
    platform='windows'
fi

# This is critical for racer-emacs works on emacs
if [ ! -z `which rustc` ]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

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
# BUG: works best on linux, not Mac
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

# Source setup files contained in the repo
source $DIR/aliases/aliases.sh
source $DIR/prompt/prompt_two_lines_blue.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/history/history_settings.sh

# Setup additionaly utilities based on the current environment
# source $DIR/aliases/amazon.sh
# source $DIR/aliases/microsoft.sh

# Copy dotfiles the $HOME
cp $DIR/dot_files/.gdbinit $HOME
cp $DIR/dot_files/.tmux.conf $HOME
cp $DIR/dot_files/.ignore $HOME
cp $DIR/dot_files/.mutagen.yml $HOME
cp $DIR/dot_files/.vimrc $HOME
cp -r $DIR/dot_files/.vim $HOME/.vim
cp $DIR/dot_files/.gitconfig $HOME/.gitconfig
cp $DIR/dot_files/.git-commit-template $HOME/.git-commit-template
cp $DIR/dot_files/.git-completion.bash $HOME/.git-completion.bash

# Enables the git autocompletion script
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Setup to use alacritty terminal
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    cp $DIR/dot_files/alacritty_macos.yml $HOME/.alacritty.yml
else
    cp $DIR/dot_files/alacritty.yml $HOME/.alacritty.yml
fi

# Configure .git
## Purpose: https://stackoverflow.com/questions/6089294/why-do-i-need-to-do-set-upstream-all-the-time
git config --global push.default current

# Merge the bin scripts to the local
mkdir -p $HOME/bin
cp $DIR/bin/* $HOME/bin


# Let's get a list of files difference between $HOME/bin and bin under repo
# so that we can copy necessary files back to the repo
# This scenario works best if I maintain a bin/ that contains some confidential scripts
# and I write some public scripts that can be used in the future. It is laborious to
# check the difference between the work bin/ and bin/ under repo periodically
echo "Difference between $HOME/bin and $DIR/bin"
diff -d $HOME/bin  $DIR/bin/

# necessary to make emacs looks nice in terminal
export TERM=xterm-256color

# ruby setup
if which rbenv > /dev/null; then
   eval "$(rbenv init -)"
fi

# jenv setup
if [[ $platform == 'linux' ]]; then
    eval "$(jenv init -)"
else
if which jenv > /dev/null; then
    export JENV_ROOT=/usr/local/opt/jenv
    eval "$(jenv init -)"
    # ensure that JAVA_HOME is correct
    jenv enable-plugin export
    # make Maven aware of the Java version in use (and switch when your project does)
    jenv enable-plugin maven
    for version in 11 13
    do
        jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-$version.jdk/Contents/Home
    done
    jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home
    jenv add /Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
fi
fi

# https://github.com/rupa/z
. $HOME/bin/z.sh

cd
clear
