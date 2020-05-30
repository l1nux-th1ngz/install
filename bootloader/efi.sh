#!/bin/bash

# installs grub on uefi systems
# runs from inside the installation
# unlike the legacy bios grub script

DISK=$(cat /root/instantARCH/config/disk)
mkdir /efi
DISK1=$(fdisk -l | grep "^${DISK}" | grep -o '^[^ ]*' | head -1)

mount "${DISK1}" /efi

sudo pacman -S efibootmgr grub --noconfirm

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
