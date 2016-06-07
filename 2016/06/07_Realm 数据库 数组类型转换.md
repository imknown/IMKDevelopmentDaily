既然 Realm 已经 1.0.0 了, 今天 顺便写了 一个 gradle 玩玩.  
好, 今天遇到一个 问题:  数组中 原始数据类型转换.  
这个问题 并不是我最先发现.  Realm 的 github 官网 早有 issue.  
现在 在 https://realm.io 可以 看到解决方案.  
具体参看 `Primitive lists` 章节.  
看其本质 大概是 把 已有 json 对象中的 数组原始数据类型,  
硬改成 自己编写的 `RealmString` 或者 `RealmInt` 之类的.  
源码很简单, 简单的包装, 重头戏 是 `Gson` 的 `TypeAdapter`.  
原理已经 在上面说过, 并不难读懂源码, 在此不再赘述了.  

##### 参考文档
* https://gist.github.com/cmelchior/1a97377df0c49cd4fca9
* https://realm.io/docs/java/latest/
