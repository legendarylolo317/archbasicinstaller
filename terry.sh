#!/bin/bash
umount -R /mnt
echo -e "The system is now going to reboot after this is done you can delete this file and the archinstall.sh file from your directory."
sleep 10s
rm /terry.sh
rm /archinstall.sh
rm /yes.sh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
shutdown now