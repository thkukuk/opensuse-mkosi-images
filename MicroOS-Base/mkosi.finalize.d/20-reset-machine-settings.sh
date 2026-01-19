#! /usr/bin/bash

echo "*** reset machine settings and cache ***"
#rm -fv /buildroot/etc/machine-id
rm -fv /buildroot/var/lib/zypp/AnonymousUniqueId \
       /buildroot/var/lib/systemd/random-seed
rm -fv /buildroot/init
rm -rfv /buildroot/var/cache/{gio-2.0,man,zypp}
