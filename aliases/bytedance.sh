#!/bin/bash

# Bytedance Daily Setup Process (leave here as reminder)
# kinit zeyuan.hu

alias gcb="git config --global user.name \"zeyuan.hu\"; git config --global user.email \"zeyuan.hu@bytedance.com\"; git commit"
export CC=/opt/gcc-9.4.0/bin/gcc
export CXX=/opt/gcc-9.4.0/bin/g++
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/gcc-9.4.0/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/gcc-9.4.0/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export PATH=/opt/gcc-9.4.0/bin:$PATH

export MYSQL_BASE=$HOME/projects/mysql8.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYSQL_BASE/source_downloads/metrics/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYSQL_BASE/source_downloads/logstore/libs
export PATH=$MYSQL_BASE/dist/base/bin:$PATH
export OPS_TOOL_BASE=$HOME/projects/OpsTool/
source $OPS_TOOL_BASE/module/ndb/initndb.sh
