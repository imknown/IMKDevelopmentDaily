问题代码
```
<RelativeLayout
  <CardView />
  <ImageView />
</RelativeLayout>
```

简单解决方法 用同事的话说, 叫做 `拼爹`...  
就是在 `CardView` 外面一层 再套一层 `X`,  
然后让 `X` 跟 `ImageView` 同级 即可.  

此外, 还可以从根本的 `translationZ` 和 `elevation` 上解决.  
但是目前 这个方案 还没完全解决 `Android 4` 的问题.
