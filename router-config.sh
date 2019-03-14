sh ipconfig-router.sh

#1.1.1 DNS name resolution requests:

iptables -A INPUT -s 193.137.16.75 -p udp --dport domain -j ACCEPT

#1.1.2 SSH communications with the router system, if originated at the internal network
#or at the VPN gateway (vpn-gw):

iptables -A INPUT -s 192.168.10.0/24 -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -s 23.214.219.130 -p tcp  --dport ssh -j ACCEPT

#2 Drop all communications between networks, except:                
#2.1 Domain name resolutions using the dns server.
    #iptables -A FORWARD -s *.*.*.* -p dns -j ACCEPT
#2.2 The dns server should be able to resolve names using DNS servers on the Internet (dns2 and also others)?

#2.3 The dns and dns2 servers should be able to synchronize the contents of DNS zones?

#2.4 SMTP connections to the smtp server.
iptables -A FORWARD -d 23.214.219.134 -p tcp -dport 25 -j ACCEPT
iptables -A FORWARD -d 23.214.219.134 -p tcp -dport 587 -j ACCEPT

iptables -A FORWARD -s 23.214.219.134 -p tcp -sport 25 -j ACCEPT
iptables -A FORWARD -s 23.214.219.134 -p tcp -sport 587 -j ACCEPT


#2.5 POP and IMAP connections to the mail server.
iptables -A FORWARD -d 23.214.219.131 -p tcp -dport 110 -j ACCEPT
iptables -A FORWARD -d 23.214.219.131 -p tcp -dport 995 -j ACCEPT
iptables -A FORWARD -d 23.214.219.131 -p tcp -dport 143 -j ACCEPT
iptables -A FORWARD -d 23.214.219.131 -p tcp -dport 993 -j ACCEPT

iptables -A FORWARD -s 23.214.219.131 -p tcp -sport 110 -j ACCEPT
iptables -A FORWARD -s 23.214.219.131 -p tcp -sport 995 -j ACCEPT
iptables -A FORWARD -s 23.214.219.131 -p tcp -sport 143 -j ACCEPT
iptables -A FORWARD -s 23.214.219.131 -p tcp -sport 993 -j ACCEPT

#2.6 HTTP and HTTPS connections to the www server.
iptables -A FORWARD -d 23.214.219.133 -p tcp -dport 443 -j ACCEPT
iptables -A FORWARD -d 23.214.219.133 -p tcp -dport 80 -j ACCEPT

iptables -A FORWARD -s 23.214.219.133 -p tcp -sport 443 -j ACCEPT
iptables -A FORWARD -s 23.214.219.133 -p tcp -sport 80 -j ACCEPT

#2.7 OpenVPN connections to the vpn-gw server.
iptables -A FORWARD -s 23.214.219.130 -p udp --sport 1194 -j ACCEPT

iptables -A FORWARD -d 23.214.219.130 -p udp --dport 1194 -j ACCEPT

#2.8 VPN clients connected to the gateway (vpn-gw) should able to connect to the PosgreSQL service on the datastore server.                    

iptables -A FORWARD -s 23.214.219.130 -d 192.168.10.3 -p tcp --dport 5432 -j ACCEPT
iptables -A FORWARD -d 23.214.219.130 -s 192.168.10.3 -p tcp --sport 5432 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
