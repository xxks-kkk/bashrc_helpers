#!/bin/sh

# Cleanup the typescript generated from `script` command (e.g. remove the
# control character)
# Ref: - https://superuser.com/questions/236930/how-to-clean-up-output-of-linux-script-command
#      - https://gist.github.com/jehiah/855086


FILE=typescript

usage()
{
    echo "Cleanup the typescript generated from 'script' command."
    echo ""
    echo "./sc [-h | --help] [-f | --file]"
    echo ""
    echo "Default filename is typescript"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk '{print $1}'`
    VALUE=`echo $1 | awk '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --f | --file)
            FILE=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

#echo "FILE is $FILE";

cat $FILE | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b > $FILE-processed

