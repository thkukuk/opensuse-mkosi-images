#!/bin/bash

set -e

echo "*** Copy root dir for systemd-repart ***"

# RemoveFiles= runs before the finalize scripts, so anything recreated
# by earlier finalize scripts (e.g. sdbootutil/dracut writing to
# /var/cache) is still present here. Cleanup as late as possible manual.
rm -rf \
	/buildroot/init \
	/buildroot/var/adm \
	/buildroot/var/cache \
	/buildroot/var/crash \
	/buildroot/var/lib/ca-certificates \
	/buildroot/var/lib/zypp/AnonymousUniqueId \
	/buildroot/var/lib/systemd/random-seed \
	/buildroot/var/lock \
	/buildroot/var/run \
	/buildroot/var/spool \
	/buildroot/var/opt

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

# cleanup subvolumes and directories which will be over-mounted
# in the running system with the real data
subvols=".snapshots opt root srv usr/local var"
# On Raspberry Pi /boot/efi is over-mounted by the ESP, not /boot
if [ -d /buildroot/boot/vc ]; then
    subvols+=" boot/efi"
else
    subvols+=" boot"
fi
for subvol in $subvols ; do
	find "/buildroot/rootdir/${subvol}" -mindepth 1 -delete
done
