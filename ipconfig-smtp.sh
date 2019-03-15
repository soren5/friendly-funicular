ifconfig enp0s8 23.214.219.134 netmask 255.255.255.0 up
route add default gw 23.214.219.254

#IPs DMZ -
#
#23.214.219.130 - vpn-gw
#23.214.219.131 - mail
#23.214.219.132 - dns
#23.214.219.133 - www
#23.214.219.134 - smtp
#
#Internal Machine -
#
#192.168.10.2 - ftp
#192.168.10.3 - datastore
#192.168.10.4 - dhcp client
