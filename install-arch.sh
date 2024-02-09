pacman -Syy

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

ntpdate -u 0.arch.pool.ntp.org
hwclock --systohc

echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
export LANG=en_GB.UTF-8

echo "arch-armand" > /etc/hostname

echo "127.0.0.1     localhost" > /etc/hosts
echo "127.0.1.1     arch-armand" >> /etc/hosts

mkinitcpio -P

echo "Password root ?"
passwd

useradd armand -G wheel
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo " Password Armand ?"
passwd armand

mkdir /home/armand
chown armand:armand /home/armand -R

usermod -a -G sudo armand

pacman -S os-prober ntfs-3g
pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch Linux GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Syu
pacman -Sy xorg plasma kde-applications plasma-wayland-session egl-wayland sddm networkmanager firefox
systemctl enable sddm
systemctl enable NetworkManager.service
systemctl start sddm.service
