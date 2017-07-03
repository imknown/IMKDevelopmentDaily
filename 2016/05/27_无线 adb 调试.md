
- Android Rooted 设备(假设 ip 为 `192.168.1.101`) 终端输入:  
``` bash
setprop service.adb.tcp.port 5555
stop adbd
start adbd
```

- 谷歌的方法 (免 Root)  
参考 https://developer.android.com/studio/command-line/adb.html#wireless
``` bash
adb tcpip 5555
```

- 研发机 设备 控制台输入:  
``` shell
adb connect 192.168.1.101:5555
```

无线速度 还是没有 有线速度 快. 不知道 是不是 手机网卡 垃圾.
5555 是默认端口.
