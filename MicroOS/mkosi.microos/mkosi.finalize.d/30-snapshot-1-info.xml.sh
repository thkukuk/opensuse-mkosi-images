#! /bin/bash

# Get the current date in the specific format: YYYY-MM-DD HH:MM:SS
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# XXX /@/.snapshots/1/snapshot/.snapshots/1/info.xml will stay!

mkdir -p /buildroot/.snapshots/1
# Output the XML using a heredoc
cat <<EOF > /buildroot/.snapshots/1/info.xml
<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>${CURRENT_DATE}</date>
  <description>Initial installed system</description>
  <cleanup>number</cleanup>
  <userdata>
    <key>important</key>
    <value>yes</value>
  </userdata>
</snapshot>
EOF
