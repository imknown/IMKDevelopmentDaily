昨天折腾了一晚上 终于 用 `OpenConnect` 自带的 命令行帮助 搞定了.  

# AnyConnect
因为 `Windows` 上面首选的是 `AnyConnect`,  
所以 一开始优先 折腾的 `AnyConnect`, 然后..  
各种碰壁 你妹的.. 谷歌出来的东西 看完 心力交瘁.  

> http://blog.csdn.net/lightboat09/article/details/50486920  
> https://www.auckland.ac.nz/en/for/current-students/cs-current-pg/cs-current-pg-support/vpn/cs-cisco-vpn-client-for-linux.html  

一开始安装都不正确, 要不是看了:
> http://www.socsci.uci.edu/~jstern/uci_vpn_ubuntu/  

可能 `AnyConnect` 装都没装明白.  

# OpenConnect
想起来 之前 [`@don-johnny`][don-johnny] 帮我远程 成功搭建过 `OpenConnect`,  
于是 便放弃了 神奇的 `AnyConnect`, 转战 `OpenConnect`.  

在谷歌上 搜一下吧, 找到了 这篇文章:  
> http://www.cnblogs.com/taofh/archive/2011/12/12/2284660.html

```bash
sudo apt install openconnect
```
搞定了 `OpenConnect` 安装.

(后来发现好像用 ppa 安装也是可以的, 没有 实测):  
> https://launchpad.net/ubuntu/+source/openconnect

然后 用了 `cnblogs` 文章教程里面的命令去 创建连接:  
(服务器 地址 和 端口 我就不写出来了 哈哈)
```bash
sudo openconnect -u imknown serverip:666
```

然后会报 奇怪的错误:  
![奇怪的错误](/2016/07/30_最初的连接失败.jpg)

于是 简单谷歌了 最后一句话, 说来也巧, 看到了 `bug #xxx` 就点进去了,  
`https://bugs.launchpad.net/ubuntu/+source/network-manager-openconnect/+bug/1247682`  
闲得没事 看完了 这个帖子, 万万没想到啊, 就是这个帖子 的 讨论,  
给了我启发, 让我恍然大悟, 于是便有了 本文的 第一句话.  

于是乎 迫不及待地 在 `Bash` 里面敲了:  
``` bash
openconnect -h
```
还真有 -c 和 -k, 手动指定了  服务器 给我的 数字证书 和 私钥,  
树藤摸瓜, 一下子就搞定了...  

所以, 总结的命令:  
``` bash
#从这里下载 https://launchpad.net/ubuntu/+source/openconnect
#或者 直接使用 `sudo apt install openconnect`
sudo openconnect <server hostname or ip>:<port> -u <AnyNameIsOk> -k <key file> -c <cert file>
```

# 后记
えぇぇぇぇぇ？ 话说 像 Windows AnyConnect 那样,  
直接导入 数字证书怎么搞,  
有待以后继续研究啊~  

其实中途 还遇到的 很多问题.  
比如说 我封装了 Shell 脚本, 居然会报 找不到文件的错误:  
![奇怪的错误](/2016/07/30_文夹目录结构.jpg)  

![奇怪的错误](/2016/07/30_相对路径路径 Shell 失败.jpg)  

![奇怪的错误](/2016/07/30_绝对路径 Shell 失败.jpg)  

至今没解决 哎...  

最后来一张 成功的 图片:  
![奇怪的错误](/2016/07/30_绝对路径终端成功.jpg)

[don-johnny]: https://github.com/don-johnny
