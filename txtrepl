#!/bin/bash.sh

file=''
while [ "$file" = "" ]; do
        echo -n "Input absolute path to file: "
        read file
done

quest=''
echo -n "Print all text? (Yes\No\ or empty): "
read quest

if [[ "$quest" = "Yes" ]]; then
        cat -n $file
fi
if [[ "$quest" = "No" ]]; then
        search=''
        echo -n "Enter what you are looking for replace: "
        read search
        cat $file | grep -n $search
fi

stnum=''
while [ "$stnum" = "" ]; do
        echo -n "Input string number for replace: "
        read stnum
done

repl=''
while [ "$repl" = "" ]; do
        echo -n "Input text for replace: "
        read repl
done

sed "$stnum c $repl" $file > /tmp/replfilerep.txt
mv /tmp/replfilerep.txt $file

exit 0
