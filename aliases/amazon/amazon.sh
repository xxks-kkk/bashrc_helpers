#!/bin/bash

# Amazon Daily Setup Process (leave here as reminder)
# kinit && mwinit -o # cloud desktop

alias bz="brazil"
alias bb="brazil-build"
alias gca="git config --global user.name \"zeyuanhu\"; git config --global user.email \"zeyuanhu@amazon.com\"; git commit"
alias lt="cd /home/zeyuanhu/workplace/local_test/src/Local_tests"
alias bbr="brazil-build clean && brazil-build release"
alias bbs="brazil-build server"
alias pipeline="cd ~/workplace/pipeline/src/"
alias afp="cd ~/workplace/afp/src"
alias bws="brazil workspace show" # Find the version set used by the current workspace

if [[ $platform == 'rhel' ]]; then
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-bundle.crt
elif [[ $platform == 'mac' ]]; then
    export REQUESTS_CA_BUNDLE="$HOME/.mac-ca-roots"
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
fi
alias goshawk='export GOSHAWK_TOKEN=$(aws goshawk get-authorization-token --domain-name amazon --output text --profile prestobuild)'
