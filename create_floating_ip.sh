#!/bin/bash 
export ip_network=10.10.1.0/24 
export ip_pool_start=10.10.1.150
export ip_pool_end=10.10.1.200
export ip_gateway=10.10.1.1
export router_id=external_router1
export vlan_id=external_vlan1
export num_float_ips=5
export COUNTER=1

cd ~/
source /root/keystonerc_admin
#neutron net-create public --router:external=True
#neutron subnet-create public $ip_network --name $vlan_id --enable_dhcp False --allocation_pool start=$ip_pool_start,end=$ip_pool_end --gateway $ip_gateway
#neutron router-create $router_id
#neutron router-gateway-set $router_id $vlan_id

#while [  $COUNTER -lt $num_float_ips ]; do
#             neutron floatingip-create public 
#             let COUNTER=COUNTER+1 
#         done

neutron floatingip-list
neutron net-list



