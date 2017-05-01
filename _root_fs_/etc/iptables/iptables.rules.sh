#!/usr/bin/env bash

IPT_DIR=/etc/iptables
IPTFILE=$IPT_DIR/iptables.rules

VPN_NET=10.0.0.0/24
VPN_IF0=tap0

# Fill in SSH port.
SSH_PRT=$(grep --  "Port " /etc/ssh/sshd_config|awk '{print $2}')

cat > $IPTFILE << EOF
*filter

:INPUT DROP
-A INPUT -j ACCEPT -i lo  -m comment --comment "ALLOW|LOOPBACK"
-A INPUT -j DROP -p icmp -m comment --comment "BLOCK|IN|ICMP"
-A INPUT -j ACCEPT -m state --state RELATED,ESTABLISHED -m comment --comment "*** Begin Stateful:IN ***"
-A INPUT -j ACCEPT -p tcp -m state --state NEW -m tcp --dport $SSH_PRT -m comment --comment "ALLOW|IN|SSH"

:FORWARD DROP

:OUTPUT DROP
-A INPUT -p icmp -j ACCEPT -m comment --comment "BLOCK|OUT|ICMP"
-A OUTPUT --out-interface $VPN_IF0 -j ACCEPT -m comment --comment "VPN|IF:$VPN_IF0"
-A OUTPUT -j ACCEPT -p tcp -d $VPN_NET -m comment --comment "VPN|$VPN_NET"
-A OUTPUT -j ACCEPT -m state --state RELATED,ESTABLISHED -m comment --comment "*** Begin Stateful:OUT ***"
-A OUTPUT -j ACCEPT -p tcp -m state --state NEW --dport 22 -m comment --comment "ALLOW|OUT|SSH"
-A OUTPUT -j ACCEPT -p udp -m state --state NEW --dport 53 -m comment --comment "ALLOW|OUT|SSH"
-A OUTPUT -j ACCEPT -p tcp -m state --state NEW --dport 80 -m comment --comment "ALLOW|OUT|HTTP"
-A OUTPUT -j ACCEPT -p tcp -m state --state NEW --dport 123 -m comment --comment "ALLOW|OUT|NTP"
-A OUTPUT -j ACCEPT -p tcp -m state --state NEW --dport 443 -m comment --comment "ALLOW|OUT|HTTPS"

COMMIT
EOF
