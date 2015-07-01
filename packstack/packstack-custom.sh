#!/bin/bash

echo "Packstack installer w/ customizations"
export counter = 1
echo $counter
echo ~/restart_counter
#To disable NetworkManager and enable the network service:
 service NetworkManager stop
 service network start
 chkconfig NetworkManager off
 chkconfig network on

#To disable firewalld and enable iptables:

 service firewalld stop
 service iptables start
 chkconfig firewalld off
 chkconfig iptables on

echo "# Make the SELINUX status permissive ##"
cp ~/modified_files/etc/sysconfig/selinux /etc/sysconfig/selinux 
sestatus | grep mode

echo "# Ensure that em1 comes up everytime system is rebooted"
echo "# essentially has the ONBOOT=yes in ifcfg-em1 "
export ONBOOT=`/bin/grep ONBOOT /etc/sysconfig/network-scripts/ifcfg-em1`
if [ $ONBOOT=="" ];
then
        echo "em1  is set to null and need to set to yes"
        sed -i "s/ONBOOT=/ONBOOT=yes/g" /etc/sysconfig/network-scripts/ifcfg-em1

else
     echo em1 is already set to : $ONBOOT
    
fi

#cp ~/modified_files/etc/sysconfig/network-scripts/ifcfg-em1 /etc/sysconfig/network-scripts/ifcfg-em1

echo "Add Software Repos and update system"

yum update -y
yum install -y http://rdo.fedorapeople.org/rdo-release.rpm
yum install -y openstack-packstack

echo "#### please verify "node01" is defined as localhost in /etc/hosts ####"
echo "[root@node01 ~]# cat /etc/hosts"
echo "127.0.0.1   node01 localhost localhost.localdomain localhost4 localhost4.localdomain4"
echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6"

echo "We'll reboot anyways, once done restart this script"


