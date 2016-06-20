今天在 `parcel` 踩坑了.  
我传递了 `intent` 传递 了一个 `String`:  

``` java
intent.putExtra(IConstances.ONE, myNameString);
```

然后 接收端 使用了:  
``` java
String myNameString = getIntent().getStringExtra(IConstances.ONE);
```

然后顺便报错:  
![parcel 错误 异常截图](/2016/06/20_parcel 错误 异常截图.png)

一开始用 https://global.bing.com 搜索 怎么搜也都不到,  

后来同事 发现 异常中 `parcel`, 仔细一看 传递 `myNameString` 的地方, 原来是 这样的啊:  
``` java
intent.putExtra(IConstances.Game, parcelableGameModel);
intent.putExtra(IConstances.ONE, myNameString);
```

于是 看了 `ParcelableGameModel` 的源码, 又用 谷歌 发现了 下面 这个 SO 答案:  
http://stackoverflow.com/questions/35588311/java-lang-illegalargumentexception-duplicate-key-in-arraymap-null  

于是 用 AS 重新生成了 需要的 静态对象 `CREATOR` 和 `writeToParcel()` 等,  
立竿见影, 果然有帮助, 于是问题迎刃而解.  
之前的 `writeToParcel()` 没有代码, 真心坑爹.  
不追究 责任了, 毕竟学到了 东西, 哈哈~  
还是 要 冷静, 认真分析问题 啊~

参考:  
- https://developer.android.com/reference/android/os/Parcel.html
- https://developer.android.com/reference/android/os/Parcelable.html
- https://developer.android.com/reference/android/os/Bundle.html
