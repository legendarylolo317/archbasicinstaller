#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime
hwclock --systohc
sleep 2s
echo "generating locale"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
sleep 2s
echo "setting LANG variable"
echo "LANG=en_US.UTF-8" > /etc/locale.conf
sleep 2s
