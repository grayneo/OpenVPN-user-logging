#!/bin/bash
clear
FS=$'\n'

logfile="/var/log/openvpn-status.log"
path="/var/log/openvpn-user/userlog"
tmp="/tmp/tmp"
tmp_file="/tmp/tmp_file"
diff_file="/tmp/diff_file"
add="/tmp/add"
del="/tmp/del"
#

change (){
 grep '^[0-9]' $logfile | cut -f 1-2 -d ,  > $tmp
DIFF=$( diff $tmp_file $tmp ) 
if [ "$DIFF" != "" ] 
then
 diff $tmp_file $tmp  > $diff_file
 grep ">" $diff_file | cut -d , -f1 | sed s/">"//g > $add
grep "<" $diff_file | cut -d , -f1 | sed s/"<"//g > $del
 cp $tmp $tmp_file
fi
}

line_add(){

 while read name; do
file=$(grep $name $tmp )

 sudo tcpdump -n -i tun0 -U  "src $name and dst 4.2.2.4 " | awk '{print $1 "  " $8}'  >> "$path"/"$file" &
# sudo tcpdump -n -i tun0 -U  "src $name and dst 4.2.2.4 "  >> "$path"/"$file" &
             done < $add
}

line_del(){
while read name; do

 sudo kill $(pgrep -f "$name")
             done < $del
}

loop() {
while true;do
change
sleep 20
done
}
 grep '^[0-9]' $logfile | cut -f 1-2 -d ,  > $tmp

 grep '^[0-9]' $logfile | cut -f 1-2 -d , |  cut -d , -f1   > $add
cp $tmp $tmp_file
line_add

loop &

while true; do
 inotifywait -e  modify $tmp_file
line_add
line_del
done

