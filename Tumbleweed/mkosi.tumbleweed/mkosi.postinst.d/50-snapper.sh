#! /usr/bin/bash

echo "Creating initial snapper config ..."

# Configure snapper
cp /buildroot/usr/share/snapper/config-templates/default /buildroot/etc/snapper/configs/root
sed -i 's/^SNAPPER_CONFIGS=.*$/SNAPPER_CONFIGS="root"/g' /buildroot/etc/sysconfig/snapper

# Adjust parameters
sed -i 's/^TIMELINE_CREATE=.*$/TIMELINE_CREATE="no"/g' /buildroot/etc/snapper/configs/root
sed -i 's/^NUMBER_LIMIT=.*$/NUMBER_LIMIT="10"/g' /buildroot/etc/snapper/configs/root
