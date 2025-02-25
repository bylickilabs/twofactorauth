#!/bin/bash

status=0

# $1 = directory
# $2, $3, ... = permitted file extensions
function checkExt()
{
    dir="$1"
    shift
    regex="\\.\($(echo $* | sed 's/ /\\|/g')\)$"
    if find "$dir" -type f | grep -q -v "$regex"; then
	echo "Directory '$dir' may only have files with the following extensions: $*"
	status=1
    fi
}

[ -e api ] && checkExt api json sig

checkExt entries json
for dir in img/?; do
    checkExt $dir svg png
done
checkExt tests rb sh json

exit $status
