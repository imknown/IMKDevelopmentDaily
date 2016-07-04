上周周末 [absfree][absfree github] 问了好问题啊:  
[absfree github]: https://github.com/absfree

``` text
我用LruCache做图片的内存缓存，当LruCache缓存已满时，移除eldest，
是不是只是LruCache不再引用被移除的Bitmap了，
而如果那个Bitmap正在ImageView中显示的话，
相当于ImageView还引用着它，它不会被回收。我这样想的对吗？
```

于是 我各种 Google 和 SO, 总结如下:  

``` text
Bitmap 只要 不手动 recycle(), LruCache 也是拿它没有办法的
这个对象 还是会在 ImageView 中 保持 强引用的
但是 LruCache 中 的引用 会被 移除
```

他又说:  
``` text
内存缓存应该就是靠持有被缓存对象的引用来保证它们不会被回收吧
为啥收不到图片...
```

我想 大概是 java heap 和 c native heap 应该是分开的吧:  
``` text
因为 Bitmap 是 native 的 吧
不是 java 层面的
```

然后 他也有了结论:  
``` text 
如果缓存其他对象的话LruCache应该只是从内部LinkedHashMap中移除相应的引用吧，然后让GC回收这些不再被引用的对象。
```

我最后 也总结了一下:  
``` text
嗯 lru 不够用的时候 回收的只是hashmap 里面的 
意思是说 Bitmap 还在, 但是 不归 Lru 管理了 吧
```

- 哈哈 以上都是 我个人的 猜测, 没有 进行实践, 不保证 一定没有问题
- 有问题 大家一定要 告诉我啊, 我好 及时纠正 啊!! 谢谢~  
