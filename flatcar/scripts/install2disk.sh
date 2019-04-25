#!/bin/bash
set -e -x

sudo flatcar-install -d /dev/sda -f ~/flatcar_production_image.bin.bz2 -i ignition.json
# -c cloud-init

# Copy on files
sudo mount /dev/sda9 /mnt
mv ~/powershell.tar.gz /mnt/tmp
cp ~/installpowershell.sh /mnt/tmp
cd /mnt

# chroot
sudo mkdir /mnt/usr/bin /mnt/usr/sbin /mnt/usr/lib64
sudo mount -o bind /bin /mnt/usr/bin
sudo mount -o bind /sbin /mnt/usr/sbin
sudo mount -o bind /usr/lib64 /mnt/usr/lib64
sudo chroot /mnt /bin/bash -c "/tmp/installpowershell.sh"

shutdown now -h
