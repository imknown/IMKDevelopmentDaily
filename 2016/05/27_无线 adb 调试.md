
- Android Rooted 设备 终端输入:  
``` bash
setprop service.adb.tcp.port 5555
stop adbd
start adbd
```

- 研发机 设备 控制台输入:  
``` shell
adb connect 192.168.11.112:5555
```

无线速度 还是没有 有线速度 快. 不知道 是不是 手机网卡 垃圾.
