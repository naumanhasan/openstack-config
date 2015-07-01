#!/bin/bash
if [ -z "$1" ]
  then
 echo "Syntax: create_em1_config [ip] [mask] [gateway] [domain] [dns1] [dns2]"
fi
# $1 = ip , $2 = netmask  ,$3= domain name 

echo "DEVICE=em1" > ../generated_configs/ifcfg-em1
echo "TYPE=Ethernet" >>../generated_configs/ifcfg-em1
echo BOOTPROTO=static >> ../generated_configs/ifcfg-em1
echo "IPADDR=$1" >> ../generated_configs/ifcfg-em1
echo "NETMASK=$2" >>../generated_configs/ifcfg-em1
echo GATEWAY=$3 >> ../generated_configs/ifcfg-em1
echo "DOMAIN=$4" >> ../generated_configs/ifcfg-em1
echo DNS1=$5 >> ../generated_configs/ifcfg-em1
echo DNS2=$6 >> ../generated_configs/ifcfg-em1
echo ONBOOT=yes >> ../generated_configs/ifcfg-em1
echo DEFROUTE=yes >> ../generated_configs/ifcfg-em1
echo "route add default gw 192.168.1.1" >> ../generated_configs/ifcfg-em1
echo "########################################"
echo "Here's how em1 config will look like "
echo "this needs to copied into /etc/sysconfig/network-scripts/ifcfg-em1"
more ../generated_configs/ifcfg-em1

