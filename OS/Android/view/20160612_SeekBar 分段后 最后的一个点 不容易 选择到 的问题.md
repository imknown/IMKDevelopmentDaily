前几天就发现 `SeekBar` 使用 `android:max` 之后,  
滑杆的 最后一个值 特别难选中,  
尤其是 `android:width="match_parent"` 之后,  
虽然 `SeekBar` 自身也有 一定的 `padding`,  
找了一下 stackoverflow 没啥头绪,  
然后 百度了一下, 居然找到了...  
我也是无语了...  
原来, 原因是 父类 `AbsSeekBar` 代码中 L666 的 有一句话:

``` java
setProgress((int) progress, true);
```

好了, 问题的答案已经出来了...  
暂时没想到 什么 好的解决方案,  
除了完全重绘 控件...


参考资料
http://blog.csdn.net/huanxido/article/details/5941447
