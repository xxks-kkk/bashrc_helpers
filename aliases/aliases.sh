#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2016 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
elif [ -f /etc/redhat-release ]; then
    platform='rhel'
fi

# Command overrides
alias tailf='tail -f '		     
alias pbcopy='xsel --clipboard --input'                                                  ## copy input file to clipboard
alias pbpaste='xsel --clipboard --input'                                                 ## paste clipboard to input file
alias sshconfig='vi $HOME/.ssh/config'                                                   ## see current ssh config
alias home="cd $HOME"                                                                    ## cd into home
alias bashrc="vi /home/zeyuan/.bashrc"                                                   ## quickly edit .bashrc
alias cleanup="find . -type f -name '#*#' -delete; find . -type f -name '*~' -delete"    ## recursively cleanup for a repo
alias phgrep='cat ~/.persistent_history|grep --color'                                    ## query .persistent_history file for a command
alias hgrep='history|grep --color'                                                       ## query history file for a command

# git related
alias quickdel="git ls-files --deleted -z | xargs -0 git rm"                             ## rm the deleted files from git control
alias gs="git status"
alias gh="git push"
alias gl="git pull"

# LaTex related
alias latexmgrgui='sudo env PATH="$PATH" tlmgr --gui'                                    ## bring up latex manager gui
alias lsudo='sudo env PATH="$PATH"'                                                      ## use speciall sudo to use tlmgr

# emacs related
set -o emacs                                                                             ## enable emacs operation in command
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient
alias em='emacs -nw'                                                                     ## quickly fire up emacs

# Misc tweaks
alias left='xrandr --output VGA-0 --rotate left'                                         ## rotate screen left
alias normal='xrandr --output VGA-0 --rotate normal'                                     ## rotate screen normal

# Enable color support of ls and also add handy aliases
export LSCOLORS=gxfxcxdxbxegedabagacad
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   export LS_COLORS=$LS_COLORS:"*.sh=01;37;41"
   alias ls='ls --color=auto'
   #alias dir='dir --color=auto'
   #alias vdir='vdir --color=auto'

   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
fi

if [[ $platform == 'rhel' ]]; then
    # Enable Red Hat Developer Toolset
    source /opt/rh/devtoolset-2/enable
    /usr/bin/setxkbmap -option "ctrl:swapcaps"                                               ## switch tabs with caps
elif [[ $platform == 'mac' ]]; then
    alias gdb='ggdb'                                                                         ## I install gdb through macports, and they name it as "ggdb" not "gdb"
    #unset PYTHONPATH;                                                                       ## This is for python3
    export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages                     ## Do this "export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages" before using python2. Now the system by default will use python2
    alias tensorboard2="python2 /usr/local/lib/python2.7/site-packages/tensorboard/main.py"  ## tensorboard is linked with my Python3. This alias is a shorthand to run python2 tensorboard on my system
    export PATH=$PATH:$HOME/bin:/opt/apache-maven-3.5.2/bin
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home
    alias conda="/Users/zeyuan/anaconda2/bin/conda"
fi
