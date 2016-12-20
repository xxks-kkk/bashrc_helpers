#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2016 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

# Command overrides
alias tailf='tail -f '		     
alias pbcopy='xsel --clipboard --input'                                                  ## copy input file to clipboard
alias pbpaste='xsel --clipboard --input'                                                 ## paste clipboard to input file
alias sshconfig='vi $HOME/.ssh/config'                                                   ## see current ssh config
alias home="cd $HOME"                                                                    ## cd into home
alias bashrc="vi /home/zeyuan/.bashrc"                                                   ## quickly edit .bashrc
alias cleanup="find . -type f -name '#*#' -delete; find . -type f -name '*~' -delete"    ## recursively cleanup for a repo

# git related
alias quickdel="git ls-files --deleted -z | xargs -0 git rm"                             ## rm the deleted files from git control

# LaTex related
alias latexmgrgui='sudo env PATH="$PATH" tlmgr --gui'                                    ## bring up latex manager gui
alias lsudo='sudo env PATH="$PATH"'                                                      ## use speciall sudo to use tlmgr

# emacs related
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient
alias em='emacs -nw'                                                                     ## quickly fire up emacs

# Misc tweaks
/usr/bin/setxkbmap -option "ctrl:swapcaps"                                               ## switch tabs with caps
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
