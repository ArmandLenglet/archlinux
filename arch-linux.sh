loadkeys fr
pacman -Syy

timedatectl set-ntp true
timedatectl status

mkfs.fat -F32 /dev/nvme1p1
mkswap /dev/nvme1p2
mkfs.ext4 /dev/nvme1p3

mount /dev/nvme1p3 /mnt
swapon /dev/nvme1p2

pacstrap /mnt base base-devel linux linux-headers linux-firmware

pacman -Sy archlinux-keyring

mkdir -p /mnt/boot/efi
mount /dev/nvme1p1 /mnt/boot/efi

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
