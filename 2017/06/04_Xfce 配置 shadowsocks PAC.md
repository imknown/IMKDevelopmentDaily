# 第一步: shadowsocks-qt5
1. 安装 [`shadowsocks-qt5`][shadowsocks-qt5]
1. 配置 `shadowsocks-qt5`, 如 `'socks5 127.0.0.1:1080'`
1. 连接服务器

[shadowsocks-qt5]: https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/06/03_shadowsocks%20%E9%A1%B9%E7%9B%AE%20%E5%AE%A2%E6%88%B7%E7%AB%AF.md

# 第二步: 生成 PAC
1. 安装 [`genpac`][genpac]

[genpac]: https://github.com/JinnLynn/GenPAC

   ``` bash
   pip install genpac
   ```

1. 生成 PAC 文件 (官网文档已过时, 自行 `--help`)
``` bash
genpac --gfwlist-proxy "SOCKS5 127.0.0.1:1080" --proxy "SOCKS5 127.0.0.1:1080" --output "gfwlist.pac"
```

### Update 2017-06-08
关于 白名单:
- https://github.com/breakwa11/gfw_whitelist
- https://github.com/R0uter/gfw_domain_whitelist

# 第三步: 导入系统
### Ubuntu: 自动
选择 `设置` 中的 `网络代理`, 选择 "自动",  
填入 `file:///Path/to/your/gfwlist.pac`, 应用即可.

### Xubuntu: 手动
``` bash
sudo gedit /etc/environment
```

在 文件最后面 加入:
``` properties
auto_proxy="file:///Path/to/your/gfwlist.pac"
AUTO_PROXY="file:///Path/to/your/gfwlist.pac"
```

保存, 注销 后 生效...

# 第四步 (可选, 用于后期维护): 编辑 PAC
经常更换 `ss` 不可避免. 注意修改 `pac` 中 `代理协议` 和 `ip 地址:端口` 等.  
一般在 `pac` 的开头 都可以找到.
