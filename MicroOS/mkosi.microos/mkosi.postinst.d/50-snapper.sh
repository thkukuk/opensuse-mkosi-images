#! /usr/bin/bash

sed -i 's/^NUMBER_LIMIT=.*$/NUMBER_LIMIT="2-10"/g' /buildroot/etc/snapper/configs/root
sed -i 's/^NUMBER_LIMIT_IMPORTANT=.*$/NUMBER_LIMIT_IMPORTANT="4-10"/g' /buildroot/etc/snapper/configs/root
