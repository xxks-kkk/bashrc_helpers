#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2018 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
#elif [ -f /etc/redhat-release ]; then
#    platform='rhel'
elif [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" = *"MINGW64_NT"* ]]; then
    platform='windows'
fi

# Command overrides
alias tailf='tail -f '		     
alias pbcopy='xsel --clipboard --input'                                                  ## copy input file to clipboard
alias pbpaste='xsel --clipboard --input'                                                 ## paste clipboard to input file
alias sshconfig='vi $HOME/.ssh/config'                                                   ## see current ssh config
alias home="cd $HOME"                                                                    ## cd into home
alias bashrc="vi $HOME/.bashrc"                                                          ## quickly edit .bashrc
alias cleanup="find . -type f -name '#*#' -delete; find . -type f -name '*~' -delete"    ## recursively cleanup for a repo
alias phgrep='cat ~/.persistent_history|grep --color'                                    ## query .persistent_history file for a command
alias hgrep='history|grep --color'                                                       ## query history file for a command
alias ls='ls -G'                                                                         ## colorize ls output
alias ..="cd .."                                                                         ## same as `up 2` below
alias ...="cd ../.."                              
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias treed="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'" ## Expand current directory structure in tree form
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f" ## Tail all logs in /var/log

# Utility functions
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }                                     ## Move 'up' so many directories instead of using several cd ../../, etc.
extract () {                                                                             ## Easy way to extract archives
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar xvf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
function weather() {                                                                     ## Get weather
    echo ""; w3m http://www.usairnet.com/weather/forecast/local/?pands=$1 | grep -A 10 "${2^^}"; echo ""; curl -s http://wttr.in/$2;
}

# git related
alias quickdel="git ls-files --deleted -z | xargs -0 git rm"                             ## rm the deleted files from git control
alias gs="git status"
alias gh="git push"
alias gl="git pull"
alias ga="git add"
alias gsync="git fetch upstream; git pull upstream master"                               ## sync the fork with the upstream (prereq: `git remote add upstream <url>`)
alias gc="git config --global user.name \"xxks-kkk\"; git config --global user.email \"ferrishu3886@gmail.com\"; git commit"

# LaTex related
alias latexmgrgui='sudo env PATH="$PATH" tlmgr --gui'                                    ## bring up latex manager gui
alias lsudo='sudo env PATH="$PATH"'                                                      ## use speciall sudo to use tlmgr

# emacs related
set -o emacs                                                                             ## enable emacs operation in command
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient

if [ -f /opt/local/bin/emacs ]; then
    alias em='/opt/local/bin/emacs -nw'                                                                     ## quickly fire up emacs
elif [ -f /usr/bin/emacs ]; then
    alias em='/usr/bin/emacs -nw'
fi
    
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
    /usr/bin/setxkbmap -option "ctrl:swapcaps"                                               ## switch ctrl with caps
elif [[ $platform == 'mac' ]]; then
    alias gdb='ggdb'                                                                         ## I install gdb through macports, and they name it as "ggdb" not "gdb"
    #unset PYTHONPATH;                                                                       ## This is for python3
    export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages                     ## Do this "export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages" before using python2. Now the system by default will use python2
    alias tensorboard2="python2 /usr/local/lib/python2.7/site-packages/tensorboard/main.py"  ## tensorboard is linked with my Python3. This alias is a shorthand to run python2 tensorboard on my system
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home
    alias conda="/Users/zeyuan/anaconda2/bin/conda"
    alias zyh="cd /Volumes/MacSSD/Users/zyh"                                                 ## The home directory for my mac ssd disk
    alias wine="/Applications/Wine Stable.app/Contents/Resources/wine/bin/wine"            
elif [[ $platform == 'linux' ]]; then    
    alias bld="cd /u/zeyuanhu/Documents/norman-439/src/threads/build"
    export GOPATH=$HOME/go
    alias go2="/lusr/opt/go-go1.10.1/bin/go"
    sbs() {                                                                                  ## List by file size in current directory
        du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';
    }
    alias port='netstat -tulanp'                                                             ## Show active ports
elif [[ $platform == 'windows' ]]; then
    # This part assumes to work with git bash
    alias python='winpty python.exe'
fi

clear
