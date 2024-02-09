
loadkeys fr
pacman -Syy

timedatectl set-ntp true
timedatectl status

mkfs.fat -F32 /dev/nvme1n1p1
mkswap /dev/nvme1n1p2
mkfs.ext4 /dev/nvme1n1p3
swapon /dev/nvme1n1p2

mkdir /mnt/boot
mount /dev/nvme1n1p1 /mnt/boot
mount /dev/nvme1n1p3 /mnt

pacstrap /mnt base base-devel linux linux-firmware dhcpcd

pacman -S archlinux-keyring

genfstab -L /mnt >> /mnt/etc/fstab

arch-chroot /mnt
