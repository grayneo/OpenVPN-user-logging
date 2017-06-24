#!/bin/bash
#uninstall OpenVPN-user-logging

program_path="/usr/bin"
path="/var/log/openvpn-user/"

sudo  rm -f $program_path/openvpn-user-logging.sh 
sudo  rm -f $path
if [ "$?" -eq "0" ]
   then
       echo "Uninstallation compeleted"
fi
exit
