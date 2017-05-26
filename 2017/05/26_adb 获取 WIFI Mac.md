``` bash
# Way 1:
adb shell ip addr show wlan0  | grep 'link/ether '| cut -d' ' -f6

# Way 2: Need root?
adb shell cat /sys/class/net/wlan0/address

# Way 3: busybox
adb shell busybox ifconfig -a|grep wlan0
```

参考:
- https://stackoverflow.com/questions/38116435/how-to-obtain-wifi-mac-address-of-the-mobile-which-is-connected-to-the-device-us
- https://stackoverflow.com/questions/12197925/get-mac-address-from-adb-of-usb-phone
