#!/bin/bash

set -e
set -x

echo "*** Copy root dir for systemd-repart ***"

mkdir /buildroot/.rootdir
cp -al /buildroot/* /buildroot/.rootdir/
mv -v /buildroot/.rootdir /buildroot/rootdir/
cp -al /buildroot/.??* /buildroot/rootdir/

# mkosi should not create directories here...
rm -rf /buildroot/rootdir/work

# Replace /etc with symlink, else fstab will not be
# written in /etc/fstab
rm -rf /buildroot/etc
ln -sf rootdir/etc /buildroot/etc

# handle /etc as subvolume, because systemd-repart will create
# the fstab file there later
for subvol in .snapshots boot/efi opt root srv usr/local var ; do
    rm -rf /buildroot/rootdir/${subvol}/*
done
