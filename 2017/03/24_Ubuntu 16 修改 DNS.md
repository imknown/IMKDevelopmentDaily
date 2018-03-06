# Update 2018-03-06
`Ubuntu` 直接修改 `网络配置` 即可:  
`IPv4 Settings` -> `Automatic (DHCP) addresses only` -> `DNS Servers`

# 以下为过时方法, 不要使用
``` bash
sudo gedit /etc/resolvconf/resolv.conf.d/base
```

加入 `nameserver 119.29.29.29` (当然用其他的 DNS 也是可以的).  
**建议后面加一个换行 防抽**, 然后执行:
``` bash
sudo resolvconf -u
```
再执行:
``` bash
sudo service network-manager restart
```

否则 `/etc/resolv.conf` 内容拼接可能不正确,  
例如出现 `nameserver 119.29.29.29nameserver 127.0.0.1`.
- 上述问题的解药: http://askubuntu.com/a/201613/626522


## 注意
不要再修改 `/etc/resolv.conf`, 这个貌似是 早期的 `Ubuntu` 修改方法.  
它会被 `VPN 连接` 等 覆写/拼接, 导致 没有写在 `hosts` 中的 `域名` 无法解析了.
