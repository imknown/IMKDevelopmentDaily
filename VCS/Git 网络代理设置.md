- 终端临时
``` bash
export http_proxy="http.proxy http://127.0.0.1:1080"
export https_proxy="https://127.0.0.1:1080"
```

- http
``` bash
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
```

- 客户端 支持 `Socks5` 的话 可以用
``` bash
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
```

- 屏蔽 SSL 认证
``` bash
git config --global http.sslverify false
```

- 取消
``` bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

# 参考
- https://www.cnblogs.com/jackyshan/p/5985590.html
- http://blog.csdn.net/dragoo1/article/details/39551335
- http://blog.csdn.net/wozaixiaoximen/article/details/48434853
- http://www.cnblogs.com/terrylin/p/3296428.html
