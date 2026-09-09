#! /usr/bin/bash

sed -i 's/^NUMBER_LIMIT=.*$/NUMBER_LIMIT="10"/g' /buildroot/etc/snapper/configs/root
