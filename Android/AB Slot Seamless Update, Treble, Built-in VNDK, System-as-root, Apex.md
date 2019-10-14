# A/B Slot Seamless Update (Android 7+)
> https://source.android.com/devices/tech/ota/ab?hl=en  
> https://source.android.google.cn/devices/tech/ota/ab?hl=zh-CN
``` sh
# 输出 true 表示 支持 A/B 槽位 无缝升级
adb shell getprop ro.build.ab_update

# 输出 _a 或者 _b, 表示 正在使用的槽位
adb shell getprop ro.boot.slot_suffix

# 输出 boot_a 和 boot_b, 表示两个 boot 槽位的名称
adb shell 'ls /dev/block/bootdevice/by-name | grep boot_'
```

# Project Treble (Android 8+)
> https://source.android.com/devices/architecture/?hl=en#hidl  
> https://source.android.google.cn/devices/architecture/?hl=zh-CN#hidl
``` sh
# 输出 true, 表示 启用了 Project Treble
adb shell getprop ro.treble.enabled
```

# 内建 Vendor NDK (Android 8+)
> https://source.android.com/devices/architecture/vndk?hl=en  
> https://source.android.google.cn/devices/architecture/vndk?hl=zh-CN
``` sh
# 输出 true, 表示 支持
adb shell getprop ro.vndk.lite

# 输出 API 等级, 表示 支持到对应版本
adb shell getprop ro.vndk.version
```

# System-as-root (SAR, Android 9+)
> https://source.android.com/devices/bootloader/system-as-root?hl=en  
> https://source.android.google.cn/devices/bootloader/system-as-root?hl=zh-CN  
> https://github.com/topjohnwu/magisk_files/blob/2d7ddefbe4946806de1875a18247b724f5e7d4a0/notes.md
``` sh
# (Android 9+) 输出 不为空的值, 表示 **未**启用 System-as-root
# adb shell "cat /proc/mounts | grep 'rootfs / rootfs'"
adb shell "mount | grep 'rootfs on / type rootfs'"
```

# APEX (Android 10+)
> https://source.android.com/devices/tech/ota/apex?hl=en  
> https://source.android.google.cn/devices/tech/ota/apex?hl=zh-CN
``` sh
# 输出 不为空的值, 表示 挂载了 /apex
# adb shell "cat /proc/mounts | grep 'tmpfs /apex tmpfs'"
adb shell "mount | grep 'tmpfs on /apex type tmpfs'"

# 输出 不为空的值, 表示 使用了 /apex
# adb shell "cat /proc/mounts | grep /apex/com.android.tzdata"
adb shell "mount | grep /apex/com.android.tzdata"
```

# 查看架构
``` sh
adb shell getprop ro.product.cpu.abi
adb shell getprop ro.product.cpu.abi2
adb shell getprop ro.product.cpu.abilist
adb shell getprop ro.product.cpu.abilist32
adb shell getprop ro.product.cpu.abilist64
```

# 规则
- 支持 A/B 无缝升级的 Android 9+ 设备, 一定 启用了 System-as-root
- 非 A/B 无缝升级的 Android 9+ 设备, 如果支持了 OTA, 则 一定 启用了 System-as-root
- 预装 Android 8+ 设备, 一定 启用了 Treble
