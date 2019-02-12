# More here: https://gist.github.com/CocoaBeans/1879270

# turn off security checking
set auto-load safe-path /

# automatically loging the session into file "gdb.txt"
set logging on

# we want to see the full stack frame
set pagination off

# Debug HyperPebblesDB code on UTCS Machine
set environment LD_LIBRARY_PATH /u/zeyuanhu/bin/lib

# Command History related
# https://sourceware.org/gdb/onlinedocs/gdb/Command-History.html
set history filename ~/.gdb_history.txt
set history save on
set history size unlimited
set history expansion on

# Load all project-specific .gdbinit
# Ref: https://stackoverflow.com/questions/2045509/how-to-save-settings-in-gdb
add-auto-load-safe-path /
