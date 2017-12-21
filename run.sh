#!/bin/bash

# Load shared libraries from /opt/vc/lib
echo /opt/vc/lib > /etc/ld.so.conf.d/00-vmcs.conf
ldconfig

# Link /opt/vc/bin binaries to /usr/bin
ln -s /opt/vc/bin/raspividyuv /usr/bin/raspividyuv
ln -s /opt/vc/bin/dtmerge /usr/bin/dtmerge
ln -s /opt/vc/bin/raspistill /usr/bin/raspistill
ln -s /opt/vc/bin/vcgencmd /usr/bin/vcgencmd
ln -s /opt/vc/bin/vcdbg /usr/bin/vcdbg
ln -s /opt/vc/bin/dtoverlay-pre /usr/bin/dtoverlay-pre
ln -s /opt/vc/bin/raspiyuv /usr/bin/raspiyuv
ln -s /opt/vc/bin/vchiq_test /usr/bin/vchiq_test
ln -s /opt/vc/bin/tvservice /usr/bin/tvservice
ln -s /opt/vc/bin/edidparser /usr/bin/edidparser
ln -s /opt/vc/bin/raspivid /usr/bin/raspivid
ln -s /opt/vc/bin/dtoverlay-post /usr/bin/dtoverlay-post
ln -s /opt/vc/bin/dtoverlay /usr/bin/dtoverlay
ln -s /opt/vc/bin/dtparam /usr/bin/dtparam

# Insert Docker Host hostname into raspbian.conf
DOCKERHOST=$(cat /dockerhost/etc/hostname)
sed -i "s/'+data.hostname+'/$DOCKERHOST/g" /etc/rpimonitor/template/raspbian.conf

# Update RPI Monitor Package Status
/etc/init.d/rpimonitor install_auto_package_status_update
/usr/share/rpimonitor/scripts/updatePackagesStatus.pl

# Start RPI Monitor
/usr/bin/rpimonitord -v
