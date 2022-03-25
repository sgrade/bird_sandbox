# Summary

The playbook didn't work as a behaviour like with non-persistent interface names was observed. 
Not sure why this happened as "PREDICTABLE NAMES" scheme is expected in Debian 11 ([details](https://wiki.debian.org/NetworkInterfaceNames)). 
Stopped investigating as found better solution for the problem, because of which I started developing this role. 
Left for reference in case something similar is needed in the future. 

# Details

Below is an example how after reboot the IPs moved from one interface to another. 
The IPs are assigned by DHCP (default config). 

## Original state
```
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 02:fd:22:40:d9:ea brd ff:ff:ff:ff:ff:ff
    inet 10.0.13.11/24 brd 10.0.13.255 scope global dynamic eth1
       valid_lft 3209sec preferred_lft 3209sec
    inet6 2a05:d014:c25:3d0d::b/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::fd:22ff:fe40:d9ea/64 scope link
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 02:ab:e2:8d:43:84 brd ff:ff:ff:ff:ff:ff
    inet 10.0.12.11/24 brd 10.0.12.255 scope global dynamic eth2
       valid_lft 3228sec preferred_lft 3228sec
    inet6 2a05:d014:c25:3d0c::b/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::ab:e2ff:fe8d:4384/64 scope link
       valid_lft forever preferred_lft forever

root@router1:~# udevadm test-builtin net_id /sys/class/net/eth1 2>/dev/null
ID_NET_NAMING_SCHEME=v247
ID_NET_NAME_MAC=enx02fd2240d9ea
root@router1:~# udevadm test-builtin net_id /sys/class/net/eth2 2>/dev/null
ID_NET_NAMING_SCHEME=v247
ID_NET_NAME_MAC=enx02abe28d4384
```

## After reboot
The configs 
```
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 02:ab:e2:8d:43:84 brd ff:ff:ff:ff:ff:ff
    inet 10.0.12.11/24 brd 10.0.12.255 scope global dynamic eth1
       valid_lft 3427sec preferred_lft 3427sec
    inet6 2a05:d014:c25:3d0c::b/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::ab:e2ff:fe8d:4384/64 scope link
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 02:fd:22:40:d9:ea brd ff:ff:ff:ff:ff:ff
    inet 10.0.13.11/24 brd 10.0.13.255 scope global dynamic eth2
       valid_lft 3427sec preferred_lft 3427sec
    inet6 2a05:d014:c25:3d0d::b/128 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::fd:22ff:fe40:d9ea/64 scope link
       valid_lft forever preferred_lft forever

root@router1:~# udevadm test-builtin net_id /sys/class/net/eth1 2>/dev/null
ID_NET_NAMING_SCHEME=v247
ID_NET_NAME_MAC=enx02abe28d4384
root@router1:~# udevadm test-builtin net_id /sys/class/net/eth2 2>/dev/null
ID_NET_NAMING_SCHEME=v247
ID_NET_NAME_MAC=enx02fd2240d9ea
```
