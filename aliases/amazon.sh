#!/bin/bash

# Amazon Daily Setup Process (leave here as reminder)
#if [ -e $HOM/bin/mwdaily.py ];then
#    python3 $HOME/bin/mwdaily.py
#else
#    mwinit -o
#fi

alias bz="brazil"
alias bb="brazil-build"
alias gca="git config --global user.name \"zeyuanhu\"; git config --global user.email \"zeyuanhu@amazon.com\"; git commit"
alias lt="cd /home/zeyuanhu/workplace/local_test/src/Local_tests"
alias bbr="brazil-build clean && brazil-build release"
alias bbs="brazil-build server"
alias int="cd ~/workplace/afp/src/AWSForecastingPlatformServiceModel/ && brazil-build clean && brazil-build release \
&& cd ~/workplace/afp/src/AWSForecastingPlatformCommonJavaModel && brazil-build clean && brazil-build release \
&& cd ~/workplace/afp/src/AWSForecastingPlatformCommon/ && brazil-build clean && brazil-build release" # this command builds necessary packages to make intellij work properly

# AFPCLI related variables
export PATH="$PATH:/apollo/env/AWSForecastingPlatformServiceCLI/bin"
export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.404791104858.user/AFP-User
export AFP_REGION=us-east-1
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
#export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.263096128377.user/AFP-User

