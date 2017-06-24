#!/bin/bash
#install OpenVPN-user-logging 

clear screen
echo "############################################################"
echo "#### Welcome to OpenVPN-user-logging installation ###"
echo "############################################################"

user=$HOME
logfile="/var/log/openvpn-status.log"
install_path=`pwd`
program_path="/usr/bin"


if [ ! -f $logfile ];then
echo "error file /var/log/openvpn-status.log isn't available"
echo "make sute in file /etc/openvpn/server.conf have this line of setting"
echo "status /var/log/openvpn-status.log 3"
echo "verb 3" 
fi

sudo mkdir -p  /var/log/openvpn-user/userlog >/dev/null 2>&1

echo "sudo  mv -f $install_path/openvpn-user-logging.sh $program_path "

echo "log file create there /var/log/openvpn-user/userlog"

sudo chmod +x $program_path/openvpn-user-logging.sh

if [ "$?" -eq "0" ]
   then
      echo "Installation compeleted"
   else
       echo "Installation Failed!"
fi
exit

