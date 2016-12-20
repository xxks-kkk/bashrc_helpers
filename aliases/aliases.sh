#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2016 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

# Command overrides
alias tailf='tail -f '		     
alias pbcopy='xsel --clipboard --input'                          ## copy input file to clipboard
alias pbpaste='xsel --clipboard --input'                         ## paste clipboard to input file
alias em='emacs -nw'                                             ## quickly fire up emacs
alias sshconfig='vi $HOME/.ssh/config'                           ## see current ssh config
alias home="cd $HOME"                                            ## cd into home
alias bashrc="vi /home/zeyuan/.bashrc"                           ## quickly edit .bashrc



# git related
alias quickdel="git ls-files --deleted -z | xargs -0 git rm"     ## rm the deleted files from git control

# LaTex related
alias latexmgrgui='sudo env PATH="$PATH" tlmgr --gui'            ## bring up latex manager gui
alias lsudo='sudo env PATH="$PATH"'                              ## use speciall sudo to use tlmgr


# Misc tweaks
/usr/bin/setxkbmap -option "ctrl:swapcaps"                       ## switch tabs with caps
export LSCOLORS=gxfxcxdxbxegedabagacad

