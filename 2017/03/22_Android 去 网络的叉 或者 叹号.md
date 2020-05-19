# Android 8 ~ 11
> [Android 11](https://android.googlesource.com/platform/frameworks/base/+/android-r-preview-4/core/java/android/provider/Settings.java)  
> [Android 10](https://android.googlesource.com/platform/frameworks/base/+/android-10.0.0_r1/core/java/android/provider/Settings.java)   
> [Android 9](https://android.googlesource.com/platform/frameworks/base/+/android-9.0.0_r1/core/java/android/provider/Settings.java)  
> [Android 8.1.0](https://android.googlesource.com/platform/frameworks/base/+/android-8.1.0_r1/core/java/android/provider/Settings.java)  
> [Android 8.0.0](https://android.googlesource.com/platform/frameworks/base/+/android-8.0.0_r1/core/java/android/provider/Settings.java)  

``` shell
adb shell settings put global captive_portal_mode 1
adb shell settings put global captive_portal_use_https 1
adb shell settings put global captive_portal_http_url http://www.google.cn/generate_204
adb shell settings put global captive_portal_https_url https://www.google.cn/generate_204
adb shell settings put global captive_portal_fallback_url http://www.google.cn/generate_204
adb shell settings put global captive_portal_other_fallback_urls http://www.google.cn/generate_204
```

# Android 7.1.2
> [Android 7.1.2](https://android.googlesource.com/platform/frameworks/base/+/android-7.1.2_r1/core/java/android/provider/Settings.java)

``` shell
adb shell settings put global captive_portal_mode 1
adb shell settings put global captive_portal_use_https 1
adb shell settings put global captive_portal_http_url http://www.google.cn/generate_204
adb shell settings put global captive_portal_https_url https://www.google.cn/generate_204
adb shell settings put global captive_portal_fallback_url http://www.google.cn/generate_204
```

# Android 7.1.1
> [Android 7.1.1](https://android.googlesource.com/platform/frameworks/base/+/android-7.1.1_r1/core/java/android/provider/Settings.java)

``` shell
adb shell settings put global captive_portal_detection_enabled 1
adb shell settings put global captive_portal_use_https 1
adb shell settings put global captive_portal_http_url http://www.google.cn/generate_204
adb shell settings put global captive_portal_https_url https://www.google.cn/generate_204
adb shell settings put global captive_portal_fallback_url http://www.google.cn/generate_204
```

# Android 7.0.0, Android 7.1.0
> [Android 7.1.0](https://android.googlesource.com/platform/frameworks/base/+/android-7.1.0_r1/core/java/android/provider/Settings.java)  
> [Android 7.0.0](https://android.googlesource.com/platform/frameworks/base/+/android-7.0.0_r1/core/java/android/provider/Settings.java)

``` shell
adb shell settings put global captive_portal_detection_enabled 1
adb shell settings put global captive_portal_use_https 1
adb shell settings put global captive_portal_server www.google.cn
```

# Android 6, Android 5
> [Android 6.0.1](https://android.googlesource.com/platform/frameworks/base/+/android-6.0.1_r1/core/java/android/provider/Settings.java)  
> [Android 6.0.0](https://android.googlesource.com/platform/frameworks/base/+/android-6.0.0_r1/core/java/android/provider/Settings.java)  
> [Android 5.1.1](https://android.googlesource.com/platform/frameworks/base/+/android-5.1.1_r1/core/java/android/provider/Settings.java)  
> [Android 5.1.0](https://android.googlesource.com/platform/frameworks/base/+/android-5.1.0_r1/core/java/android/provider/Settings.java)  
> [Android 5.0.2](https://android.googlesource.com/platform/frameworks/base/+/android-5.0.2_r1/core/java/android/provider/Settings.java)  
> [Android 5.0.1](https://android.googlesource.com/platform/frameworks/base/+/android-5.0.1_r1/core/java/android/provider/Settings.java)  
> [Android 5.0.0](https://android.googlesource.com/platform/frameworks/base/+/android-5.0.0_r1/core/java/android/provider/Settings.java)  

``` shell
adb shell settings put global captive_portal_detection_enabled 1
adb shell settings put global captive_portal_server www.google.cn
```

# 可选服务器
- connect.rom.miui.com
- captive.v2ex.co
- noisyfox.cn
- 204.io
- google.cn
- g.cn

# 参考
https://android.stackexchange.com/questions/186993/captive-portal-parameters
