#!/bin/bash

# Amazon Daily Setup Process (leave here as reminder)
# kinit && mwinit -o # cloud desktop

alias bz="brazil"
alias bb="brazil-build"
alias gca="git config --global user.name \"zeyuanhu\"; git config --global user.email \"zeyuanhu@amazon.com\"; git commit"
alias lt="cd /home/zeyuanhu/workplace/local_test/src/Local_tests"
alias bbr="brazil-build clean && brazil-build release"
alias bbs="brazil-build server"

# Setup package environment to perform local test (need to build each package afterwards)
__setup_domain_development() {
    cur_path=`pwd`
    cd ~/workplace/afp/src/AWSForecastingPlatformWorkflows/ && git apply ~/bashrc_helpers/aliases/amazon/AWSForecastingPlatformWorkflows.patch 2> /dev/null;
    cd ~/workplace/afp/src/AWSForecastingPlatformService/ && git apply ~/bashrc_helpers/aliases/amazon/AWSForecastingPlatformService.patch 2> /dev/null;
    cd ~/workplace/pipeline/src/AWSForecastingPipeline/ && git apply ~/bashrc_helpers/aliases/amazon/AWSForecastingPipeline.patch 2> /dev/null;
    cd $cur_path
}
alias eva="__setup_domain_development"
__cleanup_domain_development() {
    cur_path=`pwd`
    cd ~/workplace/afp/src/AWSForecastingPlatformWorkflows/ && git checkout configuration/brazil-config/app/AWSForecastingPlatformWorkflows.cfg
    cd ~/workplace/afp/src/AWSForecastingPlatformService/ && git checkout configuration/brazil-config/app/AWSForecastingPlatformService.cfg
    cd ~/workplace/pipeline/src/AWSForecastingPipeline && git checkout configuration/brazil-config/app/AWSForecastingPipeline.cfg
    cd $cur_path
}
alias evc="__cleanup_domain_development"

# AFPCLI related variables
#export PATH="$PATH:/apollo/env/AWSForecastingPlatformServiceCLI/bin"
__add_path_head "$HOME/.local/bin"
__add_path_head "$HOME/.local/python-3.6.10/bin"
__add_path_head "/home/zeyuanhu/apache-maven-3.6.3/bin"

#export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.404791104858.user/AFP-User
#export AFP_ODIN_CREDENTIALS=com.amazon.awsforecasting.platform.integ.test

#export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.408294933413.user/AFP-User
#export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.212614237368.user/AFP-User
#export AFP_ODIN_CREDENTIALS=com.amazon.awsforecasting.platform.development.service.zeyuanhu
export AFP_ODIN_CREDENTIALS=com.amazon.awsforecasting.platform.development.service.yunyao
export AFP_REGION=us-east-1
export AFP_DOMAIN=Development
export YOUR_RUN_AS_USER=yunyao
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
export JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.41.x86_64
export JAVA_HOME=/usr/lib/jvm/amazon-openjdk-8
#export AFP_ODIN_CREDENTIALS=com.amazon.credentials.isengard.263096128377.user/AFP-User

if [[ $platform == 'rhel' ]]; then
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-bundle.crt
elif [[ $platform == 'mac' ]]; then
    export REQUESTS_CA_BUNDLE="$HOME/.mac-ca-roots"
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
fi

alias goshawk='export GOSHAWK_TOKEN=$(aws goshawk get-authorization-token --domain-name amazon --output text --profile prestobuild)'
