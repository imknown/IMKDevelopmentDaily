# 终端临时
https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/06/04_Xfce%20配置%20shadowsocks%20PAC.md#终端临时

# git
``` bash
# https(s)
git config --global http.proxy http://127.0.0.1:1081
git config --global https.proxy https://127.0.0.1:1081

# socks
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

# 特定网站
git config --global http.https://github.com socks5://127.0.0.1:1080
```

- 屏蔽 SSL 认证
``` bash
git config --global http.sslverify false
```

- 取消
``` bash
git config --global --unset http.proxy
git config --global --unset https.proxy

# 取消特定网站
git config --global --unset http.https://github.com
```

# 参考
- https://www.cnblogs.com/jackyshan/p/5985590.html
- http://blog.csdn.net/dragoo1/article/details/39551335
- http://blog.csdn.net/wozaixiaoximen/article/details/48434853
- http://www.cnblogs.com/terrylin/p/3296428.html
