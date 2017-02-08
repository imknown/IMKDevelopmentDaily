当然是 x86 架构编译...  

启用一下 TCP 代替 UDP, 大神说效果佳
``` bash
sudo sysctl -w net.ipv4.tcp_window_scaling=0
```
