#!/bin/bash

# Cleanup the typescript generated from `script` command (e.g. remove the
# control character)
# Ref: - https://superuser.com/questions/236930/how-to-clean-up-output-of-linux-script-command
#      - https://gist.github.com/jehiah/855086
# Sometimes, typescript contains unicode. We may want to use tool `konwert' to preprocess it.
# Ref: - https://unix.stackexchange.com/questions/171832/converting-a-utf-8-file-to-ascii-best-effort
# Usage: sc <script output filename>

FILE=${1:-typescript}
FILE_ASCII=$FILE-ascii

if [[ $(command -v konwert) ]]; then
    echo "konwert exist. Use it to convert typescript into ASCII encoding ..."
    konwert utf8-ascii $FILE > $FILE_ASCII
    FILE=$FILE_ASCII
fi
   
echo "processing $FILE ..."
cat $FILE | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b > $FILE-processed
echo "done"
