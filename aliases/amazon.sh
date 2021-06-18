#!/bin/bash

# Amazon Daily Setup Process (leave here as reminder)
# kinit && mwinit -o # cloud desktop

alias bz="brazil"
alias bb="brazil-build"
alias gca="git config --global user.name \"zeyuanhu\"; git config --global user.email \"zeyuanhu@amazon.com\"; git commit"
alias lt="cd /home/zeyuanhu/workplace/local_test/src/Local_tests"
alias bbr="brazil-build clean && brazil-build release"
alias bbs="brazil-build server"
alias bws="brazil workspace"
alias awslocal="START_WEB=0 USE_LIGHT_IMAGE=1 SERVICES='dynamodb,sqs,s3,kms' TMPDIR=/private$TMPDIR localstack start --docker"

__add_path_head "$HOME/.local/bin"
__add_path_head "$HOME/.local/python-3.6.10/bin"
__add_path_head "/home/zeyuanhu/apache-maven-3.6.3/bin"

if [[ $platform == 'rhel' ]]; then
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-bundle.crt
    export JAVA_HOME=/usr/lib/jvm/amazon-openjdk-8
elif [[ $platform == 'mac' ]]; then
    export REQUESTS_CA_BUNDLE="$HOME/.mac-ca-roots"
fi

alias goshawk='export GOSHAWK_TOKEN=$(aws goshawk get-authorization-token --domain-name amazon --output text --profile prestobuild)'
