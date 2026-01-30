#!/bin/sh

watch() {
    WORKING_PATH=$(pwd)
    DIR=$1
    FILTER=$2
    COMMAND=$3
    chsum1=""

    while [[ true ]]
    do
        chsum2=$(find -L $WORKING_PATH/$DIR -type f -name "$FILTER" -exec md5sum  {} \;)
        if [[ $chsum1 != $chsum2 ]] ; then
            clear
            echo -e "Found a file change, executing $COMMAND...\n"
            $COMMAND
            chsum1=$chsum2
        fi
        sleep 2
    done
}

watch "$@"