#!/bin/bash

source /root/instantARCH/moduleutils.sh

if iroot nobootloader; then
    echo "skipping bootloader install"
    exit
fi

mkdir /efi
echo 'trying to mount '"$(iroot partefi)"
mount "$(iroot partefi)" /efi || exit 1

pacloop efibootmgr grub

if ! grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB; then
    umount /efi || exit 1
    mkfs.fat -F32 "$(iroot partefi)" || exit 1
    mount "$(iroot partefi)" /efi || exit 1
    grub-install --efi-directory=/efi || exit 1
fi
