#!/usr/bin/env cat

Check usb drive, for example /dev/sda
```
fdisk -l
```

Burn iso to usb
```
sudo dd if=/home/user/Downloads/memtest.iso of=/dev/sda status=progress oflag=sync
```