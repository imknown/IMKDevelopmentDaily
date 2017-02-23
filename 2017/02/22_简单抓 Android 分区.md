``` bash
adb shell
parted /dev/block/*/mmcblk0
print
```

``` bash
adb shell
fdisk -l /dev/block/*/mmcblk0
```

``` bash
adb shell
fdisk -l /dev/block/bootdevice/by-name/* | busybox grep -E 'boot:|recovery:|userdata:|system:|cache:'
```
