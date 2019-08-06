#!/bin/bash

# Copyright (c) 2016 Zeyuan Hu <ferrishu3886@gmail.com>
# Copyright (c) 2012 Adam Matan <adam@matan.name>
# See the file license.txt for copying permission.

# Inspired by http://stackoverflow.com/a/104056/51197

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000000
export HISTFILESIZE=1000000
HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s histappend                      # when the shell exists, append to history file instead of overwriting it

# Steal from http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [[ "$command_part" =~ "cd" ]]; then
      local pwd_part="$OLDPWD"
  else
      local pwd_part=$(pwd)
  fi
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" $pwd_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
  log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"
