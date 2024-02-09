
loadkeys fr

timedatectl set-ntp true
timedatectl status

mkfs.fat -F32 /dev/nvme1p1
mkswap /dev/nvme1p2
mkfs.ext4 /dev/nvme1p3

mount /dev/nvme1p3 /mnt
swapon /dev/nvme1p2

pacstrap /mnt base base-devel linux linux-headers linux-firmware
pacstrap /mnt nano git sudo grub efibootmgr os-prober networkmanager ntfs-3g
pacstrap /mnt ncdu htop p7zip zip unzip bat wget go ntp python-pip zsh tig openssh net-tools tcpdump axel

pacman -Sy archlinux-keyring

mkdir -p /mnt/boot/efi
mount /dev/nvme1p1 /mnt/boot/efi

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

timedatectl set-local-rtc 1 --adjust-system-clock
ntpdate -u 0.arch.pool.ntp.org
hwclock --systohc

locale-gen

echo "LANG=fr_FR.UTF-8" > /etc/locale.conf

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

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch Linux GRUB"
grub-mkconfig -o /boot/grub/grub.cfg


pacman -Sy plasma kde-applications

systemctl enable sddm.service
systemctl enable NetworkManager.service
systemctl start sddm.service

pacman -Sy base-devel
cd /opt
git clone https://aur.archlinux.org/yay.git
chown -R pablinux:users ./yay
cd yay
makepkg -si

pacman -Sy audacity obs-studio discord 

yay -S google-chrome anydesk-bin visual-studio-code-bin typora spotify timeshift

pacman -S nvidia nvidia-utils nvidia-settings nvidia-lts
pacman -Ss xf86-video







