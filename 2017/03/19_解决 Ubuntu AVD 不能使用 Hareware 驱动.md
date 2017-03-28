`cd` 到 `../android-sdk-linux/emulator/`

加入参数: `-use-system-libs`
``` bash
./emulator -avd Nexus_5X_API_24 -dns-server 119.29.29.29 -verbose -use-system-libs
```

**如果 不好用**, 尝试:
``` bash
# 列出 所有位置
locate libstdc++.so.6
```

然后选一个位置, 最前面加入: 
> LD_PRELOAD='/usr/lib/x86_64-linux-gnu/libstdc++.so.6'

例如:
``` bash
LD_PRELOAD='/usr/lib/x86_64-linux-gnu/libstdc++.so.6' ./emulator -avd Nexus_5X_API_24 -dns-server 119.29.29.29 -verbose
```

# 参考
- http://stackoverflow.com/questions/35911302/cannot-launch-emulator-on-linux-ubuntu-15-10
- http://stackoverflow.com/questions/36189393/android-studio-avd-error-launching
- http://stackoverflow.com/questions/37050536/not-allow-me-to-run-the-emulator-on-android-studio-for-lack-of-driver-in-the-ope
