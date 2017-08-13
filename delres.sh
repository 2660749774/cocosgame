#!/usr/bin
path=$1

cd ${path}
if [ -f "res.lua" ]; then
    i=0
    cat res.lua | awk -F'=' '{print $1}' | sed 's/\[\"//g' | sed 's/\"\]//g' | while read line 
    do 
        $i=$i+1
        echo "i"${i}
        if [ $i == "1" ]; then
            continue
        fi
        echo "delete file "${line}
        rm -f ${line}
    done
fi
rm -f "*.lua"