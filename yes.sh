#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime
hwclock --systohc
sleep 2s
pacman -S --noconfirm nano
echo "generating locale"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
sleep 2s
echo "Put in a host name please"
read hostname
echo $hostname > /etc/hostname
sleeps 5s
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain     $hostname" >> /etc/hosts
clear
sleep 5s

pacman -Sy --noconfirm vim grub neofetch networkmanager sudo efibootmgr dosfstools mtools git base-devel 
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
clear 
sleep 5s
echo "what would you like your root password to be?"
passwd
clear 
sleep 5s
echo "what would you like your normal user name to be?"
read username
useradd -ms /bin/bash $username
usermod -s /bin/bash -aG wheel,audio,video,optical,storage $username
echo "enter a password for your new username"
passwd $username
clear
sleep 4s
clear 
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
sleep 2s
pacman -Syyyu 
git clone https://aur.archlinux.org/yay-git.git
sleep 5s
cd yay-git/ 
makepkg -si 
sleeps 4s
cd 
pacman -S --noconfirm xorg-server xorg-apps xorg-xinit i3-gaps i3blocks i3lock numlockx lightdm lightdm-gtk-greeter vlc --needed
systemctl enable lightdm
pacman -S --noconfirm noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-roboto terminus-font rxvt-unicode ranger rofi dmenu firefox 
pacman -S zsh wget
sudo pacman -S lxappearance
pacman -S arc-gtk-theme papirus-icon-theme
echo "[greeter]" >> /etc/lightdm/lightdm-gtk-greeter.conf
echo "theme-name = Arc-Darker" >> /etc/lightdm/lightdm-gtk-greeter.conf
echo "icon-theme-name = Papirus-Dark" >> /etc/lightdm/lightdm-gtk-greeter.conf
echo "background = #2f343f" >> /etc/lightdm/lightdm-gtk-greeter.conf
pacman -S picom nitrogen dunst lxqt-policykit i3status
echo "exec --no-startup-id dunst" >> /etc/i3/config
echo "exec --no-startup-id picom -b" >> /etc/i3/config
echo "exec --no-startup-id nitrogen --restore" >> /etc/i3/config
echo "exec --no-startup-id /usr/bin/lxqt-policykit-agent &" >> /etc/i3/config
echo -e "What kind of drive are you setting up? (1)= hard drive or ssd (2)=nvmessd (3)=virtualmachinedefaults :"
   read -n1 drivetype1
   if [ $drivetype1 -eq 1 ]; then
	   mkdir /boot/EFI
      mount /dev/sda1 /boot/EFI
      grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
      grub-mkconfig -o /boot/grub/grub.cfg
      systemctl enable NetworkManager
      echo -e "when done run terry.sh to finalize"
      rm /yes.sh
      sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
      exit
   elif [ $drivetype1 -eq 2 ]
   then
      mkdir /boot/EFI
      mount /dev/nvme0n1p1 /boot/EFI
      grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
      grub-mkconfig -o /boot/grub/grub.cfg
      systemctl enable NetworkManager
      echo -e "when done run terry.sh to finalize"
      rm /yes.sh
      sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
      exit
   elif [ $drivetype1 -eq 3 ]
   then
      mkdir /boot/EFI
      mount /dev/vda1 /boot/EFI
      grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
      grub-mkconfig -o /boot/grub/grub.cfg
      systemctl enable NetworkManager
      echo -e "when done run terry.sh to finalize"
      rm /yes.sh
      sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
      exit
   else
   echo -e "tupac is watching you"
   fi
      
