``` bash
sudo gedit /etc/resolvconf/resolv.conf.d/base
```

加入 `nameserver 119.29.29.29`, 当然用其他的 DNS 也是可以的.

# 注意
不要再修改 `/etc/resolv.conf`, 这个貌似是 早期的 `Ubuntu` 修改方法.  
它会被 `VPN 连接` 等 覆写/拼接, 导致 没有写在 `hosts` 中的 `域名` 无法解析了.
