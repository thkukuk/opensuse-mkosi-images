#! /usr/bin/bash

#
# Setup configs and services
#
echo FONT="eurlatgr.psfu" >> /buildroot/etc/vconsole.conf

echo "/etc /etc none bind,x-initrd.mount 0 0" >> /buildroot/etc/fstab

# Adjust relabel file from SELinux
test -f /buildroot/.autorelabel && mv -v /buildroot/.autorelabel /buildroot/etc/selinux/

# Adjust zypp conf XXX
#sed -i 's/^multiversion =.*/multiversion =/g' /buildroot/etc/zypp/zypp.conf
#sed -i 's/.*solver.onlyRequires.*/solver.onlyRequires = true/g' /buildroot/etc/zypp/zypp.conf
#sed -i 's/.*rpm.install.excludedocs.*/rpm.install.excludedocs = yes/g' /buildroot/etc/zypp/zypp.conf
