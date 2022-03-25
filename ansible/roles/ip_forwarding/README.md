# Summary
After IP forwarding is enabled, the IPv6 routes disappear except for local IPs. 
After IP forwarding is disabled, the routes appear again. 

For the changes to happen, restart networking.
```
systemctl restart networking.service
```

# Notes (TODO: verify why like this)

Enabling of `net.ipv6.conf.all.accept_ra` didn't return the routes.
Enabling per-interface specific settings (e.g. `net.ipv6.conf.eth1.accept_ra`) solved it. 

# Documenation

Description of the options - [https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt](https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt).

User-friendly sysctl explorer - [https://sysctl-explorer.net/net/ipv6/forwarding/](https://sysctl-explorer.net/net/ipv6/forwarding/).

# The routes

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

# Kernel vs RA routes
Two types of routes disappear:
- routes to the directly-connected networks from "proto kernel"
- default routes from "proto ra"

Note: from "man ip-route"
- kernel - the route was installed by the kernel during autoconfiguration.
- ra - the route was installed by Router Discovery protocol.

# DHCP
Set RUN="yes" in /etc/dhcp/dhclient-enter-hooks.d/debug to debug DHCP. 

The output (/tmp/dhclient-script.debug) will show that the IPv6 addresses are received by DHCP with prefix /128.

So the routes are set differently.
