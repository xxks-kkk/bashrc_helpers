
#!/bin/sh

# Copyright (c) 2012 Adam Matan <adam@matan.name>
# Copyright (c) 2018 Zeyuan Hu <ferrishu3886@gmail.com>
# See the file license.txt for copying permission.

# Command overrides
alias tailf='tail -f '		     
alias sshconfig='vi $HOME/.ssh/config'                                                   ## see current ssh config
alias home="cd $HOME"                                                                    ## cd into home
alias bashrc="vi $HOME/.bashrc"                                                          ## quickly edit .bashrc
alias cleanup="find . -type f -name '#*#' -delete; \
               find . -type f -name '*~' -delete;  \
               find . -type f -name 'core' -delete"                                      ## recursively cleanup for a repo
alias phgrep='cat ~/.persistent_history|grep --color'                                    ## query .persistent_history file for a command
alias hgrep='history|grep --color'                                                       ## query history file for a command
alias ls='ls -G'                                                                         ## colorize ls output
alias ..="cd .."                                                                         ## same as `up 2` below
alias ...="cd ../.."                              
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias treed="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'" ## Expand current directory structure in tree form
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f" ## Tail all logs in /var/log
alias mkdir="mkdir -p"

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
alias gb="git branch"
git config --global core.editor vim

# LaTex related
alias latexmgrgui='sudo env PATH="$PATH" tlmgr --gui'                                    ## bring up latex manager gui
alias lsudo='sudo env PATH="$PATH"'                                                      ## use speciall sudo to use tlmgr
latex_compile() {                                                                        ## build latex pdf based on input filename
    local filename="$1"
    pdflatex "$filename".tex && bibtex "$filename".aux && pdflatex "$filename".tex && pdflatex "$filename".tex
}

# emacs related
set -o emacs                                                                             ## enable emacs operation in command
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient

# TODO: For Ubuntu, checking for emacs can be improved by following
# https://garywoodfine.com/use-pbcopy-on-ubuntu/
if [[ -f /opt/local/bin/emacs && "$platform" != 'mac' ]]; then
    alias em='/opt/local/bin/emacs -nw'
elif [ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
    alias em='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
elif [ -e /usr/local/bin/emacs ]; then
    alias em='/usr/local/bin/emacs -nw'
elif [ -f /usr/bin/emacs ]; then
    alias em='/usr/bin/emacs -nw'
elif [ -f /snap/bin/emacs ]; then
    alias em='/snap/bin/emacs -nw'
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
    # source /opt/rh/devtoolset-2/enable
    #/usr/bin/setxkbmap -option "ctrl:swapcaps"                                              ## switch ctrl with caps
    pass
elif [[ $platform == 'mac' ]]; then
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
    alias pbcopy='xclip -selection clipboard'                                                ## copy input file to clipboard; more details see https://garywoodfine.com/use-pbcopy-on-ubuntu/
    alias pbpaste='xclip -selection clipboard -o'                                            ## paste clipboard to input file    
elif [[ $platform == 'windows' ]]; then
    # This part assumes to work with git bash
    alias python='winpty python.exe'
fi

# Usage: copy-to-docker-volume SRC_PATH DEST_VOLUME_NAME [DEST_PATH]
copy-to-docker-volume() {
  SRC_PATH=$1
  DEST_VOLUME_NAME=$2
  DEST_PATH="${3:-}"
  # create smallest Docker image possible
  echo -e 'FROM scratch\nLABEL empty=""' | docker build -t empty -
  # create temporary container to be able to mount volume
  CONTAINER_ID=$(docker container create -v "${DEST_VOLUME_NAME}":/data empty cmd)
  # copy files to volume
  docker cp "${SRC_PATH}" "${CONTAINER_ID}":"/data/${DEST_PATH}"
  # remove temporary container
  docker rm "${CONTAINER_ID}"
}

clear
