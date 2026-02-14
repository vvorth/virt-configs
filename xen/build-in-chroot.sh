#!/bin/bash 

CHROOT=/mnt/chroots/arch
sudo mount --mkdir -t tmpfs -o defaults,size=24G tmpfs $CHROOT
sudo mkarchroot $CHROOT/root base-devel
cd bin86/
makechrootpkg -c -r /mnt/chroots/arch/
sudo cp bin86-0.16.21-6-x86_64.pkg.tar.zst $CHROOT/root/
sudo arch-nspawn $CHROOT/root pacman -U /bin86-0.16.21-6-x86_64.pkg.tar.zst
cd ..
cd dev86/
makechrootpkg -c -r /mnt/chroots/arch/
sudo cp dev86-0.16.21-8-x86_64.pkg.tar.zst $CHROOT/root/
sudo arch-nspawn $CHROOT/root pacman -U /dev86-0.16.21-8-x86_64.pkg.tar.zst
cd ..
#
# build xen
cd xen/
# add python-distutils to makedepends
vim PKGBUILD 
makechrootpkg -c -r /mnt/chroots/arch/
yay -U xen-4.19.1pre-1-x86_64.pkg.tar.zst xen-docs-4.19.1pre-1-any.pkg.tar.zst 

