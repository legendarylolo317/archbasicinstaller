#!/bin/bash

echo -e "Would you like to start arch install?(y/n) : " 
read -n1 up

if [ "$up" = "y" ]; then
   timedatectl set-ntp true
   echo -e "What kind of drive are you setting up? (1)= hard drive or ssd (2)=nvmessd (3)=virtualmachinedefaults :"
   read -n1 drivetype
   if [ $drivetype -eq 1 ]; then
	   fdisk /dev/sda <<EOF
	   g
      n
      1

      +550M
      n
      2

      +32G
      n
      3


      t
      1
      1
      t
      2
      19
      w
      EOF
      mkfs.fat -F32 /dev/sda1
      mkswap /dev/sda2
      swapon /dev/sda2
      mkfs.ext4 /dev/sda3
      mount /dev/sda3 /mnt
      pacstrap /mnt base linux linux-firmware
      genfstab -U /mnt >> /mnt/etc/fstab
      sleep 2s
      clear
      sed '1,/^#part2$/d' legacy-base-install.sh > /mnt/post_base-install.sh
      chmod +x /mnt/post_base-install.sh
      arch-chroot /mnt ./post_base-install.sh
      clear
      echo "unmounting all the drives"
      umount -R /mnt
      sleep 2s
      clear

   elif [ $drivetype -eq 2 ]
   then
	   fdisk /dev/nvme0n1 <<EOF
	   g
      n
      1

      +550M
      n
      2

      +3G
      n
      3


      t
      1
      1
      t
      2
      19
      w
      EOF
	   mkfs.fat -F32 /dev/nvme0n1p1
      mkswap /dev/nvme0n1p2
      swapon /dev/nvme0n1p2
      mkfs.ext4 /dev/nvme0n1p3
      mount /dev/nvme0n1p3 /mnt
      pacstrap /mnt base linux linux-firmware
      genfstab -U /mnt >> /mnt/etc/fstab
      sleep 2s
      clear
      sed '1,/^#part2$/d' legacy-base-install.sh > /mnt/post_base-install.sh
      chmod +x /mnt/post_base-install.sh
      arch-chroot /mnt ./post_base-install.sh
      clear
      echo "unmounting all the drives"
      umount -R /mnt
      sleep 2s
      clear
      sleep 10s
      reboot
      
	   
	   



else
   echo -e "\nfortnite"
   pkill -f archinstall.sh
fi


