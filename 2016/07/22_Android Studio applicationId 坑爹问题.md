昨天还好用的代码, 今天运行 居然就挂掉了?  

安装 apk 的时候 出现了 `INSTALL_FAILED_INVALID_URI`,  
Google 了一下, 我去, 无解!!!  

于是乎 不停地清理 后错误 居然 坑爹地变了.  

贴一下 最后这一次 的 问题:  

``` xml
Installation failed with message INSTALL_PARSE_FAILED_BAD_PACKAGE_NAME: Invalid manifest package: must have at least one '.' separator.
It is possible that this issue is resolved by uninstalling an existing version of the apk if it is present, and then re-installing.

WARNING: Uninstalling will remove the application data!

Do you want to uninstall the existing application?
```

哎, 这次可以发现问题之所在.  
居然是 `packageName` 有问题.  
嗯?????????????  
什么鬼 怎么可能 =_ =...  

然而突然灵感一现, 想到了 `applicationId`.  
默认和 `packageName` 是一样的.  
打开 module 的 `build.gradle`,  
我去 什么鬼, `applicationId ` 自己变了...  

哎 改了一下之后, 又 立竿见影...  
