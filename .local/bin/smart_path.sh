#! /bin/bash
path="$1"
len=61
part=$((len / 2))
sep="…"
res="$(echo $path | rg $HOME -r \~)"
if [ ${#res} -gt $len ]; then
    beg=$(echo "$res" | rg -o "^.{$part}")
    end=$(echo "$res" | rg -o ".{$part}$")
    res=$beg$sep$end
fi

echo "$res"

