昨天的时候 `Android Studio 2.1.3 正式版` 来了.  
> http://tools.android.com/recent/androidstudio213isavailable  
> http://tools.android.com/download/studio/builds/2-1-3  

看他说 整合了 `Gradle 2.14.1`, 还挺新的, 好奇的我 决定试一试 `坑`.  

我是从 `2.1.2 正式版` 升级的 (此时 `Gradle` 还是 `2.10`).  
升级一切顺利, 然后 启动项目的时候, 掉坑里面了...  

# 2. 正常的时候
正常来说, 升级是可以平滑过渡的.  

如图所示, 虽然路径有问题,  
但是 点击 `Fix plugin version and sync project`,  
其实 `Android Studio 2.1.3` 自己会把 `2.10` 更新到 `2.14.1`.  

![启动 2.1.2 的项目 直接报错](/2016/08/17_启动%202.1.2%20的项目%20直接报错.png)  

顺便说下, 点击第二个 连接, 可以看 兼容性文档:  
> http://tools.android.com/tech-docs/new-build-system/version-compatibility  

# 1. 不正常的时候
### 之所以 写 1, 是因为 其实我是 先解决 问题1, 再解决 问题2 的
但是 坑爹的问题 紧随而至. 我又开了 其他两个项目, 你妹...  
Gradle build 的时候, 就写着 `Refreshing 'XXXXX' Gradle project`,  
进度条狂转, 但是 我感觉 实际上 他并没有 执行 `task`,  
因为执行的话, 会在 进度条上面 会有一行小字, 显示 `当前 task 进度`.  

然后 偶然发现 Project 的 `build.gradle` 的  
``` groovy
dependencies {
    classpath 'com.android.tools.build:gradle:2.1.3'

    // NOTE: Do not place your application dependencies here; they belong
    // in the individual module build.gradle files
}
```
会报警告:  
`'dependencies' cannot be applied to '(groovy.lang.Closure)'`  

然后 `SO` 找到了这个:  
> http://stackoverflow.com/questions/29769988/dependencies-cannot-be-applied-to-groovy-lang-closure  

我和他的问题还不太一样. 尝试 阅读一下吧.  

看到了这个回答:  
> http://stackoverflow.com/a/32490472/32490472  
> http://stackoverflow.com/a/31714570/2782426  

发现我的 路径确实不对了, 毕竟 升级到了 `2.14.1`.  

![Gradle 版本没有同步](/2016/08/17_Gradle%20版本没有同步.png)  

但是这么改, 有个缺点, 就是 每个项目 都要求改一次,  
没有全局修改的 地方(还是我没找到??)  
而且 选择 `Use default gradle wrapper (recommended)` 之后 会秘制挂掉...  

仔细想 这两个答案 其实是 殊途同归的.  
只不过 第二个 可以在 `操作系统` 的 `文件管理器` 修改.  
从而绕开 Android Studio (因为 动不动 就会卡住或者崩溃).  

紧接着 又看到回答:  
> http://stackoverflow.com/a/35566205/2782426  

答案中的 `Invalidate Caches / Restart` 不能点, 凡点必死...  
删除 项目中的 `.gradle` 和 `build` 文件夹 之后 下次启动,  
问题依旧, 但是 `.gradle` 中的 版本 的确从 `2.10` 变成了 `2.14.1`,  
但是 问题依旧, 没有实质性改变.  

最后想到 4月份 同事遇到的 奇葩问题,  
于是试了试 删除了文件夹: `%HOMEPATH%\.gradle\caches\`.  
问题 貌似在 删除之后 就无法重现了.  
不删之前, 改到 `2.1.2` 就可以重现,  
看来 删除方法 是有效的, 就这么被我蒙到了?  

也可能是 运气成分, 不行的话,  
就进  `文件管理器` 修改 project 的 `build.gradle` 和 `gradle\wrapper\gradle-wrapper.properties` 吧.  
 
