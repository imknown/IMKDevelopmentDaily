公司项目使用了 [`SwitchButton`][SwitchButton] 在 `RecyclerView` 当中.  
`Model` 类 中, 存放了 `ViewHolder` 对应的 `bool` 值,  
用来使 `Model` 与 `Item` 的 状态统一.  

但是 发现一个问题:  
就是 滑动 `RecyclerView` 的时候,   
由于 复用机制, 导致 `SwitchButton` 会不停地切换.  

一开始 是 以为 没有设置 `setOnCheckedChangeListener(null);` 的原因.  
后来 改了这个 bug 之后, 发现还是不对.  

但是 操作系统 什么的 都没有这个问题.  
换成 系统 support v7 的 `SwitchCompat` 也没问题.  
看了 一下 `SwitchButton` 源代码,  
原来 还有一个 方法叫做 `setCheckedImmediately(bool)`,  
恍然大悟, 试了一下, 立竿见影, 问题 迎刃而解.  

最后有一点 还需要搞定,  
就是为什么 系统的 `SwitchCompat` 没有这个问题.  
难道他判断 自己 是否处于 `RecyclerView`? 有待看源码...  

[SwitchButton]: https://github.com/kyleduo/SwitchButton
