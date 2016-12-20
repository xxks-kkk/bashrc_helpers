#!/bin/bash

# Copyright (c) 2016 Zeyuan Hu <ferrishu3886@gmail.com>
# Copyright (c) 2012 Adam Matan <adam@matan.name>
# See the file license.txt for copying permission.

# Inspired by http://stackoverflow.com/a/104056/51197

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%F %T '
shopt -s histappend                      # when the shell exists, append to history file instead of overwriting it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

