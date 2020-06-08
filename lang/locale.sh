#!/bin/bash

# read out user selected locale
# build it and set it using localectl

cat /root/instantARCH/data/lang/locale/"$(iroot locale)" >>/etc/locale.gen

echo "" >>/etc/locale.gen
sleep 1
locale-gen

if ! [ -e /usr/bin/liveutils ]; then
    SETLOCALE="$(cat /root/instantARCH/data/lang/locale/$(iroot locale) |
        grep '.' | tail -1 | grep -o '^[^ ]*')"
    echo "setting localectl locale to $SETLOCALE"
    localectl set-locale LANG="$SETLOCALE"
fi
