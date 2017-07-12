### 安装
``` bash
sudo apt install vpnc

# 可选(GUI)
sudo apt install network-manager-vpnc

# 可选(GUI)
sudo apt install network-manager-vpnc-gnome
```

### 配置
sample.conf
``` conf
IPSec gateway <服务器>
IPSec ID <组ID>
IPSec secret <组密码>

Xauth username <用户名>
Xauth password <用户密码>
```

### 启动
**推荐使用 `自定义 conf 文件` 方式启动, 可以保存更多信息, 切换更加灵活.**
``` bash
sudo vpnc-connect sample.conf
# 或
sudo vpnc sample.conf
```

### 断开
``` bash
sudo vpnc-disconnect
```

参考:
- `vpnc --help` 或 `vpnc --long-help`
- https://wiki.gentoo.org/wiki/Vpnc
- https://wiki.archlinux.org/index.php/Vpnc
- https://en.wikipedia.org/wiki/Cisco_Systems_VPN_Client
- https://wiki.centos.org/HowTos/vpnc
