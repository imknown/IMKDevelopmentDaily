首先进入 `../android-sdk-linux/emulator/`

``` bash
# 看看自己的 模拟器名字
./emulator -list-avds
```

``` bash
# 这个 `DNS` 改成 可用的就行, 不一定是 谷歌的 '8.8.8.8'.
# 这个 模拟器名字 别忘记换成自己的
emulator -avd Nexus_5X_API_24 -dns-server 8.8.8.8 -verbose
```

# 参考
- https://developer.android.com/studio/run/emulator-commandline.html
- https://laaptu.wordpress.com/2011/06/14/solution-to-android-emulator-not-connecting-to-internet-even-though-there-is-internet-connection-on-computer/
