``` sh
# Android 10 的设备, 一定 system-as-root 输出 true
# 支持 A/B Slot Seamless Update 的设备, 一定 treble 输出 true

# 是否支持 A/B Slot Seamless Update (Android 7.0+)
adb shell getprop ro.build.ab_update 输出 true
adb shell getprop ro.boot.slot_suffix 输出 _a 或者 _b
adb shell 'ls /dev/block/bootdevice/by-name | grep boot_' 输出 boot_a 和 boot_b

# 是否支持 Project Treble (Android 8.0+)
adb shell getprop ro.treble.enabled 输出 true

# 是否支持 System-as-root (SAR, Android 9+)
adb shell "cat /proc/mounts | grep 'tmpfs /apex tmpfs'" 输出 不为空的值
adb shell "cat /proc/mounts | grep /apex/com.android.tzdata" 输出 不为空的值

# 是否支持 内置版 VNDK (Android 8.1+)
adb shell getprop ro.vndk.lite 输出 true
adb shell getprop ro.vndk.version 输出 29

# 查看架构
adb shell getprop ro.product.cpu.abi
adb shell getprop ro.product.cpu.abi2
adb shell getprop ro.product.cpu.abilist
adb shell getprop ro.product.cpu.abilist32
adb shell getprop ro.product.cpu.abilist64
```
