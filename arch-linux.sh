loadkeys fr
pacman -Syy

timedatectl set-ntp true
timedatectl status

mkfs.fat -F32 /dev/nvme1n1p1
mkswap /dev/nvme1n1p2
mkfs.ext4 /dev/nvme1n1p3

mount /dev/nvme1n1p3 /mnt
swapon /dev/nvme1n1p2

pacstrap /mnt base base-devel linux linux-headers linux-firmware

pacman -Sy archlinux-keyring

mkdir -p /mnt/boot
mount /dev/nvme1n1p1 /mnt/boot

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
