#!/bin/bash
# Warning! Dangerous step! Destroys VMs
for x in $(virsh list --all | grep instance- | awk '{print $2}') ; do
    virsh destroy $x ;
    virsh undefine $x ;
done ;

# Warning! Dangerous step! Removes lots of packages, including many
# which may be unrelated to RDO.
yum remove -y nrpe "*nagios*" puppet ntp ntp-perl ntpdate "*openstack*" \
"*nova*" "*keystone*" "*glance*" "*cinder*" "*swift*" \
mysql mysql-server httpd "*memcache*" scsi-target-utils \
iscsi-initiator-utils perl-DBI perl-DBD-MySQL ;

ps -ef | grep -i repli | grep swift | awk '{print $2}' | xargs kill ;

# Warning! Dangerous step! Deletes local application data
rm -rf /etc/nagios /etc/yum.repos.d/packstack_* /root/.my.cnf \
/var/lib/mysql/ /var/lib/glance /var/lib/nova /etc/nova /etc/swift \
/srv/node/device*/* /var/lib/cinder/ /etc/rsync.d/frag* \
/var/cache/swift /var/log/keystone ;

echo ###### Killing all the processes ########

umount /srv/node/device* ;
killall -9 dnsmasq tgtd httpd rabbitmq mysql mysqld glance-api nova-novncproxy nova-api nova-conductor nova-compute neutron-dhcp-agent ovsdb-client neutron-l3-agent neutron-metadata-agent  neutron-openvswitch-agent ovsdb-server ovs-vswitchd neutron-openvswitch-agent ovsdb-client keystone-all;
setenforce 1 ;
vgremove -f cinder-volumes ;
losetup -a | sed -e 's/:.*//g' | xargs losetup -d ;
find /etc/pki/tls -name "ssl_ps*" | xargs rm -rf ;
for x in $(df | grep "/lib/" | sed -e 's/.* //g') ; do
    umount $x ;
done

echo ##### Remove MySQL DB explicitily #####

rm -rf /var/lib/mysql

echo ##### Verify and killing openstack process ####

ps -ef | grep "rabbitmq" | awk '{print $2}' | xargs kill
ps -ef | grep "mysql" | awk '{print $2}' | xargs kill
ps -ef | grep "httpd" | awk '{print $2}' | xargs kill
ps -ef | grep "keystone-all" | awk '{print $2}' | xargs kill
ps -ef | grep "mysqld" | awk '{print $2}' | xargs kill

