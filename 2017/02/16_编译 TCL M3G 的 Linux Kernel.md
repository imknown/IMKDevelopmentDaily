~~编译... 教程改天补...~~



# 下载 kernel 源码
``` bash
git clone https://github.com/lrinQVQ/android_kernel_tcl_q39.git
```



# 配置临时环境变量 与 编译
首先准备好 CyanogenMod/LineageOS 相关资源, 假定 `LineageOS` 在 `~/Android/LineageOS/`

``` bash
export PATH=$PATH:~/Android/LineageOS/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-android-
```

``` bash
make q39_defconfig
make
```



# 处理 kernel 和 dt
复制 `~/Android/LineageOS/out/host/Linux-x86/bin/dtbToolCM` 到 `android_kernel_tcl_q39` 根目录

``` bash
./dtbToolCM -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/
```

进入 `android_kernel_tcl_q39/arch/arm64/boot/`:
- `Image` 是 `kernel`(可以直接改名为 `kernel`)
- `dt.img` 是 `dt`

下载 `mkbootimg_tools`
``` bash
git clone https://github.com/xiaolu/mkbootimg_tools
```

解压
``` bash
./mkboot cm-12.1-q39-20170123-boot.img boot_extract
```

进入 `boot_extract`, 替换 `kernel` 和 `dt.img`

重打包
``` bash
./mkboot boot_extract boot_repack.img
```



# 配置 Linux 的 Android fastboot
> 参考 https://developer.android.com/studio/run/device.html

先拔掉手机, `lsusb` 查看 当前 USB 设备  
再插上手机, `lsusb` 查看 和上一次的差异 (实在找不到 加 -v 看看, 可以看 iProduct)  

差异如:
``` bash
# 其中格式为 ID idVendor:idProduct
# T & A Mobile Phones 就是 TCL 和 Alcatel
Bus 003 Device 005: ID 18d1:4ee2 Google Inc. Nexus 4 (debug)
Bus 003 Device 041: ID 1bbb:9039 T & A Mobile Phones
Bus 003 Device 034: ID 0e8d:2000 MediaTek Inc. MT65xx Preloader
```

创建 USB 规则
``` bash
sudo touch /etc/udev/rules.d/51-android.rules
```

编辑
``` bash
sudo gedit /etc/udev/rules.d/51-android.rules
```

加入
``` bash
# idVendor 和 idProduct 别写错了
# 其实网上也有很多现成的, 我只是 用我自己手机 做示范
SUBSYSTEM=="usb", ATTR{idVendor}=="1bbb", ATTR{idProduct}=="9039", MODE="0666"
```

加权限
``` bash
sudo chmod a+r /etc/udev/rules.d/51-android.rules
```

重载入 使之生效
``` bash
sudo udevadm control --reload-rules
# 或者 sudo service udev restart
# 或者 重启插一下手机也行..
```


# 刷入 boot 分区
``` bash
adb reboot bootloader
fastboot devices
fastboot flash boot boot_repack.img
fastboot reboot
```

不卡在一屏 即是没问题
