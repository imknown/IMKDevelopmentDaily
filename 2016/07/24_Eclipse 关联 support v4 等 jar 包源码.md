##### 本篇文章 是 Eclipse 的 遗产, 仅作备案.  

把 `你需要` 的 `同名 jar` 用到的 `properties 文件`, 放到 `libs` 下 即可.  
``` txt
android-support-v4.jar.properties
android-support-v7-appcompat.jar.properties
android-support-v13.jar.properties
android-support-v17-leanback.jar.properties
```

`你需要` 的 文件内 写上 `源码` 在 本地硬盘上的 `路径`, 例如:  
``` properties
src=X:\\Android\\sdk\\extras\\android\\support\\v4\\src
```
``` properties
src=X:\\Android\\support\\v7\\appcompat\\src
```
``` properties
src=X:\\Android\\sdk\\extras\\android\\support\\v13\\src
```
``` properties
src=X:\\Android\\sdk\\extras\\android\\support\\v17\\leanback\\src
```


源码可以从这里下载:  
https://github.com/android/platform_frameworks_support

### 参考: 
http://blog.csdn.net/xiaanming/article/details/9031141
