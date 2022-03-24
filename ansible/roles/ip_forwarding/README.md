# Summary
After IP forwarding is enabled, some IPv6 routes disappear. 
After IP forwarding is disabled, the routes appear again. 
Some theory behind this behavour is [here](https://tldp.org/HOWTO/Linux+IPv6-HOWTO/ch11s02.html).

# Kernel vs RA routes
Two types of routes disappear:
- routes to the directly-connected networks from "proto kernel"
- default routes from "proto ra"

Note: from "man ip-route"
- kernel - the route was installed by the kernel during autoconfiguration.
- ra - the route was installed by Router Discovery protocol.

Note: enabling of `net.ipv6.conf.all.accept_ra` didn't return the defaults; same with per-interface settings.

# DHCP
Set RUN="yes" in /etc/dhcp/dhclient-enter-hooks.d/debug to debug DHCP. 

The output (/tmp/dhclient-script.debug) will show that the IPv6 addresses are received by DHCP with prefix /128.

So the routes are set differently.


# The routes from a VM
Tested on Debian 11

## Before IP forwarding
```
admin@router2:~$ ip -6 route show
::1 dev lo proto kernel metric 256 pref medium
2a05:d014:1c9:bb0c::16 dev eth2 proto kernel metric 256 pref medium
2a05:d014:1c9:bb0c::/64 dev eth2 proto kernel metric 256 pref medium
2a05:d014:1c9:bb17::16 dev eth1 proto kernel metric 256 pref medium
2a05:d014:1c9:bb17::/64 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth0 proto kernel metric 256 pref medium
fe80::/64 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth2 proto kernel metric 256 pref medium
default via fe80::ad:88ff:feef:42d0 dev eth1 proto ra metric 1024 expires 1793sec hoplimit 255 pref medium
default via fe80::bc:9cff:fe74:ecf8 dev eth2 proto ra metric 1024 expires 1796sec hoplimit 255 pref medium
```

## After ip_forwarding is enabled
```
admin@router2:~$ ip -6 route show
::1 dev lo proto kernel metric 256 pref medium
2a05:d014:1c9:bb0c::16 dev eth2 proto kernel metric 256 pref medium
2a05:d014:1c9:bb0c::/64 dev eth2 proto kernel metric 256 pref medium
2a05:d014:1c9:bb17::16 dev eth1 proto kernel metric 256 pref medium
2a05:d014:1c9:bb17::/64 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth0 proto kernel metric 256 pref medium
fe80::/64 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth2 proto kernel metric 256 pref medium
```

## After networking restart
```
admin@router2:~$ sudo systemctl restart networking

admin@router2:~$ ip -6 route show
::1 dev lo proto kernel metric 256 pref medium
2a05:d014:1c9:bb0c::16 dev eth2 proto kernel metric 256 pref medium
2a05:d014:1c9:bb17::16 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth0 proto kernel metric 256 pref medium
fe80::/64 dev eth1 proto kernel metric 256 pref medium
fe80::/64 dev eth2 proto kernel metric 256 pref medium
```