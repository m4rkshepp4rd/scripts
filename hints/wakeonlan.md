#!/usr/bin/env cat

https://wiki.archlinux.org/title/Wake-on-LAN#Trigger_a_wake_up

# Server setup

Get mac address of network card
```
ip link
```


List connections
```
nmcli con show
```

Make persistent WoWLAN
```
nmcli c modify "RT-5GPON-FC12" 802-11-wireless.wake-on-wlan magic
```


Check type on connection
```
nmcli c show "RT-5GPON-FC12"
nmcli c show "RT-5GPON-FC12" | grep wake
```

# Client setup
Install package wol
```
paru -S wol
```

usage
```
wol -p 9 -i <target_IP> <target_MAC_address>
```