# 安装
``` bash
sudo apt install tsocks 
```

# 编辑
``` bash
sudo gedit /etc/tsocks.conf
```

最下面的 `server` 改成本地 `socks` 的 `ip`
``` conf
server = 127.0.0.1
```

# 运行
``` bash
nohup tsocks 你的程序 &
```
