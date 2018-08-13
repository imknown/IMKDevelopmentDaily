# 第一步: shadowsocks-qt5
1. 安装 [`shadowsocks-qt5`][shadowsocks-qt5]
1. 配置 `shadowsocks-qt5`, 如 `'SOCKS5 → 127.0.0.1:1080'`, `'HTTP(S) → 127.0.0.1:1081'`
1. 连接服务器

[shadowsocks-qt5]: https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/06/03_shadowsocks%20%E9%A1%B9%E7%9B%AE%20%E5%AE%A2%E6%88%B7%E7%AB%AF.md

# 第二步: 生成 PAC
**2018-01-24 Update**:  
官方已发布 `2.x` 版本.

1. 安装 [`genpac`][genpac]

[genpac]: https://github.com/JinnLynn/GenPAC

   ``` bash
   pip install genpac
   ```

2. 生成 PAC 文件 ~~(官网文档已过时, 自行 `--help`)~~
  - SOCKS5 协议
``` bash
genpac --gfwlist-proxy "SOCKS5 127.0.0.1:1080" --pac-proxy "SOCKS5 127.0.0.1:1080" --output "gfwlist-socks5.pac"
```

  - HTTP(S) 协议
``` bash
genpac --gfwlist-proxy "PROXY 127.0.0.1:1081" --pac-proxy "PROXY 127.0.0.1:1081" --output "gfwlist-http.pac"
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
sudo mousepad /etc/environment
```

在 文件最后面 加入:
``` properties
auto_proxy="file:///Path/to/your/gfwlist.pac"
AUTO_PROXY="file:///Path/to/your/gfwlist.pac"
```

执行:
``` bash
source /etc/environment
```

保存, 注销 后 生效...

# 第四步 (可选, 用于后期维护): 编辑 PAC
经常更换 `ss` 不可避免. 注意修改 `pac` 中 `代理协议` 和 `ip 地址:端口` 等.  
一般在 `pac` 的开头 都可以找到.

----

# 终端临时
- Windows
``` cmd
:: http(s)
set http_proxy='http://127.0.0.1:1081'
set https_proxy='https://127.0.0.1:1081'

:: socks5
set http_proxy='socks5://127.0.0.1:1080'
set https_proxy='socks5://127.0.0.1:1080'
```

- Linux
``` bash
# http(s)
export http_proxy=127.0.0.1:1081
export https_proxy=127.0.0.1:1081

# socks5
export http_proxy='socks5://127.0.0.1:1080'
export https_proxy='socks5://127.0.0.1:1080'
```

----

# 全局代理
### 浏览器的话, 可以装 `SwitchyOmega` 等插件

### ~~Proxifier~~

### [Privoxy](https://www.privoxy.org/)
1. 安装
``` bash
sudo apt install privoxy
```

2. 配置
``` bash
sudo gedit /etc/privoxy/config
```

``` config
#  4.1. listen-address
listen-address  127.0.0.1:8118
listen-address  [::1]:8118

forward-socks5 / 127.0.0.1:1080 .
forward / 127.0.0.1:1081 .
```

3. 关于服务: 启动/停止/状态...
``` bash
sudo service privoxy start
sudo service privoxy stop
sudo service privoxy status
sudo service privoxy restart
```

4. 使用
``` bash
# 也可以配置到环境变量, 参考:
# https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/10/14_Ubuntu 16 配置 ADB 环境变量.md
export http_proxy=http://127.0.0.1:8118
export https_proxy=http://127.0.0.1:8118
```

5. 测试
``` bash
curl google.com
```

返回如下内容 即表示成功:
``` html
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```

### polipo

### proxychains

### https://github.com/shadowsocks/shadowsocks/wiki
