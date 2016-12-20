#!/bin/sh 

#**************************
# Variables
#**************************

CONFIG_REPO_PATH=$HOME/Documents/bashrc_helpers

#**************************
# Helper functions
#**************************


#**************************
# Main logic
#**************************

echo "Download the environment configuration repo ..."

if [ ! -d $CONFIG_REPO_PATH ]; then
    cd $HOME/Documents
    git clone git@github.com:xxks-kkk/bashrc_helpers.git
fi

echo "Configure the shell ..."
echo "Add by Zeyuan's development envrionment setup tool" >> .bashrc
echo "source $CONFIG_REPO_PATH/helpers.sh" >> $HOME/.bashrc

echo "Add necessary utlitlity scripts under $HOME/bin"
cp $CONFIG_REPO_PATH/bin/* $HOME/bin


