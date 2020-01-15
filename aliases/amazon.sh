#!/bin/bash

# Amazon Daily Setup Process (leave here as reminder)
#if [ -e $HOM/bin/mwdaily.py ];then
#    python3 $HOME/bin/mwdaily.py
#else
#    mwinit -o
#fi

alias bb="brazil-build"
alias gc="git config --global user.name \"zeyuanhu\"; git config --global user.email \"zeyuanhu@amazon.com\"; git commit"
alias lt="cd /home/zeyuanhu/workplace/local_test/src/Local_tests"
alias bbr=" brazil-build clean && brazil-build release"

# AFPCLI related variables
export PATH="$PATH:/apollo/env/AWSForecastingPlatformServiceCLI/bin"
export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.404791104858.user/AFP-User
export AFP_REGION=us-east-1
