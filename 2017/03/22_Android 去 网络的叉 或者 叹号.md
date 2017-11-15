# Android N+
``` cmd
adb shell settings put global captive_portal_https_url https://www.google.cn/generate_204
adb shell settings put global captive_portal_http_url http://www.google.cn/generate_204
```

# Android M-
``` cmd
adb shell settings put global captive_portal_server www.google.cn
```

# 可选服务器
- connect.rom.miui.com
- captive.v2ex.co
- noisyfox.cn
- google.cn
- g.cn

# 参考
- https://www.v2ex.com/t/303889
- https://kyonli.com/p/208
- http://bbs.gfan.com/android-8418411-1-2.html
- https://android.googlesource.com/platform/frameworks/base/+/android-7.0.0_r31/services/core/java/com/android/server/connectivity/NetworkMonitor.java#691
- https://android.googlesource.com/platform/frameworks/base/+/android-7.1.1_r28/services/core/java/com/android/server/connectivity/NetworkMonitor.java#611
