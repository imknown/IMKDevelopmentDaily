首先看官方文档:  
> https://github.com/subclipse/subclipse/wiki#installation  

先安装基础的东西, 在 `Eclipse` 里面 在线安装 即可:  
> https://dl.bintray.com/subclipse/releases/subclipse/latest/  

然后 发现 `Linux` `JavaHL` 没有涵盖在 上面的 更新包中,  
于是继续看官方文档:  
> https://github.com/subclipse/subclipse/wiki/JavaHL-on-Linux  

`Linux` 下 使用 `JavaHL` 需要通过命令安装:  
``` bash
sudo apt install libsvn-java
```

发现 并没有生成 文档说的 `/usr/lib/jni`.
于是查一下网络, 找到这篇文章:  
> http://blog.csdn.net/caib1109/article/details/51763520  

于是 在 `eclipse.ini` 的 最后一行 直接加上 `下面的参数` 即可:  
 ``` properies
 -Djava.library.path=/usr/lib/x86_64-linux-gnu/jni
 ```
 `-vmargs` 这个 `eclipse.ini` 里面 上面已经有了,  
 不需要重复写, 不然启动不起来.

参看:  
https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/08/31_Eclipse%20SVN%20插件%20使用文档.md
